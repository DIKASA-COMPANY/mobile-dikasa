part of 'view_model.dart';

class _DraftCommand {
  _DraftCommand(this.id, this.body, this.clearOnSuccess, {this.delete = false});
  final String? id;
  final Map<String, dynamic> body;
  final bool clearOnSuccess, delete;
}

/// Saved-order operations share the POS account guard and never discard uncertain work.
extension SavedOrderActions on NewOrderViewModelBase {
  bool get draftLocked => isSavingOrder || savedCommandUncertain || refundActive || cashClosingActive || cashMovementActive;
  String _requestId() {
    final bytes = List<int>.generate(16, (_) => Random.secure().nextInt(256));
    bytes[6] = (bytes[6] & 15) | 64;
    bytes[8] = (bytes[8] & 63) | 128;
    final h = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${h.substring(0, 8)}-${h.substring(8, 12)}-${h.substring(12, 16)}-${h.substring(16, 20)}-${h.substring(20)}';
  }

  void _clearDraft() {
    savedOrderId = null;
    savedOrderRevision = null;
    savedOrderLabel = null;
    reopenWarnings = ObservableList<String>();
    _reviewItems = null;
    _reviewOrder = null;
    _reviewType = null;
  }

  List<Map<String, dynamic>> _draftItems() => orderItems
      .map(
        (i) => <String, dynamic>{
          'product_id': i.product.id,
          'product_name': i.product.name,
          if (i.product.variantId != null)
            'product_variant_id': i.product.variantId,
          if (i.product.variantName != null)
            'variant_name': i.product.variantName,
          'unit_price': i.product.price,
          'quantity': i.quantity,
          'notes': i.note,
        },
      )
      .toList();
  Future<bool> saveOrder({String? label, bool clearOnSuccess = true}) async {
    _syncUser();
    if (isPaying || paymentUncertain || isSavingOrder || refundActive || cashClosingActive) return false;
    if (_pendingDraft != null) return retrySavedCommand();
    if (orderItems.isEmpty || orderType == null) {
      runInAction(
        () => checkoutError =
            'Tambahkan menu dan pilih jenis order terlebih dahulu.',
      );
      return false;
    }
    final body = <String, dynamic>{
      'request_id': _requestId(),
      'label': label ?? savedOrderLabel ?? '',
      'order_type_id': orderType!.id,
      if (savedOrderId != null) 'expected_revision': savedOrderRevision,
      'items': _draftItems(),
    };
    _pendingDraft = _DraftCommand(
      savedOrderId,
      jsonDecode(jsonEncode(body)) as Map<String, dynamic>,
      clearOnSuccess,
    );
    return _sendDraftCommand();
  }

  Future<bool> retrySavedCommand() async {
    _syncUser();
    if (isSavingOrder || refundActive || cashClosingActive ||
        isPaying ||
        paymentUncertain ||
        _pendingDraft == null) {
      return false;
    }
    return _sendDraftCommand();
  }

  Future<bool> _sendDraftCommand() async {
    final cmd = _pendingDraft!;
    final user = currentUser?.id;
    final generation = _draftGeneration;
    bool current() => currentUser?.id == user && generation == _draftGeneration;
    runInAction(() {
      isSavingOrder = true;
      checkoutError = null;
    });
    try {
      final SavedOrder result;
      if (cmd.delete) {
        result = await posService.deleteSavedOrder(
          cmd.id!,
          requestId: cmd.body['request_id'] as String,
          revision: cmd.body['expected_revision'] as int,
        );
      } else if (cmd.id == null) {
        result = await posService.createSavedOrder(cmd.body);
      } else {
        result = await posService.updateSavedOrder(cmd.id!, cmd.body);
      }
      if (!current()) return false;
      runInAction(() {
        _pendingDraft = null;
        savedCommandUncertain = false;
        if (cmd.delete) {
          if (savedOrderId == result.id) {
            orderItems.clear();
            orderType = null;
            _clearDraft();
          }
        } else if (cmd.clearOnSuccess) {
          orderItems.clear();
          orderType = null;
          _clearDraft();
        } else {
          savedOrderId = result.id;
          savedOrderRevision = result.revision;
          savedOrderLabel = result.label;
        }
      });
      return true;
    } on SavedCommandUncertainException {
      if (current()) {
        runInAction(() {
          savedCommandUncertain = true;
          checkoutError =
              'Status simpan/hapus belum pasti. Coba ulang permintaan yang sama untuk memastikannya.';
        });
      }
      return false;
    } on ApiException catch (e) {
      if (current()) {
        runInAction(() {
          _pendingDraft = null;
          savedCommandUncertain = false;
          if (e is SavedOrderApiException &&
              e.code == 'PESANAN_SUDAH_DIBAYAR' &&
              cmd.id == savedOrderId) {
            paymentUncertain = true;
          }
          checkoutError = e.message;
        });
      }
      return false;
    } finally {
      if (current()) runInAction(() => isSavingOrder = false);
    }
  }

  Future<bool> deleteSavedOrder(SavedOrder order) async {
    _syncUser();
    if (draftLocked || isPaying || paymentUncertain) return false;
    _pendingDraft = _DraftCommand(
      order.id,
      {'request_id': _requestId(), 'expected_revision': order.revision},
      false,
      delete: true,
    );
    return _sendDraftCommand();
  }

  Future<bool> openSavedOrder(String id, {bool acceptChanges = false}) async {
    _syncUser();
    if (draftLocked || isPaying || paymentUncertain) return false;
    if (orderItems.isNotEmpty) {
      runInAction(
        () => checkoutError =
            'Simpan atau hapus keranjang aktif sebelum membuka pesanan lain.',
      );
      return false;
    }
    if (acceptChanges && _reviewOrder?.id == id && _reviewItems != null) {
      _applyReviewedDraft();
      return true;
    }
    final user = currentUser?.id;
    final generation = _draftGeneration;
    bool current() => currentUser?.id == user && generation == _draftGeneration;
    runInAction(() {
      isSavingOrder = true;
      checkoutError = null;
      reopenWarnings.clear();
      _reviewOrder = null;
      _reviewItems = null;
    });
    try {
      final draft = await posService.savedOrder(id);
      if (!current()) return false;
      if (draft.status != 'open') {
        runInAction(
          () => checkoutError = draft.status == 'paid'
              ? 'Pesanan sudah dibayar. Struk: ${draft.transactionId}'
              : 'Pesanan sudah dihapus.',
        );
        return false;
      }
      final catalog = await _productRepository.getProducts(forceRefresh: true);
      final types = await posService.orderTypes();
      final tax = await posService.taxPercentage();
      if (!current() || orderItems.isNotEmpty) return false;
      final candidate = <OrderItem>[];
      final warnings = <String>[];
      for (final line in draft.items) {
        final matches = catalog.where((p) => p.id == line.productId);
        if (matches.isEmpty) {
          warnings.add(
            '${line.name}: produk tidak aktif/hilang; akan dihapus.',
          );
          continue;
        }
        var p = matches.first;
        if (line.variantId != null) {
          final variants = p.variations.where((v) => v.id == line.variantId);
          if (variants.isEmpty || !variants.first.isAvailable) {
            warnings.add(
              '${line.name} ${line.variantName ?? ''}: variasi tidak tersedia; akan dihapus.',
            );
            continue;
          }
          p = p.selectVariant(variants.first);
        }
        if (p.price != line.price) {
          warnings.add(
            '${p.displayName}: harga ${line.price} menjadi ${p.price}.',
          );
        }
        if (!p.isAvailable ||
            (p.trackStock &&
                draft.items
                        .where((i) => i.productId == p.id)
                        .fold<int>(0, (n, i) => n + i.quantity) >
                    p.stockQuantity)) {
          warnings.add(
            '${p.displayName}: periksa ketersediaan/stok sebelum membayar.',
          );
        }
        candidate.add(
          OrderItem(product: p, quantity: line.quantity, note: line.notes),
        );
      }
      final selected = types
          .where((t) => t.id == draft.orderTypeId)
          .firstOrNull;
      if (selected == null) {
        warnings.add('Jenis order tidak aktif. Pilih jenis order baru.');
      }
      runInAction(() {
        products = ObservableList<Product>.of(catalog);
        orderTypes = ObservableList<PosOrderType>.of(types);
        taxPercentage = tax;
        _reviewOrder = draft;
        _reviewItems = candidate;
        _reviewType = selected;
        reopenWarnings = ObservableList<String>.of(warnings);
      });
      if (warnings.isNotEmpty) return false;
      _applyReviewedDraft();
      return true;
    } on ApiException catch (e) {
      if (current()) runInAction(() => checkoutError = e.message);
      return false;
    } finally {
      if (current()) runInAction(() => isSavingOrder = false);
    }
  }

  void _applyReviewedDraft() {
    runInAction(() {
      final d = _reviewOrder!;
      orderItems = ObservableList<OrderItem>.of(_reviewItems!);
      orderType = _reviewType;
      savedOrderId = d.id;
      savedOrderRevision = d.revision;
      savedOrderLabel = d.label;
      reopenWarnings.clear();
      _reviewOrder = null;
      _reviewItems = null;
    });
  }

  void cancelSavedReview() {
    runInAction(() {
      _reviewOrder = null;
      _reviewItems = null;
      _reviewType = null;
      reopenWarnings.clear();
    });
  }

  Future<bool> reconcileSavedPayment() async {
    if (savedOrderId == null || isPaying || isSavingOrder) return false;
    final id = savedOrderId!;
    final user = currentUser?.id;
    final generation = _draftGeneration;
    runInAction(() => isSavingOrder = true);
    try {
      final d = await posService.savedOrder(id);
      if (currentUser?.id != user || generation != _draftGeneration) {
        return false;
      }
      runInAction(() {
        if (d.status == 'paid') {
          checkoutError = 'Pembayaran tercatat. Struk: ${d.transactionId}';
          orderItems.clear();
          orderType = null;
          _clearDraft();
          paymentUncertain = false;
        } else if (d.status == 'open') {
          paymentUncertain = false;
          checkoutError =
              'Pesanan masih belum dibayar. Periksa revisi sebelum mencoba lagi.';
        } else {
          checkoutError =
              'Pesanan sudah dihapus. Periksa Daftar Order sebelum melanjutkan.';
        }
      });
      if (d.status == 'paid') {
        await loadProducts(forceRefresh: true);
        if (currentUser?.id != user || generation != _draftGeneration) {
          return false;
        }
      }
      return d.status == 'paid';
    } on ApiException catch (e) {
      if (currentUser?.id == user && generation == _draftGeneration) {
        runInAction(() => checkoutError = e.message);
      }
      return false;
    } finally {
      if (currentUser?.id == user && generation == _draftGeneration) {
        runInAction(() => isSavingOrder = false);
      }
    }
  }
}
