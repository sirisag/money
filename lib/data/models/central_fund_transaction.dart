import 'package:isar/isar.dart';

part 'central_fund_transaction.g.dart';

// Define the types of transactions for the Central Fund.
enum CentralFundTransactionType {
  donation, // Money received as donation
  templeExpense, // Money spent for temple expenses
  issueDriverAdvance, // Money given to a driver as advance
  receiveDriverAdvanceReturn, // Money returned by a driver from advance
  reimburseDriverForExpense, // Money paid back to a driver for expenses they covered
}

// This annotation marks the class as an Isar collection.
@collection
class CentralFundTransaction {
  // Isar automatically manages this ID as the primary key.
  Id id = Isar.autoIncrement;

  @enumerated
  late CentralFundTransactionType type; // Type of central fund transaction

  late int amount; // Amount of the transaction (in Baht, integer).
  // Positive for income (donation, advance return), negative for expense (temple expense, advance issue, reimbursement).

  late DateTime dateTime; // Date and time the transaction occurred

  String? description; // Details or notes about the transaction

  String?
  relatedDriverId; // Primary ID of the driver involved (if type is related to driver advance/reimbursement)
  String?
  relatedMonkId; // Primary ID of the monk involved (if applicable, e.g., expense for monk's medical bill)

  late String
  processedByTreasurerId; // Primary ID of the Treasurer who processed this transaction

  // Optional: Store the balance after this transaction for easier history viewing.
  // This can be negative.
  int? balanceAfter;
}
