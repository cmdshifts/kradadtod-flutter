import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kradadtod/features/authentication/screens/loginScreen.dart';
import 'package:kradadtod/features/scanner/screens/slipDataScreen.dart';
import 'package:kradadtod/navigation.dart';
import 'package:kradadtod/utils/constants/images.dart';
import 'package:kradadtod/utils/helpers/functions.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    );

    fetchLoginData();
  }

  fetchLoginData() async {
    final hasData = await FunctionHelpers.hasLoginData();
    if (hasData) {
      _navigateToHomeScreen();
    } else {
      _navigateToLoginScreen();
    }
  }

  _navigateToLoginScreen() async {
    await Future.delayed(
        const Duration(seconds: 4)); // Change the duration as needed
    if (mounted) {
      Navigator.of(context).pushReplacement(PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const LoginScreen(),
      ));
    }
  }

  _navigateToHomeScreen() async {
    await Future.delayed(
        const Duration(seconds: 4)); // Change the duration as needed
    if (mounted) {
      Navigator.of(context).pushReplacement(PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const LoginScreen(),
      ));
    }
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
          opacity: _animation,
          child: ScaleTransition(
              scale: _animation,
              child: SvgPicture.asset(
                KImages.kLogo,
                width: 120,
                height: 120,
              )),
        ),
      ),
    );
  }
}
