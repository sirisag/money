import 'package:isar/isar.dart';

// This line tells the Isar generator to create the necessary code for this file.
// We will run the generator later after creating all model files.
part 'app_user.g.dart';

// Define the roles for users in the application.
enum UserRole {
  treasurer,
  driver,
  monk,
  unknown, // Added for default/unknown cases
}

// This annotation marks the class as an Isar collection (a table in database terms).
@collection
class AppUser {
  // Isar automatically manages this ID as the primary key for the collection.
  Id id = Isar.autoIncrement;

  // These indexes are created for faster lookups and to ensure uniqueness.
  @Index(unique: true, caseSensitive: false)
  late String primaryId; // The unique ID (4, 5, or 6 digits)

  @Index(unique: true, caseSensitive: false)
  late String secondaryId; // The secondary unique ID

  // The role of the user in the application.
  @enumerated
  late UserRole role;

  String? displayName; // Display name for Treasurer and Driver

  String? hashedPassword; // For treasurer and driver login
}
