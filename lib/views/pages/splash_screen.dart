import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:attendance_app/provider/store_provider.dart';
import 'package:attendance_app/services/api/profile_service.dart';
import 'package:attendance_app/services/locator/navigation_service.dart';
import 'package:attendance_app/services/locator/locator.dart';
import 'package:provider/provider.dart' as p;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _profileService = ProfileService();
  final navigator = locator<NavigationService>().navigator!;

  @override
  void initState() {
    super.initState();

    checkAuth();
  }

  Future<void> checkAuth() async {
    try {
      final profile = await _profileService.profile();
      if (mounted) {
        context.read<UserStore>().setProfile(profile);
        navigator.pushNamedAndRemoveUntil('/layout', (route) => false);
      }
    } on DioError {
      Fluttertoast.showToast(msg: 'Failed to connect to the server!');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Server is not reachable!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
