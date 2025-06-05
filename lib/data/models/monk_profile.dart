import 'package:isar/isar.dart';
import 'transaction_record.dart'; // Import the TransactionRecord model

// This line tells the Isar generator to create the necessary code for this file.
part 'monk_profile.g.dart';

// Define the possible statuses for a monk's account.
enum MonkAccountStatus {
  active, // Currently residing at the temple and active
  moved, // Has moved to another temple
  resigned, // Has left monkhood
}

// This annotation marks the class as an Isar collection.
@collection
class MonkProfile {
  // Isar automatically manages this ID as the primary key.
  Id id = Isar.autoIncrement;

  // Index for faster lookup by monkPrimaryId.
  @Index(unique: true)
  late String monkPrimaryId; // The unique ID (6 digits) for this monk

  String? monkName; // Name or monastic name of the monk
  String? contactInfo; // Optional contact information

  @enumerated // Store the enum value as an integer
  MonkAccountStatus status = MonkAccountStatus.active; // Default status is active

  int currentBalance =
      0; // Current balance of the monk's funds (in Baht, integer, can be negative)

  // Define a link to TransactionRecord.
  // This creates a many-to-many or one-to-many relationship.
  // In this case, one MonkProfile can have many TransactionRecords.
  @Backlink(to: 'monk') // 'monk' is the name of the link in TransactionRecord
  final transactions = IsarLinks<TransactionRecord>();

  DateTime?
  lastUpdatedAt; // Timestamp of the last update (e.g., from Treasurer's file)
}
