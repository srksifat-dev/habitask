import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:to_be_done/config/router/route_const.dart';
import 'package:to_be_done/features/home/screens/home_screen.dart';
import 'package:to_be_done/features/task/presentation/pages/task_screen.dart';

class AppRouter {
  GoRouter goRouter = GoRouter(
    initialLocation: AppRouteConst.taskScreen,
    routes: [
    GoRoute(path: AppRouteConst.taskScreen,
    pageBuilder: (context, state) => const CupertinoPage(child: TaskScreen()),)
  ]);
}
