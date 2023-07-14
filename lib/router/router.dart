import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:to_be_done/features/home/screens/home_screen.dart';
import 'package:to_be_done/router/route_const.dart';

class AppRouter {
  GoRouter goRouter = GoRouter(
    initialLocation: AppRouteConst.homeScreen,
    routes: [
    GoRoute(path: AppRouteConst.homeScreen,
    pageBuilder: (context, state) => const CupertinoPage(child: HomeScreen()),)
  ]);
}
