import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/auth_notifier.dart'; // Import your AuthNotifier
// Import the dashboard screen (we'll create this later or use a placeholder)
import '../../../core/navigation/app_router.dart'; // Import AppRouter
import '../../../data/models/app_user.dart'; // Import UserRole for role check
// import '../../treasurer/screens/treasurer_dashboard_screen.dart';
// import '../../driver/screens/driver_dashboard_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _primaryIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _primaryIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _performLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final success = await ref
          .read(authNotifierProvider.notifier)
          .login(_primaryIdController.text, _passwordController.text);

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('เข้าสู่ระบบสำเร็จ!')));
          final authState = ref.read(authNotifierProvider);
          if (authState.currentRole == UserRole.treasurer) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.treasurerDashboard,
              (route) => false,
            );
          } else if (authState.currentRole == UserRole.driver) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.driverDashboard,
              (route) => false,
            );
          } else if (authState.currentRole == UserRole.monk) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.monkDashboard,
              (route) => false,
            );
          } else {
            // Fallback or error, should not happen if login is successful with a role
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Primary ID หรือรหัสผ่านไม่ถูกต้อง')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เข้าสู่ระบบ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _primaryIdController,
                decoration: const InputDecoration(labelText: 'Primary ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอก Primary ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'รหัสผ่าน'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกรหัสผ่าน';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _performLogin,
                      child: const Text('เข้าสู่ระบบ'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
