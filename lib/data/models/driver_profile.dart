import 'package:isar/isar.dart';
import 'app_user.dart'; // Import AppUser

part 'driver_profile.g.dart';

@collection
class DriverProfile {
  DriverProfile(); // Add unnamed constructor

  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String driverPrimaryId; // The unique ID (5 digits) for this driver, links to AppUser.primaryId

  String? name;
  String? contactInfo;
  final appUser = IsarLink<AppUser>();

  // Current travel advance balance held by the driver.
  // This can be negative if expenses exceed the advance.
  // Unit is Baht, integer.
  int travelAdvanceBalance = 0;

  // Timestamp of the last update to travelAdvanceBalance
  // (e.g., when receiving new advance or when treasurer processes expense report).
  DateTime? lastTravelAdvanceUpdateAt;

  // --- JSON Serialization ---
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driverPrimaryId': driverPrimaryId,
      'name': name,
      'contactInfo': contactInfo,
      'travelAdvanceBalance': travelAdvanceBalance,
      'lastTravelAdvanceUpdateAt': lastTravelAdvanceUpdateAt?.toIso8601String(),
      // appUser link is not directly serialized.
    };
  }

  factory DriverProfile.fromJson(Map<String, dynamic> json) {
    final profile = DriverProfile()
      ..id = json['id'] as int? ?? Isar.autoIncrement
      ..driverPrimaryId = json['driverPrimaryId'] as String
      ..name = json['name'] as String?
      ..contactInfo = json['contactInfo'] as String?
      ..travelAdvanceBalance =
          (json['travelAdvanceBalance'] as num?)?.toInt() ?? 0
      ..lastTravelAdvanceUpdateAt = json['lastTravelAdvanceUpdateAt'] != null
          ? DateTime.parse(json['lastTravelAdvanceUpdateAt'] as String)
          : null;
    return profile;
  }
}
