// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proof_link.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProofLinkCWProxy {
  ProofLink url(String url);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProofLink(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProofLink(...).copyWith(id: 12, name: "My name")
  /// ````
  ProofLink call({String url});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProofLink.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProofLink.copyWith.fieldName(...)`
class _$ProofLinkCWProxyImpl implements _$ProofLinkCWProxy {
  const _$ProofLinkCWProxyImpl(this._value);

  final ProofLink _value;

  @override
  ProofLink url(String url) => this(url: url);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProofLink(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProofLink(...).copyWith(id: 12, name: "My name")
  /// ````
  ProofLink call({Object? url = const $CopyWithPlaceholder()}) {
    return ProofLink(
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
    );
  }
}

extension $ProofLinkCopyWith on ProofLink {
  /// Returns a callable class that can be used as follows: `instanceOfProofLink.copyWith(...)` or like so:`instanceOfProofLink.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProofLinkCWProxy get copyWith => _$ProofLinkCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProofLink _$ProofLinkFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ProofLink', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['url']);
      final val = ProofLink(url: $checkedConvert('url', (v) => v as String));
      return val;
    });

Map<String, dynamic> _$ProofLinkToJson(ProofLink instance) => <String, dynamic>{
  'url': instance.url,
};
