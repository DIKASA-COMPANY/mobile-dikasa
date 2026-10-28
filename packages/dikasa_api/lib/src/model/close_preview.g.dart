// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_preview.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ClosePreviewCWProxy {
  ClosePreview countedCash(int countedCash);

  ClosePreview difference(int difference);

  ClosePreview previewHash(String previewHash);

  ClosePreview reason(String reason);

  ClosePreview summary(ReconciliationSummary summary);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClosePreview(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClosePreview(...).copyWith(id: 12, name: "My name")
  /// ````
  ClosePreview call({
    int countedCash,
    int difference,
    String previewHash,
    String reason,
    ReconciliationSummary summary,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfClosePreview.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfClosePreview.copyWith.fieldName(...)`
class _$ClosePreviewCWProxyImpl implements _$ClosePreviewCWProxy {
  const _$ClosePreviewCWProxyImpl(this._value);

  final ClosePreview _value;

  @override
  ClosePreview countedCash(int countedCash) => this(countedCash: countedCash);

  @override
  ClosePreview difference(int difference) => this(difference: difference);

  @override
  ClosePreview previewHash(String previewHash) =>
      this(previewHash: previewHash);

  @override
  ClosePreview reason(String reason) => this(reason: reason);

  @override
  ClosePreview summary(ReconciliationSummary summary) => this(summary: summary);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClosePreview(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClosePreview(...).copyWith(id: 12, name: "My name")
  /// ````
  ClosePreview call({
    Object? countedCash = const $CopyWithPlaceholder(),
    Object? difference = const $CopyWithPlaceholder(),
    Object? previewHash = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? summary = const $CopyWithPlaceholder(),
  }) {
    return ClosePreview(
      countedCash: countedCash == const $CopyWithPlaceholder()
          ? _value.countedCash
          // ignore: cast_nullable_to_non_nullable
          : countedCash as int,
      difference: difference == const $CopyWithPlaceholder()
          ? _value.difference
          // ignore: cast_nullable_to_non_nullable
          : difference as int,
      previewHash: previewHash == const $CopyWithPlaceholder()
          ? _value.previewHash
          // ignore: cast_nullable_to_non_nullable
          : previewHash as String,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      summary: summary == const $CopyWithPlaceholder()
          ? _value.summary
          // ignore: cast_nullable_to_non_nullable
          : summary as ReconciliationSummary,
    );
  }
}

extension $ClosePreviewCopyWith on ClosePreview {
  /// Returns a callable class that can be used as follows: `instanceOfClosePreview.copyWith(...)` or like so:`instanceOfClosePreview.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ClosePreviewCWProxy get copyWith => _$ClosePreviewCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClosePreview _$ClosePreviewFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ClosePreview',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'counted_cash',
            'difference',
            'preview_hash',
            'reason',
            'summary',
          ],
        );
        final val = ClosePreview(
          countedCash: $checkedConvert(
            'counted_cash',
            (v) => (v as num).toInt(),
          ),
          difference: $checkedConvert('difference', (v) => (v as num).toInt()),
          previewHash: $checkedConvert('preview_hash', (v) => v as String),
          reason: $checkedConvert('reason', (v) => v as String),
          summary: $checkedConvert(
            'summary',
            (v) => ReconciliationSummary.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'countedCash': 'counted_cash',
        'previewHash': 'preview_hash',
      },
    );

Map<String, dynamic> _$ClosePreviewToJson(ClosePreview instance) =>
    <String, dynamic>{
      'counted_cash': instance.countedCash,
      'difference': instance.difference,
      'preview_hash': instance.previewHash,
      'reason': instance.reason,
      'summary': instance.summary.toJson(),
    };
