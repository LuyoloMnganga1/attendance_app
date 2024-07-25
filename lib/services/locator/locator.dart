import 'package:get_it/get_it.dart';
import 'package:attendance_app/provider/stream/auth_stream.dart';
import 'package:attendance_app/services/locator/detector_service.dart';
import 'package:attendance_app/services/locator/activation_service.dart';
import 'package:attendance_app/services/locator/token_service.dart';
import 'package:attendance_app/services/locator/navigation_service.dart';
import 'package:attendance_app/services/locator/recognition_service.dart';
import 'camera_service.dart';

final locator = GetIt.instance;

void serviceInit() {
  locator.registerLazySingleton<CameraService>(() => CameraService());
  locator.registerLazySingleton<DetectorService>(() => DetectorService());
  locator.registerLazySingleton<RecognitionService>(() => RecognitionService());
  locator.registerLazySingleton<TokenService>(() => TokenService());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<AuthStream>(() => AuthStream());
  locator.registerLazySingleton<ActivationService>(() => ActivationService());
}