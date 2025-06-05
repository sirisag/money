import 'package:isar/isar.dart';

// Import the global Isar instance from main.dart
import '../../../main.dart';

// Import your data models (collections)
import '../../models/app_user.dart';
import '../../models/monk_profile.dart';
import '../../models/driver_profile.dart';
import '../../models/transaction_record.dart';
import '../../models/central_fund_transaction.dart';
import '../../models/driver_expense_record.dart';

class IsarService {
  // We don't need to open Isar here, as it's already opened in main.dart.
  // We just need to access the global 'isar' instance.

  // Get access to specific collections
  IsarCollection<AppUser> get users => isar.appUsers;
  IsarCollection<MonkProfile> get monks => isar.monkProfiles;
  IsarCollection<DriverProfile> get drivers => isar.driverProfiles;
  IsarCollection<TransactionRecord> get transactions => isar.transactionRecords;
  IsarCollection<CentralFundTransaction> get centralFundTransactions =>
      isar.centralFundTransactions;
  IsarCollection<DriverExpenseRecord> get driverExpenseRecords =>
      isar.driverExpenseRecords;

  /// Saves or updates an AppUser.
  /// If the user has an existing Isar ID, it will be updated.
  /// Otherwise, a new user will be created.
  Future<void> saveAppUser(AppUser user) async {
    await isar.writeTxn(() async {
      await users.put(user);
    });
  }

  /// Finds an AppUser by their primaryId.
  /// Returns null if no user is found.
  Future<AppUser?> getAppUserByPrimaryId(String primaryId) async {
    return await users.filter().primaryIdEqualTo(primaryId).findFirst();
  }

  /// Finds an AppUser by their Isar ID.
  /// Returns null if no user is found.
  Future<AppUser?> getAppUserById(Id id) async {
    return await users.get(id);
  }

  // --- MonkProfile Methods ---

  /// Saves or updates a MonkProfile.
  Future<void> saveMonkProfile(MonkProfile monk) async {
    await isar.writeTxn(() async {
      await monks.put(monk);
    });
  }

  /// Finds a MonkProfile by their monkPrimaryId.
  Future<MonkProfile?> getMonkProfileByPrimaryId(String monkPrimaryId) async {
    return await monks.filter().monkPrimaryIdEqualTo(monkPrimaryId).findFirst();
  }

  /// Gets all MonkProfiles.
  Future<List<MonkProfile>> getAllMonkProfiles() async {
    return await monks.where().findAll();
  }

  /// Deletes a MonkProfile by their Isar ID.
  Future<bool> deleteMonkProfile(Id id) async {
    bool deleted = false;
    await isar.writeTxn(() async {
      deleted = await monks.delete(id);
    });
    return deleted;
  }

  // --- DriverProfile Methods ---

  /// Saves or updates a DriverProfile.
  Future<void> saveDriverProfile(DriverProfile driver) async {
    await isar.writeTxn(() async {
      await drivers.put(driver);
    });
  }

  /// Finds a DriverProfile by their driverPrimaryId.
  Future<DriverProfile?> getDriverProfileByPrimaryId(
    String driverPrimaryId,
  ) async {
    return await drivers
        .filter()
        .driverPrimaryIdEqualTo(driverPrimaryId)
        .findFirst();
  }

  /// Gets all DriverProfiles.
  Future<List<DriverProfile>> getAllDriverProfiles() async {
    return await drivers.where().findAll();
  }

  /// Deletes a DriverProfile by their Isar ID.
  Future<bool> deleteDriverProfile(Id id) async {
    bool deleted = false;
    await isar.writeTxn(() async {
      deleted = await drivers.delete(id);
    });
    return deleted;
  }

  // --- TransactionRecord Methods ---

  /// Saves or updates a TransactionRecord.
  Future<void> saveTransactionRecord(TransactionRecord transaction) async {
    await isar.writeTxn(() async {
      await transactions.put(transaction);
    });
  }

  /// Gets all TransactionRecords for a specific monk.
  Future<List<TransactionRecord>> getTransactionsForMonk(
    String monkPrimaryId,
  ) async {
    return await transactions
        .filter()
        .monkPrimaryIdEqualTo(monkPrimaryId)
        .sortByDateTimeDesc() // Sort by date, newest first
        .findAll();
  }

  /// Gets all TransactionRecords.
  Future<List<TransactionRecord>> getAllTransactionRecords() async {
    return await transactions.where().sortByDateTimeDesc().findAll();
  }

  // --- CentralFundTransaction Methods ---

  /// Saves or updates a CentralFundTransaction.
  Future<void> saveCentralFundTransaction(
    CentralFundTransaction transaction,
  ) async {
    await isar.writeTxn(() async {
      await centralFundTransactions.put(transaction);
    });
  }

  /// Gets all CentralFundTransactions.
  Future<List<CentralFundTransaction>> getAllCentralFundTransactions() async {
    return await centralFundTransactions.where().sortByDateTimeDesc().findAll();
  }

  // --- DriverExpenseRecord Methods ---

  /// Saves or updates a DriverExpenseRecord.
  Future<void> saveDriverExpenseRecord(
    DriverExpenseRecord expenseRecord,
  ) async {
    await isar.writeTxn(() async {
      await driverExpenseRecords.put(expenseRecord);
    });
  }

  /// Gets all DriverExpenseRecords for a specific driver.
  Future<List<DriverExpenseRecord>> getExpensesForDriver(
    String driverPrimaryId,
  ) async {
    return await driverExpenseRecords
        .filter()
        .driverPrimaryIdEqualTo(driverPrimaryId)
        .sortByDateDesc() // Sort by date, newest first
        .findAll();
  }

  /// Gets all DriverExpenseRecords.
  Future<List<DriverExpenseRecord>> getAllDriverExpenseRecords() async {
    return await driverExpenseRecords.where().sortByDateDesc().findAll();
  }

  // You can add more specific query methods as needed for your application logic.
}
