import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:attendance_app/provider/store_provider.dart';
import 'package:attendance_app/services/api/face_service.dart';
import 'package:attendance_app/services/locator/activation_service.dart';
import 'package:attendance_app/services/locator/navigation_service.dart';
import 'package:attendance_app/services/locator/locator.dart';
import 'package:attendance_app/utils/theme.dart';
import 'package:attendance_app/views/widgets/activation/activation_landing.dart';
import 'package:attendance_app/views/widgets/components/button.dart';
import 'package:provider/provider.dart';

class ActivationProcess extends StatefulWidget {
  const ActivationProcess({super.key});

  @override
  State<ActivationProcess> createState() => _ActivationProcessState();
}

class _ActivationProcessState extends State<ActivationProcess> {
  final _activationService = locator<ActivationService>();
  final _navigator = locator<NavigationService>().navigator!;

  final _faceService = FaceService();

  @override
  Widget build(BuildContext context) {
    final store = context.read<UserStore>();
    final profile = store.profile;

    return WillPopScope(
      onWillPop: cancelActivation,
      child: Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            future: _faceService.addFaces(_activationService.faces),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasError) {
                Fluttertoast.showToast(msg: 'Failed to process');
              }
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                Future.delayed(const Duration(seconds: 2)).then((_) {
                  store.setStatusActive();
                  _navigator.pushNamedAndRemoveUntil(
                      '/layout', (route) => false);
                });
              }
              return Container(
                padding: paddingAll,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 300,
                      width: screen(context).width,
                      child: SvgPicture.asset('assets/timeloading.svg'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: screen(context).height * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                snapshot.connectionState ==
                                    ConnectionState.waiting
                                    ? 'Please wait a moment,'
                                    : snapshot.hasData
                                    ? 'Yeahhh, Congratulations, ${profile?.name}.'
                                    : 'Oops, sorry, ${profile?.name}.',
                                style: blackTextStyle.copyWith(fontSize: 18),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                snapshot.connectionState ==
                                    ConnectionState.waiting
                                    ? 'your account activation is being processed...'
                                    : snapshot.hasData
                                    ? 'Your account activation was successful 😁'
                                    : 'Your account activation failed. Please try again.',
                                textAlign: TextAlign.center,
                                style: blackTextStyle.copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: 150,
                            height: 100,
                            alignment: Alignment.center,
                            child: snapshot.connectionState ==
                                ConnectionState.waiting
                                ? const CircularProgressIndicator()
                                : snapshot.hasError
                                ? Button(
                              label: 'Try Again',
                              width: 200,
                              onPressed: () {
                                setState(() {});
                              },
                            )
                                : Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                color: Colors.green.shade600,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<bool> cancelActivation() async {
    bool willLeave = false;
    // Show the confirmation dialog
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Cancel activation?',
          style: blackTextStyle.copyWith(fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              willLeave = true;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (ctx) => const ActivationLanding()),
                    (route) => false,
              );
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No'),
          )
        ],
      ),
    );
    return willLeave;
  }

  @override
  void dispose() {
    super.dispose();
    _activationService.dispose();
  }
}
