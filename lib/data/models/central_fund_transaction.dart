// In central_fund_transaction.dart

import 'package:isar/isar.dart';

part 'central_fund_transaction.g.dart';

// Define the types of transactions for the Central Fund.
enum CentralFundTransactionType {
  donation, // Money received as donation
  templeExpense, // Money spent for temple expenses
  issueDriverAdvance, // Money given to a driver as advance
  receiveDriverAdvanceReturn, // Money returned by a driver from advance
  reimburseDriverForExpense, // Money paid back to a driver for expenses they covered
  unknown; // Added for default/error cases

  String get displayName {
    switch (this) {
      case CentralFundTransactionType.donation:
        return 'รับบริจาค/รายรับ';
      case CentralFundTransactionType.templeExpense:
        return 'ค่าใช้จ่ายวัด';
      case CentralFundTransactionType.issueDriverAdvance:
        return 'เบิกเงินสำรองให้คนขับรถ';
      case CentralFundTransactionType.receiveDriverAdvanceReturn:
        return 'รับคืนเงินสำรองจากคนขับรถ';
      case CentralFundTransactionType.reimburseDriverForExpense:
        return 'จ่ายคืนค่าใช้จ่ายให้คนขับรถ';
      case CentralFundTransactionType.unknown:
        return 'ไม่ทราบประเภท';
      default:
        return '';
    }
  }
}

// This annotation marks the class as an Isar collection.
@collection
class CentralFundTransaction {
  CentralFundTransaction(); // Add unnamed constructor

  // Isar automatically manages this ID as the primary key.
  Id id = Isar.autoIncrement;

  @enumerated
  late CentralFundTransactionType type; // Type of central fund transaction

  late int amount; // Amount of the transaction (in Baht, integer).
  // Positive for income (donation, advance return), negative for expense (temple expense, advance issue, reimbursement).

  late DateTime dateTime; // Date and time the transaction occurred

  String? description; // Details or notes about the transaction

  @Index() // Added Index here
  String? relatedDriverId; // Primary ID of the driver involved (if type is related to driver advance/reimbursement)
  String?
  relatedMonkId; // Primary ID of the monk involved (if applicable, e.g., expense for monk's medical bill)

  late String
  processedByTreasurerId; // Primary ID of the Treasurer who processed this transaction

  // Optional: Store the balance after this transaction for easier history viewing.
  // This can be negative.
  int? balanceAfter;
}

// --- JSON Serialization ---
extension CentralFundTransactionToJson on CentralFundTransaction {
  Map<String, dynamic> toJson() {
    return {
      'id': id == Isar.autoIncrement ? null : id, // Handle auto-increment ID
      'type': type.name, // Serialize enum as string name
      'amount': amount,
      'dateTime': dateTime.toIso8601String(), // Serialize DateTime
      'description': description,
      'relatedDriverId': relatedDriverId,
      'relatedMonkId': relatedMonkId,
      'processedByTreasurerId': processedByTreasurerId,
      'balanceAfter': balanceAfter,
    };
  }
}
