import 'package:isar/isar.dart';
import 'monk_profile.dart'; // Import the MonkProfile model
import 'app_user.dart'; // Import AppUser for roles

part 'transaction_record.g.dart';

// Define the type of transaction (deposit or withdrawal).
enum TransactionType {
  deposit,
  withdrawal,
  unknown, // Added for default/error cases
}

// Define the source or method of the transaction.
enum TransactionSource {
  directTreasurer, // Transaction made directly by the Treasurer
  driverCollection, // Deposit collected by a Driver
  driverWithdrawal, // Withdrawal facilitated by a Driver
  notSpecified, // Source is not specified (e.g., for older records)
  unknown, // Added for default/error cases
}

// This annotation marks the class as an Isar collection.
@collection
class TransactionRecord {
  TransactionRecord(); // Add unnamed constructor

  // Isar automatically manages this ID as the primary key.
  Id id = Isar.autoIncrement;

  // Index for faster lookup by monkPrimaryId.
  @Index()
  late String monkPrimaryId; // Primary ID of the monk involved

  // Index for faster lookup by driverPrimaryId (if applicable).
  @Index()
  String? driverPrimaryId; // Primary ID of the driver involved, if any

  @enumerated
  late TransactionType type; // Type of transaction (deposit/withdrawal)

  late int amount; // Amount of the transaction (in Baht, integer)

  String? description; // Details or notes about the transaction

  @enumerated // Store the enum value as an integer
  TransactionSource source = TransactionSource.notSpecified; // Source of the transaction

  String?
  processedByUserId; // Primary ID of the AppUser who processed this transaction
  @enumerated // Store the enum value as an integer
  UserRole processedByUserRole = UserRole.unknown; // Role of the AppUser, defaults to unknown

  bool driverCovered =
      false; // For driverWithdrawal: true if driver paid from their advance

  // Define a link back to the MonkProfile.
  final monk = IsarLink<MonkProfile>();

  @Index()
  late DateTime dateTime; // Date and time of the transaction

  // --- JSON Serialization ---
  Map<String, dynamic> toJson() {
    return {
      'id': id == Isar.autoIncrement
          ? null
          : id, // Don't include auto-increment ID if not set
      'monkPrimaryId': monkPrimaryId,
      'driverPrimaryId': driverPrimaryId,
      'type': type.name,
      'amount': amount,
      'description': description,
      'source': source.name,
      'processedByUserId': processedByUserId,
      'processedByUserRole': processedByUserRole.name,
      'driverCovered': driverCovered,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory TransactionRecord.fromJson(Map<String, dynamic> json) {
    // Helper to safely parse enum from string
    T _enumFromString<T>(List<T> values, String? value, T defaultValue) {
      if (value == null) return defaultValue;
      try {
        return values.firstWhere(
          (type) =>
              type.toString().split('.').last == value ||
              (type as Enum).name == value,
          orElse: () => defaultValue,
        );
      } catch (e) {
        return defaultValue;
      }
    }

    return TransactionRecord()
      // id is auto-incremented by Isar, usually not set from JSON unless for specific update logic
      // ..id = json['id'] as int? ?? Isar.autoIncrement
      ..monkPrimaryId = json['monkPrimaryId'] as String
      ..driverPrimaryId = json['driverPrimaryId'] as String?
      ..type = _enumFromString(
        TransactionType.values,
        json['type'] as String?,
        TransactionType.unknown,
      )
      ..amount = (json['amount'] as num)
          .toInt() // Changed to toInt()
      ..description = json['description'] as String?
      ..source = _enumFromString(
        TransactionSource.values,
        json['source'] as String?,
        TransactionSource.notSpecified,
      )
      ..processedByUserId = json['processedByUserId'] as String?
      ..processedByUserRole = _enumFromString(
        UserRole.values,
        json['processedByUserRole'] as String?,
        UserRole.unknown,
      )
      ..driverCovered = json['driverCovered'] as bool? ?? false
      ..dateTime = DateTime.parse(json['dateTime'] as String);
  }
}
