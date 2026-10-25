import 'dart:typed_data';
import 'cash_reconciliation.dart';

/// One frozen command owns its bytes; each retry rebuilds an equivalent multipart body.
class PendingCashMovement {
  PendingCashMovement({
    required this.sessionId,
    required this.requestId,
    required this.kind,
    required this.name,
    required this.amount,
    required this.reason,
    Uint8List? proofBytes,
    this.proofName,
    this.reverseId,
  }) : proofBytes = proofBytes == null
           ? null
           : Uint8List.fromList(proofBytes).asUnmodifiableView();
  final String sessionId, requestId, kind, name, reason;
  final int amount;
  final Uint8List? proofBytes;
  final String? proofName, reverseId;
}

class CashMovementRecord {
  CashMovementRecord.fromJson(this.json) {
    for (final k in [
      'id',
      'session_id',
      'request_id',
      'created_by',
      'created_at',
      'kind',
      'name',
      'reason',
    ]) {
      if (json[k] is! String || (json[k] as String).isEmpty) {
        throw const FormatException('Missing movement identity');
      }
    }
    if (amount < 1 || !['in', 'out'].contains(kind)) {
      throw const FormatException('Invalid movement');
    }
  }
  final Map<String, dynamic> json;
  String get id => json['id'] as String;
  String get sessionId => json['session_id'] as String;
  String get requestId => json['request_id'] as String;
  String get kind => json['kind'] as String;
  int get amount => cashNumber(json['amount']);
  bool get hasProof => json['has_proof'] == true;
}

class CashMovementDetail {
  CashMovementDetail.fromJson(Map<String, dynamic> j)
    : record = CashMovementRecord.fromJson(
        Map<String, dynamic>.from(j['movement'] as Map),
      ),
      canReverse = j['can_reverse'] == true,
      reversedById = j['reversed_by_id'] as String?;
  final CashMovementRecord record;
  final bool canReverse;
  final String? reversedById;
}

class CashActivity {
  CashActivity.fromJson(Map<String, dynamic> j)
    : session = CashSessionRecord.fromJson(
        Map<String, dynamic>.from(j['data']['session'] as Map),
      ),
      totals = j['data']['totals'] == null
          ? null
          : Map<String, dynamic>.from(j['data']['totals'] as Map),
      events = (j['data']['events'] as List)
          .map((v) => Map<String, dynamic>.from(v as Map))
          .toList(),
      canCreate = j['data']['capabilities']['can_create'] == true,
      canUploadProof = j['data']['capabilities']['can_upload_proof'] == true,
      page = cashNumber(j['meta']['page']),
      total = cashNumber(j['meta']['total']) {
    if (totals != null) {
      for (final k in [
        'opening',
        'cash_sales',
        'cash_refunds',
        'cash_in',
        'cash_out',
        'total_in',
        'total_out',
        'expected_cash',
        'movement_count',
      ]) {
        cashNumber(totals![k]);
      }
    }
    for (final e in events) {
      cashNumber(e['amount']);
      if (e['id'] is! String || e['source_id'] is! String) {
        throw const FormatException('Invalid activity identity');
      }
    }
  }
  final CashSessionRecord session;
  final Map<String, dynamic>? totals;
  final List<Map<String, dynamic>> events;
  final bool canCreate, canUploadProof;
  final int page, total;
}
