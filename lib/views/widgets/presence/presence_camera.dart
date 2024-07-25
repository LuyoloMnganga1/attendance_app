import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:attendance_app/services/locator/camera_service.dart';
import 'package:attendance_app/services/locator/detector_service.dart';
import 'package:attendance_app/services/locator/recognition_service.dart';
import 'package:attendance_app/services/locator/locator.dart';
import 'package:attendance_app/utils/debug_print.dart';
import 'package:attendance_app/utils/theme.dart';
import 'package:attendance_app/views/widgets/components/camera_view.dart';
import 'package:attendance_app/views/widgets/presence/presence_process.dart';

enum PresenceCameraType { checkIn, checkOut }

class PresenceCamera extends StatefulWidget {
  const PresenceCamera({
    super.key,
    required this.faceCode,
    required this.type,
  });

  final List? faceCode;
  final String type;

  @override
  State<PresenceCamera> createState() => _PresenceCameraState();
}

class _PresenceCameraState extends State<PresenceCamera> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _cameraService = locator<CameraService>();
  final _detectorService = locator<DetectorService>();
  final _recognitionService = locator<RecognitionService>();

  bool _isInitializing = false;
  bool _isDetecting = false;
  bool _isFaceMatch = false;
  Face? faceResult;
  int falseRecognize = 0;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    setState(() => _isInitializing = true);
    await _cameraService.initialize();
    await _recognitionService.initialize();
    _detectorService.initialize();
    setState(() => _isInitializing = false);

    _detecting();
  }

  void _detecting() {
    _cameraService.cameraController?.startImageStream((image) async {
      if (_cameraService.cameraController != null) {
        if (_isDetecting || _isFaceMatch) return;

        _isDetecting = true;

        try {
          await _detectorService.detect(image);
          setState(() {});
          if (_detectorService.faces.isNotEmpty &&
              _detectorService.isFaceAtBox()) {
            if (widget.faceCode != null && !_isFaceMatch) {
              print('Recognizing face...');

              final result = await _recognitionService.predictUser(
                image,
                _detectorService.faces[0],
                widget.faceCode!,
              );

              if (result) {
                _isFaceMatch = true;
              } else {
                _isFaceMatch = false;
                falseRecognize++;
              }
            }
          }
          _isDetecting = false;
          setState(() {});
        } catch (e) {
          _isDetecting = false;
          // Handle the error (e.g., log it or show an error message)
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    dd('Rendering presence camera');
    if (_isFaceMatch) {
      return PresenceProcess(
        type: widget.type,
      );
    } else {
      return CameraView(
        scaffoldKey: scaffoldKey,
        isInitializing: _isInitializing,
        isTakePic: false,
        overflow: _message(),
      );
    }
  }

  Widget _message() {
    if (falseRecognize >= 10) {
      return SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.yellow.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 70,
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(
                'Please brighten your phone screen and find a well-lit place.',
                style: blackTextStyle.copyWith(
                    fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }
    return Container();
  }

  @override
  void dispose() {
    _cameraService.dispose();
    _recognitionService.dispose();
    _detectorService.dispose();
    super.dispose();
  }
}
