import 'package:flutter/material.dart';
import 'config/router/router.dart';
import 'config/theme/app_colors.dart';
import 'config/theme/app_theme.dart';

// This was the 2bdone project
// I want to transform the application architecture
// I change the app name to habitask that means combination of habit building and task management app
// I follow the clean architecture in the project
// First I remove all the code
// Then I'll build from scratch
// Let's do it!

int? installed;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
        textTheme: textTheme,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
        textTheme: textTheme,
      ),
      themeMode: ThemeMode.system,
      routeInformationParser: AppRouter().goRouter.routeInformationParser,
      routeInformationProvider: AppRouter().goRouter.routeInformationProvider,
      routerDelegate: AppRouter().goRouter.routerDelegate,
    );
  }
}
