import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:path_provider/path_provider.dart';

// Import all your Isar schema (data model) files here
// We will create these files in the next steps.
// For now, we'll comment them out to avoid errors if they don't exist yet.
import 'data/models/app_user.dart';
import 'data/models/central_fund_transaction.dart';
import 'data/models/driver_expense_record.dart';
import 'data/models/driver_profile.dart';
import 'data/models/monk_profile.dart';
import 'data/models/transaction_record.dart';

// Import your root app widget (we'll create this file next)
import 'app.dart';

/// Global Isar instance.
/// We will initialize this in the main function.
late Isar isar;

Future<void> main() async {
  // Ensure that Flutter bindings are initialized before calling native code.
  WidgetsFlutterBinding.ensureInitialized();

  // Get the application documents directory to store the Isar database.
  final dir = await getApplicationDocumentsDirectory();

  // Open the Isar database.
  // All schemas (collections) must be registered here.
  isar = await Isar.open(
    [
      AppUserSchema,
      MonkProfileSchema,
      DriverProfileSchema,
      TransactionRecordSchema,
      CentralFundTransactionSchema,
      DriverExpenseRecordSchema,
    ],
    directory: dir.path,
    name: 'moneyAppDB', // You can name your database
  );

  // Run the Flutter application.
  runApp(
    const ProviderScope(child: MyApp()), // Wrap MyApp with ProviderScope
  );
}
