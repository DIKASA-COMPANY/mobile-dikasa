import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/app_loading_indicator.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/pos.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'package:mobile_dikasa/core/routing/app_routes.dart';
import 'browser_design.dart';
import 'browser_page_header.dart';
import 'browser_empty_state.dart';
import 'customer_browser_body.dart';
import 'paid_orders_table.dart';
import 'receipt_detail_dialog.dart';
import 'saved_orders_browser.dart';

/// Figma full-page browsing; searches and filters are evaluated by the API.
class SalesBrowser extends StatefulWidget {
  const SalesBrowser({
    super.key,
    required this.viewModel,
    this.customers = false,
  });
  final NewOrderViewModel viewModel;
  final bool customers;
  static Future<void> show(
    BuildContext c,
    NewOrderViewModel vm, {
    bool customers = false,
  }) => Navigator.push<void>(
    c,
    MaterialPageRoute(
      builder: (_) => SalesBrowser(viewModel: vm, customers: customers),
    ),
  );
  @override
  State<SalesBrowser> createState() => _SalesBrowserState();
}

class _SalesBrowserState extends State<SalesBrowser> {
  final _search = TextEditingController();
  late Future<PosPage> _result;
  int _page = 1, _savedRefresh = 0;
  bool _savedTab = false;
  String? _status, _type;
  NewOrderViewModel get vm => widget.viewModel;
  late final _generation = vm.authRepository.sessionGeneration;
  late final _account = vm.currentUser?.id;
  bool get current =>
      _generation == vm.authRepository.sessionGeneration &&
      _account == vm.currentUser?.id;
  bool get locked => vm.draftLocked || vm.isPaying;
  @override
  void initState() {
    super.initState();
    _result = _fetch();
    vm.authRepository.addListener(_sessionChanged);
  }

  void _sessionChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    vm.authRepository.removeListener(_sessionChanged);
    _search.dispose();
    super.dispose();
  }

  Future<PosPage> _fetch() => widget.customers
      ? vm.posService.customers(search: _search.text, page: _page)
      : vm.posService.orders(
          search: _search.text,
          page: _page,
          status: _status,
          orderTypeId: _type,
        );
  void _reload({bool reset = false}) {
    if (!current) return;
    setState(() {
      if (reset) _page = 1;
      _result = _fetch();
    });
  }

  void _back() {
    if (!locked) Navigator.pop(context);
  }

  void _lock() {
    if (locked || vm.paymentUncertain) return;
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
  }

  Future<void> _filters() async {
    var status = _status, type = _type;
    final apply = await showDialog<bool>(
      context: context,
      builder: (c) => StatefulBuilder(
        builder: (c, update) => AlertDialog(
          title: const Text('Filter List Order'),
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: status,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: const [
                    DropdownMenuItem(value: null, child: Text('Semua status')),
                    DropdownMenuItem(value: 'paid', child: Text('Dibayar')),
                    DropdownMenuItem(
                      value: 'partially_refunded',
                      child: Text('Refund sebagian'),
                    ),
                    DropdownMenuItem(
                      value: 'refunded',
                      child: Text('Dikembalikan'),
                    ),
                    DropdownMenuItem(
                      value: 'cancelled',
                      child: Text('Dibatalkan'),
                    ),
                  ],
                  onChanged: (v) => update(() => status = v),
                ),
                DropdownButtonFormField<String>(
                  initialValue: type,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Jenis order'),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('Semua jenis'),
                    ),
                    ...vm.orderTypes.map(
                      (t) =>
                          DropdownMenuItem(value: t.id, child: Text(t.label)),
                    ),
                  ],
                  onChanged: (v) => update(() => type = v),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c, false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(c, true),
              child: const Text('Terapkan'),
            ),
          ],
        ),
      ),
    );
    if (mounted && current && !locked && apply == true) {
      _status = status;
      _type = type;
      _reload(reset: true);
    }
  }

  Widget _customerAction(String title, {bool add = false}) => Tooltip(
    message: add
        ? 'Penambahan pelanggan ditunda.'
        : 'Pemilihan pelanggan untuk pesanan ditunda.',
    child: SizedBox(
      height: 46.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: add ? Colors.white : Colors.transparent,
          disabledForegroundColor: add ? browserInk : Colors.white,
          side: BorderSide(color: Colors.white, width: 2.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        ),
        onPressed: null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (add) ...[const BrowserDesignIcon('add'), SizedBox(width: 16.w)],
            Text(title, style: TextStyle(fontSize: 18.sp)),
          ],
        ),
      ),
    ),
  );
  Widget _tabs() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
    child: Row(
      children: [
        SegmentedButton<bool>(
          showSelectedIcon: false,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
                  ? browserAction
                  : Colors.white,
            ),
            foregroundColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
                  ? Colors.white
                  : browserInk,
            ),
          ),
          segments: const [
            ButtonSegment(value: false, label: Text('Dibayar')),
            ButtonSegment(value: true, label: Text('Tersimpan')),
          ],
          selected: {_savedTab},
          onSelectionChanged: locked
              ? null
              : (v) => setState(() => _savedTab = v.single),
        ),
        const Spacer(),
        IconButton(
          tooltip: 'Muat ulang',
          onPressed: locked
              ? null
              : () => _savedTab ? setState(() => _savedRefresh++) : _reload(),
          icon: const Icon(Icons.refresh),
        ),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) => Observer(
    builder: (_) {
      final navigationBlocked = locked;
      if (!current) {
        return Scaffold(
          appBar: AppBar(title: const Text('Sesi berubah')),
          body: const Center(
            child: Text('Masuk kembali untuk melihat daftar.'),
          ),
        );
      }
      return PopScope(
        canPop: !navigationBlocked,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: BrowserPageHeader(
            title: widget.customers ? 'Pelanggan' : 'Daftar Order',
            user: vm.currentUser,
            onBack: locked ? null : _back,
            onLock: locked || vm.paymentUncertain ? null : _lock,
          ),
          body: Column(
            children: [
              if (!(_savedTab && !widget.customers))
                BrowserToolbar(
                  title: widget.customers
                      ? 'Pelanggan Terdaftar'
                      : 'Daftar Order',
                  onBack: locked ? null : _back,
                  search: BrowserSearch(
                    controller: _search,
                    hint: widget.customers ? 'Cari Pelanggan' : 'Cari Order',
                    onSearch: locked ? null : () => _reload(reset: true),
                  ),
                  actions: widget.customers
                      ? [
                          _customerAction('Tanpa Pelanggan'),
                          _customerAction('Tambah', add: true),
                        ]
                      : [
                          SizedBox(
                            width: 270.w,
                            height: 46.h,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: browserInk,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              onPressed: locked ? null : _filters,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _status == null && _type == null
                                          ? 'Filter List Order'
                                          : 'Filter aktif',
                                      style: TextStyle(fontSize: 18.sp),
                                    ),
                                  ),
                                  const BrowserDesignIcon('down'),
                                ],
                              ),
                            ),
                          ),
                        ],
                ),
              if (!widget.customers && !_savedTab) _tabs(),
              Expanded(
                child: _savedTab && !widget.customers
                    ? SavedOrdersBrowser(
                        key: ValueKey(_savedRefresh),
                        viewModel: vm,
                        navigation: _tabs(),
                      )
                    : FutureBuilder<PosPage>(
                        future: _result,
                        builder: (c, s) {
                          if (!current) return const SizedBox.shrink();
                          if (s.connectionState != ConnectionState.done) {
                            return const Center(child: AppLoadingIndicator());
                          }
                          if (s.hasError) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    s.error is ApiException
                                        ? (s.error as ApiException).message
                                        : 'Daftar gagal dimuat.',
                                  ),
                                  TextButton(
                                    onPressed: () => _reload(),
                                    child: const Text('Coba lagi'),
                                  ),
                                ],
                              ),
                            );
                          }
                          final p = s.requireData;
                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                              46,
                              widget.customers ? 32 : 14,
                              46,
                              0,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: p.items.isEmpty
                                      ? BrowserEmptyState(
                                          customers: widget.customers,
                                          searching:
                                              _search.text.trim().isNotEmpty ||
                                              _status != null ||
                                              _type != null,
                                        )
                                      : widget.customers
                                      ? CustomerBrowserBody(page: p)
                                      : PaidOrdersTable(
                                          page: p,
                                          actionsBlocked:
                                              locked || vm.paymentUncertain,
                                          onDetail: (id) async {
                                            await ReceiptDetailDialog.show(
                                              context,
                                              vm,
                                              id,
                                            );
                                            if (mounted && current) _reload();
                                          },
                                        ),
                                ),
                                if (widget.customers)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      tooltip: 'Muat ulang',
                                      onPressed: locked ? null : _reload,
                                      icon: const Icon(Icons.refresh),
                                    ),
                                  ),
                                BrowserFooter(
                                  page: _page,
                                  total: p.total,
                                  onPrevious: !locked && _page > 1
                                      ? () {
                                          _page--;
                                          _reload();
                                        }
                                      : null,
                                  onNext: !locked && _page * 20 < p.total
                                      ? () {
                                          _page++;
                                          _reload();
                                        }
                                      : null,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
