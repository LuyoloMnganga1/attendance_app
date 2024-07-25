import 'package:attendance_app/model/news_model.dart';
import 'package:attendance_app/views/widgets/home/news_card.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/provider/store_provider.dart';
import 'package:attendance_app/services/api/attendance_service.dart';
import 'package:attendance_app/utils/debug_print.dart';
import 'package:attendance_app/utils/theme.dart';
import 'package:attendance_app/views/widgets/components/appbarsliver.dart';
import 'package:attendance_app/views/widgets/home/attendance_box.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _attendanceService = AttendanceService();

  Future<void> _fetchedAttendance() async {
    final result = await _attendanceService.today();
    if (mounted) {
      Provider.of<UserStore>(context, listen: false).setAttendance(result);
      setState(() {});
    }
  }

  final List<NewsItem> _mockNewsItems = [
    NewsItem(
      title: 'Tech Giants Embrace AI',
      description: 'Major technology companies are investing heavily in artificial intelligence to revolutionize the industry.',
      imageUrl: 'https://clocking.ictchoice.com/images/AI.jpg',
    ),
    NewsItem(
      title: 'Cyber security Threats Increase',
      description: 'Recent reports show a significant rise in cyber security threats targeting businesses worldwide.',
      imageUrl: 'https://clocking.ictchoice.com/images/cyber.jpeg',
    ),
    NewsItem(
      title: 'Cloud Computing Trends for 2024',
      description: 'Experts predict key trends in cloud computing that will shape the industry in the coming year.',
      imageUrl: 'https://clocking.ictchoice.com/images/cloud.png',
    ),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    var store = context.watch<UserStore>();
    var profile = store.profile;
    bool isFetched = false;
    if (store.attendance != null) {
      isFetched = store.attendance!.isFetched;
    }

    dd(profile);

    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) => [
          AppBarSliver(
            title: 'Home',
            maxExtent: 130,
            bottomChild: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${profile?.name}',
                            style: blackTextStyle.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${profile?.position?.name}',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        profile?.profilePic ?? '',
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
        body: RefreshIndicator(
          onRefresh: _fetchedAttendance,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                FutureBuilder(
                  future: isFetched ? null : _fetchedAttendance(),
                  builder: (context, snapshot) {
                    return AttendanceBox(
                      isLoading:
                          snapshot.connectionState == ConnectionState.waiting,
                    );
                  },
                ),
                const SizedBox(height: 10),
                // Section for IT Business News
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'IT Business News',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ..._mockNewsItems.map((newsItem) => NewsCard(newsItem: newsItem)).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
