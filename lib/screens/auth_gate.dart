import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/session_provider.dart';
import 'login_screen.dart';
import 'product_list_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();

    if (session.isAuthenticated) {
      return const ProductListScreen();
    }

    return const LoginScreen();
  }
}
