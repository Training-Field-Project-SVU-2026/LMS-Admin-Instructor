import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_admin_instructor/features/auth/presentation/screens/login_screen/login_screen.dart';
import 'package:lms_admin_instructor/features/auth/presentation/screens/register_screen/register_screen.dart';
import 'package:lms_admin_instructor/root/navbar.dart';

class RouterGenerator {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.navbarScreen,
    routes: [
      GoRoute(
        path: AppRoutes.splashScreen,
        name: AppRoutes.splashScreen,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text("Splash Screen"))),
      ),
      GoRoute(
        path: AppRoutes.loginScreen,
        name: AppRoutes.loginScreen,
        builder: (context, state) {
          return BlocProvider.value(
            value: sl<AuthBloc>(),
            child: const LoginScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.registerScreen,
        name: AppRoutes.registerScreen,
        builder: (context, state) {
          return BlocProvider.value(
            value: sl<AuthBloc>(),
            child: const RegisterScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => Container(),
      ),
      GoRoute(
        path: AppRoutes.navbarScreen,
        name: AppRoutes.navbarScreen,
        builder: (context, state) => AdminDashboard(),
      ),
      // GoRoute(
      //   path: AppRoutes.loginScreen,
      //   name: AppRoutes.loginScreen,
      //   builder: (context, state) {
      //     return BlocProvider(
      //       create: (context) => sl<AuthCubit>(),
      //       child: LoginScreen(),
      //     );
      //   },
      // ),
    ],
  );
}
