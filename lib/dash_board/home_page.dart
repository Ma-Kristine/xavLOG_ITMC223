import 'package:flutter/material.dart';
import 'package:xavlogsigninpage/dash_board/profile.dart';
//import 'analytics_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

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
              fontSize: 16,
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
      //shadowColor: Colors.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFFD7A61F), size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Jost',
              color: Color(0xFF071D99),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12, 
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: [
            // Profile Section
            Container(
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFD7A61F),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 40.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left side with logo
                    SizedBox(
                      width: 100,
                      child: Image.asset(
                        'images/xavloglogo.png',
                        height: 28,
                        fit: BoxFit.contain,
                      ),
                    ),
                    
                    // Right side with notification and profile
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.notifications_outlined,
                            color: Color(0xFF071D99),
                            size: 24,
                          ),
                          onPressed: () {
                            // Handle notifications
                          },
                        ),
                        const SizedBox(width: 12),
                        _buildProfileAvatar(),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildSearchBar(),
            ),

            const SizedBox(height: 24),

            // Analytics Summary
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildAnalyticsSummary(),
            ),

            const SizedBox(height: 24),

            // Navigation Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildNavigationSection(),
            ),

            const SizedBox(height: 24),

            // Calendar Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildCalendarSection(),
            ),

            const SizedBox(height: 24),

            // Activities Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildActivitiesSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF071D99).withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xFF071D99),
          child: Icon(Icons.person, size: 22, color: Colors.white),
        ),
      ),
    );
  }


  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF071D99).withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: const Icon(Icons.search, color: Color(0xFFD7A61F)),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF071D99)),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    ),
    );
  }

  Widget _buildNavigationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Access',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Jost',
            color: Color(0xFF071D99),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: navigationItems.length,
            itemBuilder: (context, index) => _buildNavigationCard(navigationItems[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationCard(DashboardItem item) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap: () => _navigateToPage(item.title),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, size: 40, color: const Color(0xFFD7A61F)),
                const SizedBox(height: 12),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Calendar',
          style: TextStyle(
            fontSize: 16,
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
            child: Text('Calendar will be implemented here'),//CalendarWidget()),
          ),
        ),
      ],
    );
  }

  Widget _buildActivitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming Activities',
          style: TextStyle(
            fontSize: 16,
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
                leading: const Icon(Icons.event, color: Color(0xFFD7A61F)),
                title: Text('Activity ${index + 1}'),
                subtitle: Text('Description for activity ${index + 1}'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            );
          },
        ),
      ],
    );
  }

  void _navigateToPage(String title) {
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
        //return const SizedBox();
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