import 'package:flutter/material.dart';
import 'package:money/data/models/driver_profile.dart';
import 'package:money/data/models/monk_profile.dart';
import 'package:money/features/auth/screens/initial_setup_chooser_screen.dart';
import 'package:money/features/auth/screens/login_screen.dart';
import 'package:money/features/auth/screens/treasurer_initial_setup_screen.dart';
import 'package:money/features/auth/screens/driver_initial_setup_screen.dart';
import 'package:money/features/auth/screens/monk_initial_setup_screen.dart';
// Import other screens as they are created
import 'package:money/features/treasurer/screens/treasurer_dashboard_screen.dart';
import 'package:money/features/driver/screens/driver_dashboard_screen.dart';
import 'package:money/features/monk/screens/monk_dashboard_screen.dart';
import 'package:money/features/treasurer/screens/monk_management/monk_list_screen.dart';
import 'package:money/features/treasurer/screens/monk_management/monk_add_edit_screen.dart';
import 'package:money/features/treasurer/screens/monk_management/monk_detail_screen.dart';
import 'package:money/features/treasurer/screens/driver_management/driver_list_screen.dart';
import 'package:money/features/treasurer/screens/driver_management/driver_add_edit_screen.dart';
import 'package:money/features/treasurer/screens/driver_management/driver_detail_screen.dart';
import 'package:money/features/treasurer/screens/central_fund/central_fund_main_screen.dart';
import 'package:money/features/treasurer/screens/central_fund/record_donation_screen.dart';
import 'package:money/features/treasurer/screens/central_fund/record_temple_expense_screen.dart';
import 'package:money/features/treasurer/screens/central_fund/manage_driver_advance_screen.dart';
import 'package:money/features/treasurer/screens/central_fund/central_fund_history_screen.dart';
import 'package:money/features/treasurer/screens/backup_export_data_screen.dart';
import 'package:money/features/treasurer/screens/driver_management/process_driver_submission_screen.dart';
import 'package:money/features/treasurer/screens/monk_management/direct_monk_transaction_screen.dart';
import 'package:money/features/driver/screens/driver_record_monk_fund_screen.dart';
import 'package:money/features/driver/screens/driver_record_expense_screen.dart';
import 'package:money/features/driver/screens/driver_export_data_screen.dart';
import 'package:money/features/driver/screens/driver_import_update_screen.dart';
import 'package:money/features/driver/screens/driver_settings_screen.dart';
import 'package:money/features/monk/screens/monk_import_master_data_screen.dart';
import 'package:money/features/monk/screens/monk_transaction_history_screen.dart';
import 'package:money/features/monk/screens/monk_settings_screen.dart';

class AppRoutes {
  static const String initialSetupChooser = '/initial-setup-chooser';
  static const String treasurerInitialSetup = '/treasurer-initial-setup';
  static const String driverInitialSetup = '/driver-initial-setup';
  static const String monkInitialSetup = '/monk-initial-setup';
  static const String login = '/login';
  static const String treasurerDashboard = '/treasurer-dashboard';
  static const String driverDashboard = '/driver-dashboard';
  static const String monkDashboard = '/monk-dashboard';

  // Treasurer specific routes
  static const String treasurerMonkList = '/treasurer-monk-list';
  static const String treasurerMonkAddEdit = '/treasurer-monk-add-edit';
  static const String treasurerMonkDetail = '/treasurer-monk-detail';
  static const String treasurerDirectMonkTransaction =
      '/treasurer-direct-monk-transaction';

  static const String treasurerDriverList = '/treasurer-driver-list';
  static const String treasurerDriverAddEdit = '/treasurer-driver-add-edit';
  static const String treasurerDriverDetail = '/treasurer-driver-detail';

  static const String treasurerCentralFundMain = '/treasurer-central-fund-main';
  static const String treasurerRecordDonation = '/treasurer-record-donation';
  static const String treasurerRecordTempleExpense =
      '/treasurer-record-temple-expense';
  static const String treasurerManageDriverAdvance =
      '/treasurer-manage-driver-advance';
  static const String treasurerCentralFundHistory =
      '/treasurer-central-fund-history';
  static const String treasurerBackupExport = '/treasurer-backup-export';
  static const String treasurerProcessDriverSubmission =
      '/treasurer-process-driver-submission';

  // Driver specific routes
  static const String driverRecordMonkFund = '/driver-record-monk-fund';
  static const String driverRecordExpense = '/driver-record-expense';
  static const String driverExportData = '/driver-export-data';
  static const String driverImportUpdate = '/driver-import-update';
  static const String driverSettings = '/driver-settings';

  // Monk specific routes
  static const String monkImportMasterData = '/monk-import-master-data';
  static const String monkTransactionHistory = '/monk-transaction-history';
  static const String monkSettings = '/monk-settings';

  // Add other routes here
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initialSetupChooser:
        return MaterialPageRoute(
          builder: (_) => const InitialSetupChooserScreen(),
        );
      case AppRoutes.treasurerInitialSetup:
        return MaterialPageRoute(
          builder: (_) => const TreasurerInitialSetupScreen(),
        );
      case AppRoutes.driverInitialSetup:
        return MaterialPageRoute(
          builder: (_) => const DriverInitialSetupScreen(),
        );
      case AppRoutes.monkInitialSetup:
        return MaterialPageRoute(
          builder: (_) => const MonkInitialSetupScreen(),
        );
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.treasurerDashboard:
        return MaterialPageRoute(
          builder: (_) => const TreasurerDashboardScreen(),
        );
      case AppRoutes.driverDashboard:
        return MaterialPageRoute(builder: (_) => const DriverDashboardScreen());
      case AppRoutes.monkDashboard:
        return MaterialPageRoute(builder: (_) => const MonkDashboardScreen());
      case AppRoutes.treasurerMonkList:
        return MaterialPageRoute(builder: (_) => const MonkListScreen());
      case AppRoutes.treasurerMonkAddEdit:
        // We expect arguments to determine if it's Add or Edit mode
        final args = settings.arguments as Map<String, dynamic>?;
        final mode = args?['mode'] as MonkFormMode? ?? MonkFormMode.add;
        final existingMonk =
            args?['monk'] as MonkProfile?; // Cast to MonkProfile
        return MaterialPageRoute(
          builder: (_) =>
              MonkAddEditScreen(mode: mode, existingMonk: existingMonk),
        );
      case AppRoutes.treasurerMonkDetail:
        final monk = settings.arguments as MonkProfile?;
        if (monk != null) {
          return MaterialPageRoute(
            builder: (_) => MonkDetailScreen(monk: monk),
          );
        }
        // Handle error if monk is null, e.g., navigate to an error page or back
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('ไม่พบข้อมูลพระ')),
          ),
        );
      case AppRoutes.treasurerDirectMonkTransaction:
        final monk = settings.arguments as MonkProfile?;
        if (monk != null) {
          return MaterialPageRoute(
            builder: (_) => DirectMonkTransactionScreen(monk: monk),
          );
        }
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('ไม่พบข้อมูลพระสำหรับทำรายการ')),
          ),
        );
      case AppRoutes.treasurerDriverList:
        return MaterialPageRoute(builder: (_) => const DriverListScreen());
      case AppRoutes.treasurerDriverAddEdit:
        final args = settings.arguments as Map<String, dynamic>?;
        final isEditMode = args?['isEditMode'] as bool? ?? false;
        final existingDriver = args?['driver'] as DriverProfile?;
        return MaterialPageRoute(
          builder: (_) => DriverAddEditScreen(
            isEditMode: isEditMode,
            existingDriver: existingDriver,
          ),
        );
      case AppRoutes.treasurerDriverDetail:
        final driver = settings.arguments as DriverProfile?;
        if (driver != null) {
          return MaterialPageRoute(
            builder: (_) => DriverDetailScreen(driver: driver),
          );
        }
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('ไม่พบข้อมูลคนขับรถ')),
          ),
        );
      case AppRoutes.treasurerCentralFundMain:
        return MaterialPageRoute(builder: (_) => const CentralFundMainScreen());
      case AppRoutes.treasurerRecordDonation:
        return MaterialPageRoute(builder: (_) => const RecordDonationScreen());
      case AppRoutes.treasurerRecordTempleExpense:
        return MaterialPageRoute(
          builder: (_) => const RecordTempleExpenseScreen(),
        );
      case AppRoutes.treasurerManageDriverAdvance:
        return MaterialPageRoute(
          builder: (_) => const ManageDriverAdvanceScreen(),
        );
      case AppRoutes.treasurerCentralFundHistory:
        return MaterialPageRoute(
          builder: (_) => const CentralFundHistoryScreen(),
        );
      case AppRoutes.treasurerBackupExport:
        return MaterialPageRoute(
          builder: (_) => const BackupExportDataScreen(),
        );
      case AppRoutes.treasurerProcessDriverSubmission:
        return MaterialPageRoute(
          builder: (_) => const ProcessDriverSubmissionScreen(),
        );
      case AppRoutes.driverRecordMonkFund:
        return MaterialPageRoute(
          builder: (_) => const DriverRecordMonkFundScreen(),
        );
      case AppRoutes.driverRecordExpense:
        return MaterialPageRoute(
          builder: (_) => const DriverRecordExpenseScreen(),
        );
      case AppRoutes.driverExportData:
        return MaterialPageRoute(
          builder: (_) => const DriverExportDataScreen(),
        );
      case AppRoutes.driverImportUpdate:
        return MaterialPageRoute(
          builder: (_) => const DriverImportUpdateScreen(),
        );
      case AppRoutes.driverSettings:
        return MaterialPageRoute(builder: (_) => const DriverSettingsScreen());
      case AppRoutes.monkImportMasterData:
        return MaterialPageRoute(
          builder: (_) => const MonkImportMasterDataScreen(),
        );
      case AppRoutes.monkTransactionHistory:
        return MaterialPageRoute(
          builder: (_) => const MonkTransactionHistoryScreen(),
        );
      case AppRoutes.monkSettings:
        return MaterialPageRoute(builder: (_) => const MonkSettingsScreen());

      default:
        // If the route is not found, you can navigate to a default page or an error page
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
