import 'dart:async';
import 'package:attendance_app/services/api/auth_service.dart';
import 'package:attendance_app/services/api/profile_service.dart';
import 'package:attendance_app/services/locator/locator.dart';
import 'package:attendance_app/services/locator/token_service.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../store_provider.dart';

class AuthStream {
  final StreamController<dynamic> _onAuthStateChange =
      StreamController.broadcast();

  final _profileService = ProfileService();
  final _authService = AuthService();
  final _tokenService = locator<TokenService>();

  Stream<dynamic> get onAuthStateChange => _onAuthStateChange.stream;

  Future login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _authService.login(email: email, password: password);
      await _tokenService.setToken(res['token']);
      final profile = await _profileService.profile();
      _onAuthStateChange.add(profile);

    } on String catch (e) {
      Fluttertoast.showToast(msg: e);
    }
  }

  Future logout() async {
    try {
      await _authService.logout();
      await _tokenService.removeToken();
      _onAuthStateChange.add(null);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Logout failed');
    }
  }

  Future forceLogout() async {
    await _tokenService.removeToken();
    _onAuthStateChange.add(null);
  }
}
