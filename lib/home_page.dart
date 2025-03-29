import 'package:flutter/material.dart';
import 'package:xavlogdashboard/profile.dart';
//import 'analytics_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<DashboardItem> navigationItems = [
    DashboardItem(
      title: 'Attendance Tracker',
      icon: Icons.track_changes,
      type: 'page'
    ),
    DashboardItem(
      title: 'Calendar',
      icon: Icons.calendar_today,
      type: 'page'
    ),
    DashboardItem(
      title: 'Marketplace',
      icon: Icons.store,
      type: 'page'
    ),
    DashboardItem(
      title: 'Grades Tracker',
      icon: Icons.grade,
      type: 'page'
    ),
    DashboardItem(
      title: 'Social Collaboration',
      icon: Icons.group,
      type: 'page'
    ),
    DashboardItem(
      title: 'Schedule Manager',
      icon: Icons.schedule,
      type: 'page'
    ),
  ];

  Widget _buildAnalyticsSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Monthly Analytics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Jost',
              color: Color(0xFF071D99),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            color: Colors.white,
            shadowColor: Color(0xFF071D99),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    children: [
                      _buildStatCard('Total Attendance', '85%', Icons.calendar_view_day),
                      _buildStatCard('Classes', '24/28', Icons.class_),
                      _buildStatCard('Performance', 'Good', Icons.trending_up),
                      _buildStatCard('Status', 'On Track', Icons.check_circle),
                    ],
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.analytics, color: Color(0xFF071D99)),
                    title: const Text('View Full Analytics'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Handle analytics navigation
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF071D99), size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Jost',
              color: Color(0xFF071D99),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14, 
              fontFamily: 'Inter',
              color: Colors.grey
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50 ), // Add padding from top
        child: Column(
          children: [
            Container( //yellow container of profile stuff
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0), // Adjusted padding
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFFD7A61F),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfilePage()),
                      );
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF071D99),
                              spreadRadius: 1.5,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: const Color(0xFF071D99),
                          child: const Icon(
                            Icons.person,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Center align vertically
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hello, Francis',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jost',
                            color: Color(0xFF071D99),
                          ),
                        ),
                        SizedBox(height: 4), // Add space between text
                        Text(
                          '2 - BSIT',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF071D99),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton( //Calendar at the top right
                    icon: const Icon(Icons.calendar_today, color: Color(0xFF071D99)),
                    onPressed: () {
                      // Handle calendar action
                    },
                  ),
                  IconButton( // Menu at the top right
                    icon: const Icon(Icons.menu, color: Color(0xFF071D99)),
                    onPressed: () {
                      // Handle menu settings
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SizedBox(
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search, size: 20, color: Color(0xFF071D99)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Color(0xFF071D99)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Color(0xFF071D99)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Color(0xFF071D99), width: 2),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
            _buildAnalyticsSummary(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Where Do You Want To Go?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jost',
                      color: Color(0xFF071D99),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 160, // Fixed height for the scrollable area
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: navigationItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = navigationItems[index];
                        return Container(
                          width: 160, // Fixed width for each card
                          margin: const EdgeInsets.only(right: 16),
                          child: Card(
                            elevation: 4,
                            color: Colors.white,
                            shadowColor: Color(0xFF071D99),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => _getPageForItem(item.title),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(item.icon, size: 64, color: Color(0xFF071D99)),
                                  const SizedBox(height: 12),
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Your Calendar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jost',
                      color: Color(0xFF071D99),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF071D99)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // Add your calendar widget here
                    child: const Center(
                      child: Text('Calendar will be implemented here'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Upcoming Activities',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jost',
                      color: Color(0xFF071D99),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5, // Example number of activities
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        color: Colors.white,
                        shadowColor: Color(0xFF071D99),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: const Icon(Icons.event, color: Color(0xFF071D99)),
                          title: Text('Activity ${index + 1}'),
                          subtitle: Text('Description for activity ${index + 1}'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPageForItem(String title) {
    switch (title) {
      case 'Attendance Tracker':
        // return const AttendanceTrackerPage();
      case 'Calendar':
        // return const CalendarPage();
      case 'Marketplace':
        // return const MarketplacePage();
      case 'Grades Tracker':
        // return const GradesTrackerPage();
      case 'Social Collaboration':
        // return const SocialCollaborationPage();
      case 'Schedule Manager':
        // return const ScheduleManagerPage();
      default:
        return const SizedBox();
    }
  }
}

class DashboardItem {
  final String title;
  final IconData icon;
  final String type;

  DashboardItem({
    required this.title,
    required this.icon,
    this.type = 'page',
  });
}