import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:to_be_done/router/router.dart';
import 'package:to_be_done/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp.router(
          theme: ThemeData(
            colorScheme: lightDynamic,
            useMaterial3: true,
            textTheme: textTheme,
            appBarTheme: appBarTheme,
          ),
          darkTheme: ThemeData(
            colorScheme: darkDynamic,
            useMaterial3: true,
            textTheme: textTheme,
            appBarTheme: appBarTheme,
          ),
          routeInformationParser: AppRouter().goRouter.routeInformationParser,
          routeInformationProvider:
              AppRouter().goRouter.routeInformationProvider,
          routerDelegate: AppRouter().goRouter.routerDelegate,
        );
      },
    );
  }
}
