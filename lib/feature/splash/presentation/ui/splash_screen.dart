import 'dart:async';

import 'package:two_min/router/app_router_path.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(
      const Duration(seconds: 2),
      () => context.router.replaceNamed(AppRouterPath.loginScreenPath),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const Image(
                image: AssetImage('assets/images/two_min.jpg'),
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              '2 Min - Quick Vote',
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
