import 'package:flutter/foundation.dart';

@immutable
class VaLanguageEntity {
  final String? code;
  final String? name;
  final String? description;

  const VaLanguageEntity({
    this.code,
    this.name,
    this.description,
  });

  @override
  String toString() {
    return 'VaLanguageEntity(code: $code, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! VaLanguageEntity) return false;
    return code == other.code;
  }

  @override
  int get hashCode => code.hashCode;
}
