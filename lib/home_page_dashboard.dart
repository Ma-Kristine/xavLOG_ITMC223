import 'package:flutter/material.dart';
import 'profile.dart';
import 'eventfinderpage.dart';
import 'login_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String _name = 'Francis';
  String _description = '2 - BSIT';
  String _notifNumber = '3';

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
      title: 'Event Finder',
      icon: Icons.event,
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

  final List<Activity> activities = [
    Activity(
      title: 'Midterm Examination',
      description: 'Comprehensive exam covering chapters 1-5',
      date: DateTime.now().add(const Duration(days: 2)),
      category: 'Academic',
    ),
    Activity(
      title: 'Project Deadline',
      description: 'Final submission of mobile development project',
      date: DateTime.now().add(const Duration(days: 5)),
      category: 'Project',
    ),
    Activity(
      title: 'Organization Meeting',
      description: 'Monthly general assembly',
      date: DateTime.now().add(const Duration(days: 7)),
      category: 'Organization',
    ),
    /////////////////////// Add more activities as needed through add button on upcoming activities //////////////////////////
  ];

  void updateName(String newName) {
    setState(() {
      _name = newName;
    });
  }

  void updateDescription(String newDescription) {
    setState(() {
      _description = newDescription;
    });
  }

  void updateNotifNumber(String newNumber) {
    setState(() {
      _notifNumber = newNumber;
    });
  }

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
                      /////////////// chnage numbers according to computations of analytics //////////////
                      _buildStatCard('Total Classes', '28', Icons.class_),
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
                      ///////////////////// Handle analytics navigation /////////////////////
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const AnalyticsPage()));
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

  Widget _buildUpcomingActivities() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Upcoming Activities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Jost',
                color: Color(0xFF071D99),
              ),
            ),
            GestureDetector(
              onTap: () {
                ////////////////////// Handle adding new activity /////////////////////
              },
              child: Tooltip(
                message: 'Add Activity',
                child: CircleAvatar(
                  backgroundColor: const Color(0xFFD7A61F),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
          
          const SizedBox(height: 16),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF071D99).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getCategoryIcon(activity.category),
                      color: const Color(0xFF071D99),
                    ),
                  ),
                  title: Text(
                    activity.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF071D99),
                    ),
                  ),
                  subtitle: Text(
                    _formatDate(activity.date),
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.category, 
                                size: 20, 
                                color: Color(0xFF071D99)
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Category: ${activity.category}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.description, 
                                size: 20, 
                                color: Color(0xFF071D99)
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  activity.description,
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Academic':
        return Icons.school;
      case 'Project':
        return Icons.assignment;
      case 'Organization':
        return Icons.groups;
      default:
        return Icons.event;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  void _showMainMenu(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  Drawer _buildMainMenuDrawer() {

    
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF071D99), Color(0xFFD7A61F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFD7A61F),
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jost',
                    ),
                  ),
                  Text(
                    _description,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.notifications, color: Color(0xFF071D99)),
              title: const Text('Notifications'),
              trailing: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF071D99),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _notifNumber,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                ///////////////// Handle notifications, open notif page ////////////////////////
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFF071D99)),
              title: const Text('Settings'),
              onTap: () {
                ///////////////// Handle setting, open setting page ////////////////////////
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help, color: Color(0xFF071D99)),
              title: const Text('Help & Support'),
              onTap: () {
                ///////////////// Handle FAQs, open FAQs page ////////////////////////
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip, color: Color(0xFF071D99)),
              title: const Text('Privacy Policy'),
              onTap: () {
                ///////////////// Handle privacy policy, open privacy policy page ////////////////////////
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF071D99)),
              title: const Text('Logout'),
              onTap: () {
                showDialog( //logout dialog
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle logout
                            Navigator.pop(context); // Close dialog
                            Navigator.pop(context); // Close drawer
                            Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => const LoginPage())
                            ); // Redirect to login page
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Blue background
      drawer: _buildMainMenuDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 30),
        child: Column(
          children: [
            // Profile Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF071D99), Color(0xFFD7A61F)], // Blue to Yellow gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
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
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color(0xFFD7A61F), // Yellow
                        child: const Icon(Icons.person, size: 30, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, $_name', 
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jost',
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          _description,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) => Row(
                      children: [
                        IconButton(
                          icon: Stack(
                            children: [
                              const Icon(Icons.notifications, color: Colors.white),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD7A61F),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 14,
                                    minHeight: 14,
                                  ),
                                  child: Text(
                                    _notifNumber,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            ////////////// Handle notifications page ///////////////////////
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () => _showMainMenu(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: Color.fromARGB(179, 43, 75, 203)),
                  prefixIcon: const Icon(Icons.search, color: Color.fromARGB(179, 43, 75, 203)),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255), // Dark blue
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 17, 38, 179),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Analytics Summary
            _buildAnalyticsSummary(),

            const SizedBox(height: 20),

            // Navigation Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: navigationItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = navigationItems[index];
                        return Container(
                          width: 160,
                          margin: const EdgeInsets.only(right: 16),
                          child: Card(
                            elevation: 4,
                            color: const Color.fromARGB(255, 8, 33, 96), // Dark blue
                            shadowColor: Colors.black.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              onTap: () {
                                final page = _getPageForItem(item.title);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => page),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(item.icon, size: 48, color: const Color(0xFFD7A61F)), // Yellow icons
                                  const SizedBox(height: 12),
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter',
                                      color: Colors.white,
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
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Calendar Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      color: const Color.fromARGB(255, 255, 255, 255), // Dark blue
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFD7A61F)), // Yellow border
                    ),
                    child: const Center(
                      child: Text(
                        'Calendar will be implemented here', ///////////////calendar functionalities////////////////
                        style: TextStyle(color: Color(0xFF071D99)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Upcoming Activities
            _buildUpcomingActivities(),
          ],
        ),
      ),
    );
  }

  Widget _getPageForItem(String title) {
    switch (title) {
      case 'Attendance Tracker':
        // return const AttendanceTrackerPage(); // Uncomment and implement this when ready
      case 'Event Finder':
        return const EventFinderPage(); // Redirect to EventFinderPage
      case 'Calendar':
        // return const CalendarPage(); // Uncomment and implement this when ready
      case 'Marketplace':
        // return const MarketplacePage(); // Uncomment and implement this when ready
      case 'Grades Tracker':
        // return const GradesTrackerPage(); // Uncomment and implement this when ready
      case 'Social Collaboration':
        // return const SocialCollaborationPage(); // Uncomment and implement this when ready
      case 'Schedule Manager':
        // return const ScheduleManagerPage(); // Uncomment and implement this when ready
      default:
        return const SizedBox(); // Return an empty widget as fallback
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

class Activity {
  final String title;
  final String description;
  final DateTime date;
  final String category;
  bool isExpanded;

  Activity({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    this.isExpanded = false,
  });
}