import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:vachak/core/domain/entities/va_language_entity.dart';

@immutable
class VaLanguageModel extends VaLanguageEntity {
  final List<String>? supports;
  final int? lastUpdated;

  const VaLanguageModel({
    super.code,
    super.name,
    super.description,
    this.supports,
    this.lastUpdated,
  });

  @override
  String toString() {
    return 'VaLanguageModel(code: $code, name: $name, description: $description, supports: $supports, lastUpdated: $lastUpdated)';
  }

  factory VaLanguageModel.fromMap(Map<String, dynamic> data) {
    return VaLanguageModel(
      code: data['code'] as String?,
      name: data['name'] as String?,
      description: data['description'] as String?,
      supports: data['supports'] != null
          ? List<String>.from(data['supports'] as List)
          : [],
      lastUpdated:
          data['lastUpdated'] != null ? data['lastUpdated'] as int? : 0,
    );
  }

  factory VaLanguageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() ?? {};
    return VaLanguageModel.fromMap(data);
  }

  Map<String, dynamic> toMap() {
    return {
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (supports != null) 'supports': supports,
      if (lastUpdated != null) 'lastUpdated': lastUpdated,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! VaLanguageModel) return false;
    return code == other.code;
  }

  @override
  int get hashCode => code.hashCode;
}
