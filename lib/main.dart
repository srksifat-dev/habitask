import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_be_done/features/home/screens/home_screen.dart';
import 'package:to_be_done/router/router.dart';
import 'package:to_be_done/service/isar_service.dart';
import 'package:to_be_done/theme/app_theme.dart';

import 'common/formate_dateTime.dart';
import 'models/task.dart';

int? installed;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  IsarService isarService = IsarService();
  await GetStorage.init();
  installed = GetStorage().read("installed");
  if (installed == null) {
    firstday = FormateDateTime.onlyDate(dateTime: DateTime.now());
    await isarService.addTask(Task()
      ..isComplete = true
      ..taskFor = FormateDateTime.onlyDate(dateTime: DateTime.now())
      ..taskType = "dt"
      ..title = "Welcome to your ultimate Habit building companion!");
    await isarService.addTask(Task()
      ..isComplete = false
      ..taskFor = FormateDateTime.onlyDate(dateTime: DateTime.now())
      ..taskType = "ht"
      ..title = "Enter your first Task and get ready to do it!!");
  }
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
