import 'package:flutter/material.dart';

import 'core/app_theme.dart';
import 'home_screen.dart';
import 'screens/auth/login_screen.dart';
import 'services/auth_service.dart';
import 'widgets/brand_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    _routeNext();
  }

  Future<void> _routeNext() async {
    final loggedIn = await AuthService.instance.restoreSession();
    // Give the animation time to finish.
    await Future.delayed(const Duration(milliseconds: 1100));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      FadeRoute(
        page: loggedIn ? const HomeScreen() : const LoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scale,
                child: const BrandLogo(size: 96),
              ),
              const SizedBox(height: 24),
              RichText(
                text: const TextSpan(
                  text: 'Task',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                  children: [
                    TextSpan(
                      text: 'ly',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Stay on top of every task',
                style: TextStyle(
                    fontSize: 14, color: AppColors.textTertiary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
