import 'package:isar/isar.dart';
import 'monk_profile.dart'; // Import the MonkProfile model
import 'app_user.dart'; // Import AppUser for roles

part 'transaction_record.g.dart';

// Define the type of transaction (deposit or withdrawal).
enum TransactionType { deposit, withdrawal }

// Define the source or method of the transaction.
enum TransactionSource {
  directTreasurer, // Transaction made directly by the Treasurer
  driverCollection, // Deposit collected by a Driver
  driverWithdrawal, // Withdrawal facilitated by a Driver
  notSpecified, // Source is not specified (e.g., for older records)
}

// This annotation marks the class as an Isar collection.
@collection
class TransactionRecord {
  // Isar automatically manages this ID as the primary key.
  Id id = Isar.autoIncrement;

  // Index for faster lookup by monkPrimaryId.
  @Index()
  late String monkPrimaryId; // Primary ID of the monk involved

  @enumerated
  late TransactionType type; // Type of transaction (deposit/withdrawal)

  late int amount; // Amount of the transaction (in Baht, integer)

  late DateTime dateTime; // Date and time the transaction occurred

  String? description; // Details or notes about the transaction

  @enumerated // Store the enum value as an integer
  TransactionSource source = TransactionSource.notSpecified; // Source of the transaction (cannot be nullable)

  String?
  processedByUserId; // Primary ID of the AppUser who processed this transaction
  @enumerated // Store the enum value as an integer
  UserRole processedByUserRole = UserRole.unknown; // Role of the AppUser, defaults to unknown

  bool driverCovered =
      false; // For driverWithdrawal: true if driver paid from their advance

  // Define a link back to the MonkProfile.
  final monk = IsarLink<MonkProfile>();
}
