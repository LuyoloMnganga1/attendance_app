import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:attendance_app/provider/store_provider.dart';
import 'package:attendance_app/provider/stream/auth_stream.dart';
import 'package:attendance_app/services/locator/navigation_service.dart';
import 'package:attendance_app/services/api/profile_service.dart';
import 'package:attendance_app/services/locator/locator.dart';
import 'package:attendance_app/utils/theme.dart';
import 'package:attendance_app/views/widgets/components/appbarsliver.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileService = ProfileService();
  final authService = locator<AuthStream>();
  final navigator = locator<NavigationService>().navigator!;

  final List<Map<String, dynamic>> privateData = [
    {'title': 'Personal Info', 'icon': Icons.person, 'route': '/personal-info'},
    {'title': 'Employee Info', 'icon': Icons.person_pin, 'route': '/employee-info'},
    {'title': 'Change Password', 'icon': Icons.lock_reset_rounded, 'route': '/change-password'},
  ];

  final List<Map<String, dynamic>> aboutApp = [
    {'title': 'About the App', 'icon': Icons.phone_android_rounded, 'route': '/about-app'},
    {'title': 'Help', 'icon': Icons.help_outline_rounded, 'route': '/help'},
  ];

  @override
  Widget build(BuildContext context) {
    var profile = context.watch<UserStore>().profile;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          AppBarSliver(
            title: 'My Profile',
            maxExtent: 100,
            bottomChild: Text(
              'My Profile',
              style: blackTextStyle.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              Container(
                padding: paddingAll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            profile?.profilePic ?? '',
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${profile?.name}",
                                style: blackTextStyle.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${profile?.position?.name}",
                                style: blackTextStyle.copyWith(
                                    fontSize: 16, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                    viewPrivateData(),
                    const SizedBox(height: 20),
                    viewAboutApp(),
                    const SizedBox(height: 20),
                    viewLogout(),
                    const SizedBox(height: 15),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  viewPrivateData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Data',
          style: blackTextStyle.copyWith(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Material(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: privateData.map((data) {
              return InkWell(
                onTap: () {
                  navigator.pushNamed(data['route']);
                },
                child: Container(
                  padding: paddingAll,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(data['icon']),
                      const SizedBox(width: 8),
                      Text(
                        data['title'],
                        style: blackTextStyle.copyWith(fontSize: 16),
                      ),
                      const Spacer(),
                      const Icon(Icons.chevron_right_rounded),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  viewAboutApp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About the App',
          style: blackTextStyle.copyWith(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Material(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: aboutApp.map((data) {
              return InkWell(
                onTap: () {
                  navigator.pushNamed(data['route']);
                },
                child: Container(
                  padding: paddingAll,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(data['icon']),
                      const SizedBox(width: 8),
                      Text(
                        data['title'],
                        style: blackTextStyle.copyWith(fontSize: 16),
                      ),
                      const Spacer(),
                      const Icon(Icons.chevron_right_rounded),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  viewLogout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: blackTextStyle.copyWith(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Material(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              authService.logout().then((value) {
                navigator.pushNamedAndRemoveUntil('/login', (route) => false);
              }).catchError((err) {
                Fluttertoast.showToast(msg: 'Failed to logout');
              });
            },
            child: Container(
              padding: paddingAll,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.logout),
                  const SizedBox(width: 8),
                  Text(
                    'Logout',
                    style: blackTextStyle.copyWith(fontSize: 16),
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
