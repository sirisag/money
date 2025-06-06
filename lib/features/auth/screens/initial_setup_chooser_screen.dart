import 'package:flutter/material.dart';
import 'package:money/core/navigation/app_router.dart';

// We will import the specific setup screens later
// import 'treasurer_initial_setup_screen.dart'; // No longer needed here if using named routes
// import 'driver_initial_setup_screen.dart'; // For future implementation
// import 'monk_initial_setup_screen.dart'; // For future implementation

class InitialSetupChooserScreen extends StatelessWidget {
  const InitialSetupChooserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ตั้งค่าเริ่มต้น'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'กรุณาเลือกบทบาทของคุณเพื่อดำเนินการตั้งค่าเริ่มต้น:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.treasurerInitialSetup);
                },
                child: const Text('ไวยาวัจกรณ์'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('คนขับรถ'),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.driverInitialSetup);
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('พระ'),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.monkInitialSetup);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
