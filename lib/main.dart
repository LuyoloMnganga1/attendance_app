import 'package:attendance_app/services/locator/navigation_service.dart';
import 'package:attendance_app/utils/theme.dart';
import 'package:attendance_app/views/pages/change_password_page.dart';
import 'package:attendance_app/views/pages/employee_info_page.dart';
import 'package:attendance_app/views/pages/layout_page.dart';
import 'package:attendance_app/views/pages/personal_info_page.dart';
import 'package:attendance_app/views/pages/presence_page.dart';
import 'package:attendance_app/views/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'provider/store_provider.dart';
import 'services/locator/locator.dart';
import 'views/pages/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('en-ZA');  // Initialize date formatting for South Africa

  serviceInit();  // Initialize services
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserStore()),  // Provide UserStore to the widget tree
      ],
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,  // Ensure consistent text scaling
              alwaysUse24HourFormat: true,  // Use 24-hour format
            ),
            child: child!,
          );
        },
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          scaffoldBackgroundColor: backgroundColor,  // Background color for scaffold
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.transparent,  // Transparent bottom sheet background
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
            background: backgroundColor,
          ),
        ),
        debugShowCheckedModeBanner: false,  // Hide debug banner
        title: 'Attendance App',
        initialRoute: '/',  // Set the initial route
        navigatorKey: locator<NavigationService>().navigatorKey,  // Provide navigation service
        routes: {
          '/layout': (context) => const LayoutPage(),
          '/login': (context) => const LoginPage(),
          '/presence': (context) => PresencePage(
            arguments: ModalRoute.of(context)?.settings.arguments,
          ),
          '/': (context) => const SplashScreen(),
          '/personal-info': (context) => const PersonalInfoPage(),
          '/employee-info': (context) => const EmployeeInfoPage(),
          '/change-password': (context) => const ChangePasswordPage(),
        },
      ),
    );
  }
}
