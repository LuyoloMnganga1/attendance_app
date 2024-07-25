import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:attendance_app/services/api/profile_service.dart';
import 'package:attendance_app/utils/theme.dart';
import 'package:attendance_app/views/widgets/components/appbarsliver.dart';
import 'package:attendance_app/views/widgets/components/button.dart';
import 'package:attendance_app/views/widgets/components/text_input.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final form = FormGroup({
    'current': FormControl<String>(value: '', validators: [
      Validators.required,
    ]),
    'new': FormControl<String>(value: '', validators: [
      Validators.required,
    ]),
    'confirm': FormControl<String>(value: '', validators: [
      Validators.required,
    ]),
  });

  final _profileService = ProfileService();
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                AppBarSliver(
                  title: 'Change Password',
                  maxExtent: 100,
                  onPressBack: () {
                    Navigator.pop(context);
                  },
                  bottomChild: Text(
                    'Change Password',
                    style: blackTextStyle.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ];
            },
            body: ListView(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: paddingAll,
                  child: ReactiveForm(
                    formGroup: form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Password",
                          style: blackTextStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        const TextInput(
                          controlName: 'current',
                          label: 'Current Password',
                          isPassword: true,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "New Password",
                          style: blackTextStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        const TextInput(
                          controlName: 'new',
                          label: 'New Password',
                          isPassword: true,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Confirm New Password",
                          style: blackTextStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        const TextInput(
                          controlName: 'confirm',
                          label: 'Confirm New Password',
                          isPassword: true,
                        ),
                        const SizedBox(height: 20),
                        Button(
                          isLoading: _isProcessing,
                          label: 'Save',
                          onPressed: () async {
                            if (!form.valid) {
                              form.markAllAsTouched();
                              return;
                            }

                            setState(() {
                              _isProcessing = true;
                            });
                            try {
                              await _profileService.changePassword(form.value);
                              Fluttertoast.showToast(
                                msg: 'Password changed successfully',
                              );
                              // reset form
                              Future.microtask(() {
                                Navigator.pop(context);
                              });
                            } on DioError catch (err) {
                              final error = json.decode(err.response?.data);
                              Fluttertoast.showToast(msg: error['message']);
                            } finally {
                              setState(() {
                                _isProcessing = false;
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
