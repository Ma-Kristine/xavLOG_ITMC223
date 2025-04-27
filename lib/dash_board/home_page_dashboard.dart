/// Home Page Dashboard
/// 
/// Purpose: Main dashboard displaying student information, analytics, calendar,
/// navigation options, and upcoming activities.
/// 
/// Flow:
/// 1. User logs in and is directed to this dashboard
/// 2. User can view their profile information and analytics
/// 3. User can navigate to different features of the app
/// 4. User can manage their calendar and upcoming activities
/// 5. User can access notifications and settings
/// 
/// Backend Implementation Needed:
/// - User profile data retrieval from database
/// - Analytics data calculation and retrieval
/// - Calendar events synchronization with backend
/// - Activities storage and retrieval
/// - Real-time notifications system
library;

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'profile.dart';
import '../event_finder/eventfinderpage_reg.dart';
import '../login/login_page.dart';
import '../login/faqs.dart';
import '../event_finder/notifications_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String _name = 'Francis';
  String _description = '2 - BSIT';
  String _notifNumber = '3';
  String _profileImageUrl = 'https://picsum.photos/200?random=1';

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'Academic'; // Default category
  DateTime _selectedDate = DateTime.now();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<String> _activityCategories = [
    'Academic',
    'Project',
    'Organization',
  ];

  // Navigation items for the main dashboard
  // BACKEND: These items should be dynamically loaded based on user permissions and profile type
  final List<DashboardItem> navigationItems = [
    DashboardItem(
      title: 'Attendance Tracker',
      icon: Icons.track_changes,
      type: 'page', // DYNAMIC: Could be 'page', 'link', or 'external' based on navigation behavior
    ),
    DashboardItem(title: 'Calendar', icon: Icons.calendar_today, type: 'page'),
    DashboardItem(title: 'Event Finder', icon: Icons.event, type: 'page'),
    DashboardItem(title: 'Marketplace', icon: Icons.store, type: 'page'),
    DashboardItem(title: 'Grades Tracker', icon: Icons.grade, type: 'page'),
    DashboardItem(
      title: 'Social Collaboration',
      icon: Icons.group,
      type: 'page',
    ),
    DashboardItem(
      title: 'Schedule Manager',
      icon: Icons.schedule,
      type: 'page',
    ),
  ];

  // Activities shown on the dashboard
  // BACKEND: Should be fetched from API based on user ID and relevance
  // DYNAMIC: Should update in real-time as new activities are added
  final List<Activity> activities = [
    Activity(
      title: 'Midterm Examination',
      description: 'Comprehensive exam covering chapters 1-5',
      date: DateTime.now().add(const Duration(days: 2)), // DYNAMIC: Calculate from current date
      category: 'Academic', // Used for filtering and categorization
    ),
    Activity(
      title: 'Project Deadline',
      description: 'Final submission of mobile development project',
      date: DateTime.now().add(const Duration(days: 5)), // DYNAMIC: Calculate from current date
      category: 'Project',
    ),
    Activity(
      title: 'Organization Meeting',
      description: 'Monthly general assembly',
      date: DateTime.now().add(const Duration(days: 7)), // DYNAMIC: Calculate from current date
      category: 'Organization', // BACKEND: Missing date field should be handled gracefully
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF071D99),
            colorScheme: const ColorScheme.light(primary: Color(0xFF071D99)),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showAddActivityDialog() {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final fontSize = width * 0.03;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add New Activity',
            style: TextStyle(
              fontSize: fontSize * 1.3,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF071D99),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter activity title',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter activity description',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items:
                      _activityCategories.map((String category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Date'),
                  subtitle: Text(
                    '${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _titleController.clear();
                _descriptionController.clear();
                _selectedCategory = 'Academic';
                _selectedDate = DateTime.now();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF071D99),
              ),
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  setState(() {
                    activities.add(
                      Activity(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        date: _selectedDate,
                        category: _selectedCategory,
                      ),
                    );
                    // Sort activities by date
                    activities.sort((a, b) => a.date.compareTo(b.date));
                  });
                  Navigator.pop(context);
                  _titleController.clear();
                  _descriptionController.clear();
                  _selectedCategory = 'Academic';
                  _selectedDate = DateTime.now();
                }
              },
              child: const Text(
                'Add Activity',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnalyticsSummary() {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final fontSize = width * 0.03;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Monthly Analytics',
            style: TextStyle(
              fontSize: fontSize * 1.2,
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
                      /////////////// change numbers according to computations of analytics //////////////
                      _buildStatCard(
                        'Total Classes',
                        '28',
                        Icons.class_,
                        fontSize * 1.2,
                      ),
                      _buildStatCard(
                        'Total Attendance',
                        '85%',
                        Icons.calendar_view_day,
                        fontSize * 1.2,
                      ),
                      _buildStatCard(
                        'Classes Attended',
                        '24/28',
                        Icons.class_,
                        fontSize * 1.2,
                      ),
                      _buildStatCard(
                        'Performance',
                        'Good',
                        Icons.trending_up,
                        fontSize * 1.2,
                      ),
                    ],
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.analytics,
                      color: Color(0xFF071D99),
                    ),
                    title: const Text('View Full Analytics'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      _showAnalyticsSheet();
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

  void _showAnalyticsSheet() {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final fontSize = width * 0.035;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: screenSize.height * 0.8,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Student Analytics',
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontSize: fontSize * 1.4,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF071D99),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      // Attendance analytics card
                      Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Attendance Overview',
                                style: TextStyle(
                                  fontFamily: 'Jost',
                                  fontSize: fontSize * 1.2,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF071D99),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildPieChartItem(
                                    'Present',
                                    0.85,
                                    const Color(0xFF071D99),
                                  ),
                                  _buildPieChartItem(
                                    'Absent',
                                    0.08,
                                    Colors.red,
                                  ),
                                  _buildPieChartItem(
                                    'Late',
                                    0.07,
                                    const Color(0xFFD7A61F),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text('Attendance Distribution'),
                            ],
                          ),
                        ),
                      ),

                      // Performance Analytics
                      Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Subject Performance',
                                style: TextStyle(
                                  fontFamily: 'Jost',
                                  fontSize: fontSize * 1.2,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF071D99),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(height: 200, child: _buildBarChart()),
                            ],
                          ),
                        ),
                      ),

                      // Progress Analytics
                      Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Semester Progress',
                                style: TextStyle(
                                  fontFamily: 'Jost',
                                  fontSize: fontSize * 1.2,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF071D99),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Completed',
                                          style: TextStyle(
                                            fontFamily: 'Jost',
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '60%',
                                          style: TextStyle(
                                            fontFamily: 'Jost',
                                            fontSize: fontSize * 1.3,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 1,
                                    color: Colors.grey[300],
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Remaining',
                                          style: TextStyle(
                                            fontFamily: 'Jost',
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '40%',
                                          style: TextStyle(
                                            fontFamily: 'Jost',
                                            fontSize: fontSize * 1.3,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Export Button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF071D99),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Analytics report exported'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.download, color: Colors.white),
                        label: Text(
                          'Export Report',
                          style: TextStyle(
                            fontFamily: 'Jost',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildPieChartItem(String label, double value, Color color) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: 8,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: const TextStyle(
                fontFamily: 'Jost',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontFamily: 'Jost')),
      ],
    );
  }

  Widget _buildBarChart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildBar('Programming', 0.88, const Color(0xFF071D99)),
        _buildBar('Mathematics', 0.75, const Color(0xFFD7A61F)),
        _buildBar('Database', 0.92, const Color(0xFF071D99)),
        _buildBar('Networks', 0.80, const Color(0xFFD7A61F)),
      ],
    );
  }

  Widget _buildBar(String label, double value, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 40,
          height: 150 * value,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontFamily: 'Jost', fontSize: 12),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          '${(value * 100).toInt()}%',
          style: const TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    double fontSize,
  ) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF071D99), size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize * 1.2,
              fontWeight: FontWeight.bold,
              fontFamily: 'Jost',
              color: Color(0xFF071D99),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize * 0.8,
              fontFamily: 'Inter',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingActivities() {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final fontSize = width * 0.03;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upcoming Activities',
                style: TextStyle(
                  fontSize: fontSize * 1.2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jost',
                  color: Color(0xFF071D99),
                ),
              ),
              GestureDetector(
                onTap: _showAddActivityDialog,
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
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.category,
                                size: 20,
                                color: Color(0xFF071D99),
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
                              const Icon(
                                Icons.description,
                                size: 20,
                                color: Color(0xFF071D99),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  activity.description,
                                  style: TextStyle(color: Colors.grey[800]),
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
    Scaffold.of(
      context,
    ).openEndDrawer(); // Use openEndDrawer to open the drawer from the right
  }

  Drawer _buildMainMenuDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFFD7A61F),
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      _name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jost',
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      _description,
                      style: TextStyle(fontSize: 12, fontFamily: 'Inter'),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Color(0xFF071D99),
              ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsPage(),
                  ),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FAQs()),
                );
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
                showDialog(
                  //logout dialog
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
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

  List<Activity> _getEventsForDay(DateTime day) {
    return activities
        .where(
          (activity) =>
              activity.date.year == day.year &&
              activity.date.month == day.month &&
              activity.date.day == day.day,
        )
        .toList();
  }

  void _showEventsBottomSheet(DateTime selectedDay) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.width * 0.03;
    final events = _getEventsForDay(selectedDay);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Events on ${selectedDay.month}/${selectedDay.day}/${selectedDay.year}',
                        style: TextStyle(
                          fontSize: fontSize * 1.2,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF071D99),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                events.isEmpty
                    ? Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'No events for this day',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: fontSize,
                        ),
                      ),
                    )
                    : Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF071D99,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  _getCategoryIcon(event.category),
                                  color: const Color(0xFF071D99),
                                ),
                              ),
                              title: Text(
                                event.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF071D99),
                                ),
                              ),
                              subtitle: Text(event.description),
                            ),
                          );
                        },
                      ),
                    ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
              ],
            ),
          ),
    );
  }

  Widget _buildCalendarSection() {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.width * 0.03;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Calendar',
            style: TextStyle(
              fontSize: fontSize * 1.2,
              fontWeight: FontWeight.bold,
              fontFamily: 'Jost',
              color: const Color(0xFF071D99),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD7A61F)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.now().subtract(const Duration(days: 365)),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    _showEventsBottomSheet(selectedDay);
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  eventLoader: _getEventsForDay,
                  calendarStyle: const CalendarStyle(
                    markersMaxCount: 3,
                    markerDecoration: BoxDecoration(
                      color: Color(0xFF071D99),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Color(0xFF071D99),
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Color(0xFFD7A61F),
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontSize: fontSize * 1.2,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF071D99),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final fontSize = width * 0.03;

    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ), // Blue background
      endDrawer: _buildMainMenuDrawer(), // Use endDrawer for right-side drawer
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 30),
        child: Column(
          children: [
            // Profile Section
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 32.0,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF071D99),
                    Color(0xFFD7A61F),
                  ], // Blue to Yellow gradient
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
                        MaterialPageRoute(
                          builder:
                              (context) => ProfilePage(
                                isOrganization: false,
                                orgName: _name,
                                description: _description,
                              ),
                        ),
                      ).then((result) {
                        // Update dashboard with the returned profile data
                        if (result != null && result is Map<String, dynamic>) {
                          setState(() {
                            _name = result['name'] ?? _name;
                            _description =
                                result['description'] ?? _description;
                          });
                        }
                      });
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Hero(
                        tag: 'orgProfileImage',
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(_profileImageUrl),
                          onBackgroundImageError: (_, __) {
                            setState(() {
                              _profileImageUrl = 'https://picsum.photos/200?random=1';
                            });
                          },
                          child: _profileImageUrl.isEmpty ? const Icon(
                            Icons.person,
                            size: 30,
                            color: Color(0xFF071D99),
                          ) : null,
                        ),
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
                          style: TextStyle(
                            fontSize: fontSize * 1.4,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jost',
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          _description,
                          style: TextStyle(
                            fontSize: fontSize * 1.2,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder:
                        (context) => Row(
                          children: [
                            IconButton(
                              icon: Stack(
                                children: [
                                  const Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                  ),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const NotificationsPage(),
                                  ),
                                );
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

            // Analytics Summary
            _buildAnalyticsSummary(),

            const SizedBox(height: 20),

            // Navigation Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Where Do You Want To Go?',
                    style: TextStyle(
                      fontSize: fontSize * 1.2,
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
                            color: const Color.fromARGB(
                              255,
                              8,
                              33,
                              96,
                            ), // Dark blue
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
                                  Icon(
                                    item.icon,
                                    size: 48,
                                    color: const Color(0xFFD7A61F),
                                  ), // Yellow icons
                                  const SizedBox(height: 12),
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      fontSize: fontSize * 1,
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
            _buildCalendarSection(),

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

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

class DashboardItem {
  final String title;
  final IconData icon;
  final String type;

  DashboardItem({required this.title, required this.icon, this.type = 'page'});
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
