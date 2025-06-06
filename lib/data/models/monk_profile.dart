// In d:\Dev\money\lib\data\models\monk_profile.dart

import 'package:isar/isar.dart';
import 'app_user.dart'; // Assuming AppUser is in the same directory or imported correctly

part 'monk_profile.g.dart'; // Generated by Isar

enum MonkAccountStatus {
  active,
  moved, // ย้ายวัด
  resigned, // ลาสิกขา
  unknown;

  String get displayName {
    switch (this) {
      case MonkAccountStatus.active:
        return 'ใช้งานอยู่';
      case MonkAccountStatus.moved:
        return 'ย้ายวัด';
      case MonkAccountStatus.resigned:
        return 'ลาสิกขา';
      case MonkAccountStatus.unknown:
        return 'ไม่ทราบสถานะ';
      default:
        return '';
    }
  }
}

@Collection()
class MonkProfile {
  MonkProfile(); // Add unnamed constructor

  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String monkPrimaryId; // 6 digits, unique

  @Index(unique: true)
  String? monkSecondaryId; // 6 digits, unique, optional

  String? nameOrTitle;
  String? contactInfo; // e.g., Kuti number, contact person

  @Enumerated(EnumType.name)
  MonkAccountStatus status = MonkAccountStatus.active;

  int currentBalance = 0; // Changed to int

  final appUser = IsarLink<AppUser>();

  // --- JSON Serialization ---
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'monkPrimaryId': monkPrimaryId,
      'monkSecondaryId': monkSecondaryId,
      'nameOrTitle': nameOrTitle,
      'contactInfo': contactInfo,
      'status': status.name, // Store enum as string
      'currentBalance': currentBalance, // Stays as int
      // Note: IsarLink (appUser) is not directly serialized here.
      // If needed, you might serialize appUser.value.primaryId or similar.
      // For import, linking will be handled separately.
    };
  }

  factory MonkProfile.fromJson(Map<String, dynamic> json) {
    final profile = MonkProfile()
      ..id =
          json['id'] as int? ??
          Isar
              .autoIncrement // Handle if ID is not in JSON (new record)
      ..monkPrimaryId = json['monkPrimaryId'] as String
      ..monkSecondaryId = json['monkSecondaryId'] as String?
      ..nameOrTitle = json['nameOrTitle'] as String?
      ..contactInfo = json['contactInfo'] as String?
      ..status = MonkAccountStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => MonkAccountStatus.unknown,
      )
      ..currentBalance =
          (json['currentBalance'] as num?)?.toInt() ?? 0; // Changed to toInt()
    // appUser link needs to be established after deserialization,
    // typically by finding the AppUser by ID and setting appUser.value.
    return profile;
  }
}
