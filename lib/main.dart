import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/pages/splash_onboarding/splash_screen.dart';
import 'package:movie/provider/setting_provoder.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingProvider()),
      ],
      child: const MainApp(),
    ),
  );

  // Ẩn thanh điều hướng và thanh trạng thái
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
