import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kradadtod/utils/themes/theme.dart';
import 'features/splash/screens/splashScreen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KradadTod',
      themeMode: ThemeMode.system,
      theme: KAppTheme.lightTheme,
      darkTheme: KAppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
  }
}
