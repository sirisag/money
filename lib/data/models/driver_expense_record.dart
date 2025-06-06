import 'package:isar/isar.dart';

part 'driver_expense_record.g.dart';

// This annotation marks the class as an Isar collection.
@collection
class DriverExpenseRecord {
  DriverExpenseRecord(); // Add unnamed constructor

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

  // --- JSON Serialization ---
  Map<String, dynamic> toJson() {
    return {
      'id': id == Isar.autoIncrement ? null : id,
      'driverPrimaryId': driverPrimaryId,
      'expenseType': expenseType,
      'amount': amount,
      'date': date.toIso8601String(),
      'details': details,
      'exportedToTreasurer': exportedToTreasurer,
    };
  }

  factory DriverExpenseRecord.fromJson(Map<String, dynamic> json) {
    return DriverExpenseRecord()
      // id is auto-incremented by Isar
      // ..id = json['id'] as int? ?? Isar.autoIncrement
      ..driverPrimaryId = json['driverPrimaryId'] as String
      ..expenseType = json['expenseType'] as String
      ..amount = (json['amount'] as num)
          .toInt() // Assuming amount is stored as int
      ..date = DateTime.parse(json['date'] as String)
      ..details = json['details'] as String?
      ..exportedToTreasurer = json['exportedToTreasurer'] as bool? ?? false;
  }
}
