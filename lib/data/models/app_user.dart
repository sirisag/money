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
  AppUser(); // Add unnamed constructor

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

  // --- JSON Serialization ---
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'primaryId': primaryId,
      'secondaryId': secondaryId,
      'role': role.name, // Store enum as string (its name)
      'displayName': displayName,
      // IMPORTANT: Decide if hashedPassword should be included in backups.
      // For security, it's often better NOT to include raw hashed passwords in general backups
      // unless the backup file itself is extremely well-protected and encrypted.
      // If included, ensure the backup file's encryption is very strong.
      // 'hashedPassword': hashedPassword, // Consider security implications
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    final user = AppUser()
      ..id = json['id'] as int? ?? Isar.autoIncrement
      ..primaryId = json['primaryId'] as String
      ..secondaryId = json['secondaryId'] as String
      ..role = UserRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserRole.unknown, // Default if role string is not found
      )
      ..displayName = json['displayName'] as String?;
    // Do NOT typically restore hashedPassword directly from a general backup like this
    // unless it's a system handover/restore process with specific security measures.
    // ..hashedPassword = json['hashedPassword'] as String?;
    return user;
  }
}
