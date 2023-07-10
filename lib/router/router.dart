import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:to_be_done/features/home/screens/home_screen.dart';

class AppRouter {
  GoRouter goRouter = GoRouter(routes: [
    GoRoute(path: "/",
    pageBuilder: (context, state) => CupertinoPage(child: HomeScreen()),)
  ]);
}
