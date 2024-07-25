import 'package:flutter/material.dart';
import 'package:attendance_app/provider/store_provider.dart';
import 'package:attendance_app/utils/date_convert.dart';
import 'package:attendance_app/utils/theme.dart';
import 'package:attendance_app/views/widgets/components/appbarsliver.dart';
import 'package:attendance_app/views/widgets/components/text_input.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final form = FormGroup({
    'email': FormControl<String>(value: ''),
    'nip': FormControl<String>(value: ''),
    'name': FormControl<String>(value: ''),
    'phone': FormControl<String>(value: ''),
    'birthdate': FormControl<String>(value: ''),
  });

  final List<Map<String, dynamic>> personalData = [
    {'label': 'ID No', 'controlName': 'nip', 'readOnly': true},
    {'label': 'Email', 'controlName': 'email', 'readOnly': true},
    {'label': 'Name', 'controlName': 'name', 'readOnly': true},
    {'label': 'Phone Number', 'controlName': 'phone', 'readOnly': true},
    {'label': 'Date of Birth', 'controlName': 'birthdate', 'readOnly': true}
  ];

  @override
  void initState() {
    super.initState();
    _initProfile();
  }

  void _initProfile() {
    final profile = context.read<UserStore>().profile;
    if (profile != null) {
      form.control('email').updateValue(profile.email);
      form.control('nip').updateValue(profile.nip);
      form.control('phone').updateValue(profile.phone);
      form.control('name').updateValue(profile.name);
      form
          .control('birthdate')
          .updateValue(formatDateID('d MMMM y', profile.birthdate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            AppBarSliver(
              title: 'Personal Info',
              maxExtent: 100,
              onPressBack: () {
                Navigator.pop(context);
              },
              bottomChild: Text(
                'Personal Info',
                style: blackTextStyle.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          body: ListView(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: paddingAll,
                child: ReactiveForm(
                  formGroup: form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: personalData.map((val) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            val['label'] ?? '',
                            style: blackTextStyle.copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          TextInput(
                            controlName: val['controlName'] ?? '',
                            label: val['label'],
                            isReadOnly: val['readOnly'],
                          ),
                          const SizedBox(height: 15),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
