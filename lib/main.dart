import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/routing/router_generator.dart';
import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'package:lms_admin_instructor/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
<<<<<<< HEAD
      designSize: ((MediaQuery.of(context).size.width) > 600)
          ? Size(1440, 1024)
          : Size(390, 852),
=======
      designSize: const Size(390, 852),
>>>>>>> 56a87a2ff17227bfaeeedbb19dec4bdcfd6e5708
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          supportedLocales: const [Locale('en'), Locale('ar')],
          locale: const Locale('en'),
          debugShowCheckedModeBanner: false,
          title: 'LMS Student',
          theme: AppTheme.lightTheme,
          routerConfig: RouterGenerator.goRouter,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(context.tr("welcom_to_lms_admin_instructor")),
            Text(context.tr('Hello')),
            Text(
              '$_counter',
              style: context.textTheme.headlineMedium?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            Text('', style: TextStyle(color: context.colorScheme.primary)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(AppRoutes.loginScreen);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add, size: 24.w),
      ),
    );
  }
}
