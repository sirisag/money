import 'package:isar/isar.dart';

part 'driver_expense_record.g.dart';

// This annotation marks the class as an Isar collection.
@collection
class DriverExpenseRecord {
  // Isar automatically manages this ID as the primary key.
  Id id = Isar.autoIncrement;

  // Index for faster lookup by driverPrimaryId.
  @Index()
  late String driverPrimaryId; // Primary ID of the driver who recorded this expense

  late String expenseType; // Type of expense (e.g., "ค่าน้ำมัน", "ค่าทางด่วน")

  late int amount; // Amount of the expense (in Baht, integer)

  late DateTime
  date; // Date the expense occurred (time might not be necessary here)

  String? details; // Optional details about the expense

  // Status flag to track if this expense record has been exported to the treasurer.
  bool exportedToTreasurer = false;

  // Optional: Link back to DriverProfile if needed, but driverPrimaryId might be sufficient for now.
  // final driver = IsarLink<DriverProfile>();
}
