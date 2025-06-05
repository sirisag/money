import 'package:isar/isar.dart';

part 'driver_profile.g.dart';

@collection
class DriverProfile {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String driverPrimaryId; // The unique ID (5 digits) for this driver, links to AppUser.primaryId

  // Current travel advance balance held by the driver.
  // This can be negative if expenses exceed the advance.
  // Unit is Baht, integer.
  int travelAdvanceBalance = 0;

  // Timestamp of the last update to travelAdvanceBalance
  // (e.g., when receiving new advance or when treasurer processes expense report).
  DateTime? lastTravelAdvanceUpdateAt;
}
