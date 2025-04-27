/// Organization Dashboard
/// 
/// Purpose: Main interface for organization accounts to manage members,
/// events, finances, and communications.
/// 
/// Flow:
/// 1. Organization admin logs in and accesses this dashboard
/// 2. Admin can view analytics summary and manage organization activities
/// 3. Admin can manage members, events, and finances
/// 4. Admin can access communication tools and settings
/// 
/// Backend Implementation Needed:
/// - Organization profile data retrieval and storage
/// - Member management system with roles and permissions
/// - Event tracking and management API integration
/// - Financial transaction recording and reporting
/// - Communication system for announcements and messaging
library;

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'profile.dart';
import '../login/login_page.dart';
import '../login/faqs.dart';
import '../event_finder/notifications_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrgDashboard extends StatefulWidget {
  // BACKEND: These should be loaded from the organization's profile in the database
  final String? orgName;
  final String? description;
  final String? profileImageUrl;

  const OrgDashboard({
    super.key, 
    this.orgName,
    this.description,
    this.profileImageUrl,
  });

  @override
  State<OrgDashboard> createState() => _OrgDashboardState();
}

class _OrgDashboardState extends State<OrgDashboard> {
  // Organization profile information - BACKEND: Should be loaded from profile API
  late String _orgName;
  late String _description;
  
  // DYNAMIC: Notification count should update in real-time
  final String _notifNumber = '5';
  
  // BACKEND: These counts should be fetched from the database
  int _memberCount = 124;
  int _eventCount = 15;
  int _pendingRequests = 8;
  
  // BACKEND: These should be loaded from organization profile in database
  String _profileImageUrl = 'https://picsum.photos/200?random=1';
  String _orgContact = '+1 234 567 8900';
  String _orgEmail = 'csc.organization@example.com'; 

  // Activity form controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  // DYNAMIC: Selected category should persist between sessions
  String _selectedCategory = 'Meeting'; // Default category
  
  // DYNAMIC: Selected date should default to current date
  DateTime _selectedDate = DateTime.now();

  // Calendar configuration
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // BACKEND: These categories should be configurable by organization admin
  final List<String> _activityCategories = [
    'Meeting',
    'Event',
    'Workshop',
    'Announcement',
    'Deadline',
  ];

  // BACKEND: Dashboard items should be dynamic based on admin permissions
  final List<DashboardItem> navigationItems = [
    DashboardItem(
      title: 'Member Directory',
      icon: Icons.people,
      type: 'page',
    ),
    DashboardItem(title: 'Event Management', icon: Icons.event, type: 'page'),
    DashboardItem(title: 'Finance Tracker', icon: Icons.account_balance_wallet, type: 'page'),
    DashboardItem(title: 'Communication Hub', icon: Icons.forum, type: 'page'),
    DashboardItem(title: 'Resource Library', icon: Icons.folder, type: 'page'),
    DashboardItem(
      title: 'Attendance Tracking',
      icon: Icons.fact_check,
      type: 'page',
    ),
    DashboardItem(
      title: 'Analytics Portal',
      icon: Icons.analytics,
      type: 'page',
    ),
  ];

  // BACKEND: Activities should be loaded from database and updated in real-time
  final List<Activity> activities = [
    Activity(
      title: 'General Assembly',
      description: 'Monthly meeting with all members to discuss updates and initiatives',
      date: DateTime.now().add(const Duration(days: 2)),
      category: 'Meeting',
    ),
    Activity(
      title: 'CS Career Fair',
      description: 'Annual career fair with industry partners',
      date: DateTime.now().add(const Duration(days: 5)),
      category: 'Event',
    ),
    Activity(
      title: 'Flutter Workshop',
      description: 'Hands-on session for mobile app development',
      date: DateTime.now().add(const Duration(days: 7)),
      category: 'Workshop',
    ),
    Activity(
      title: 'Membership Renewal Deadline',
      description: 'Last day to renew membership for the semester',
      date: DateTime.now().add(const Duration(days: 14)),
      category: 'Deadline',
    ),
  ];

  // BACKEND: Members list should be fetched from database
  // DYNAMIC: Should update when new members join or leave
  final List<Member> members = [
    Member(
      name: 'Maria Garcia',
      role: 'President',
      joinDate: DateTime.now().subtract(const Duration(days: 365)),
      department: 'Computer Science',
      imageUrl: 'https://picsum.photos/200?random=1',
    ),
    Member(
      name: 'John Smith',
      role: 'Vice President',
      joinDate: DateTime.now().subtract(const Duration(days: 300)),
      department: 'Information Technology',
      imageUrl: 'https://picsum.photos/200?random=2',
    ),
    Member(
      name: 'Emily Johnson',
      role: 'Secretary',
      joinDate: DateTime.now().subtract(const Duration(days: 290)),
      department: 'Computer Science',
      imageUrl: 'https://picsum.photos/200?random=3',
    ),
    Member(
      name: 'Michael Wilson',
      role: 'Treasurer',
      joinDate: DateTime.now().subtract(const Duration(days: 280)),
      department: 'Information Technology',
      imageUrl: 'https://picsum.photos/200?random=4',
    ),
  ];

  // BACKEND: Pending requests should be fetched from membership API
  // DYNAMIC: Should update when new requests come in
  final List<MembershipRequest> pendingRequests = [
    MembershipRequest(
      name: 'Sofia Martinez',
      department: 'Computer Science',
      year: '2nd Year',
      date: DateTime.now().subtract(const Duration(days: 2)),
      imageUrl: 'https://picsum.photos/200?random=5',
    ),
    MembershipRequest(
      name: 'David Lee',
      department: 'Information Technology',
      year: '3rd Year',
      date: DateTime.now().subtract(const Duration(days: 3)),
      imageUrl: 'https://picsum.photos/200?random=6',
    ),
    MembershipRequest(
      name: 'Aisha Patel',
      department: 'Computer Science',
      year: '1st Year',
      date: DateTime.now().subtract(const Duration(days: 5)),
      imageUrl: 'https://picsum.photos/200?random=7',
    ),
  ];

  // BACKEND: Financial data should be fetched from finance API
  // DYNAMIC: Should update when new transactions are recorded
  final List<Transaction> transactions = [
    Transaction(
      title: 'Membership Dues',
      amount: 2500.00,
      date: DateTime.now().subtract(const Duration(days: 10)),
      type: TransactionType.income,
      category: 'Dues',
    ),
    Transaction(
      title: 'Workshop Materials',
      amount: 850.00,
      date: DateTime.now().subtract(const Duration(days: 15)),
      type: TransactionType.expense,
      category: 'Events',
    ),
    Transaction(
      title: 'Sponsorship',
      amount: 5000.00,
      date: DateTime.now().subtract(const Duration(days: 20)),
      type: TransactionType.income,
      category: 'Sponsorship',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with provided values or defaults
    // BACKEND: These should come from authenticated user session
    _orgName = widget.orgName ?? 'Computer Science Society';
    _description = widget.description ?? 'Student Organization';
    if (widget.profileImageUrl != null) {
      _profileImageUrl = widget.profileImageUrl!;
    }
    
    // Load saved data
    _loadSavedData();
  }

  // BACKEND: This should be replaced with API calls to fetch organization data
  Future<void> _loadSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _orgName = prefs.getString('orgName') ?? _orgName;
        _description = prefs.getString('orgDescription') ?? _description;
        _profileImageUrl = prefs.getString('orgProfileImage') ?? _profileImageUrl;
        _orgContact = prefs.getString('orgContact') ?? _orgContact;
        _orgEmail = prefs.getString('orgEmail') ?? _orgEmail;
        _memberCount = prefs.getInt('memberCount') ?? _memberCount;
        _eventCount = prefs.getInt('eventCount') ?? _eventCount;
        _pendingRequests = prefs.getInt('pendingRequests') ?? _pendingRequests;
      });
    } catch (e) {
      // BACKEND: Should implement proper error handling and logging
      print('Error loading saved data: $e');
    }
  }

  // BACKEND: This should call API to save organization data
  Future<void> _saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('orgName', _orgName);
      await prefs.setString('orgDescription', _description);
      await prefs.setString('orgProfileImage', _profileImageUrl);
      await prefs.setInt('memberCount', _memberCount);
      await prefs.setInt('eventCount', _eventCount);
      await prefs.setInt('pendingRequests', _pendingRequests);
    } catch (e) {
      // BACKEND: Should implement proper error handling and logging
      print('Error saving data: $e');
    }
  }

  // BACKEND: This should update the organization name in the database
  void updateOrgName(String newName) {
    setState(() {
      _orgName = newName;
    });
    _saveData();
  }

  // BACKEND: This should update the organization description in the database
  void updateDescription(String newDescription) {
    setState(() {
      _description = newDescription;
    });
    _saveData();
  }
  
  // BACKEND: This should update the profile image in storage and database
  void updateProfileImage(String newImageUrl) {
    setState(() {
      _profileImageUrl = newImageUrl;
    });
    _saveData();
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
            'Create Organization Activity',
            style: TextStyle(
              fontSize: fontSize * 1.3,
              fontWeight: FontWeight.bold,
              fontFamily: 'Jost',
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
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                    ),
                    const Text('Notify all members'),
                  ],
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
                _selectedCategory = 'Meeting';
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
                  _selectedCategory = 'Meeting';
                  _selectedDate = DateTime.now();
                  
                  // Show confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Activity created and notification sent to members'),
                      backgroundColor: Color(0xFF071D99),
                    ),
                  );
                }
              },
              child: const Text(
                'Create Activity',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOrgAnalyticsSummary() {
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
            'Organization Dashboard',
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
                      _buildStatCard(
                        'Total Members',
                        '$_memberCount',
                        Icons.people,
                        fontSize * 1.2,
                      ),
                      _buildStatCard(
                        'Events Hosted',
                        '$_eventCount',
                        Icons.event,
                        fontSize * 1.2,
                      ),
                      _buildStatCard(
                        'Pending Requests',
                        '$_pendingRequests',
                        Icons.person_add,
                        fontSize * 1.2,
                      ),
                      _buildStatCard(
                        'Budget Balance',
                        '\$6,650',
                        Icons.account_balance_wallet,
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
                    title: const Text('View Detailed Analytics'),
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
      builder: (context) => Container(
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
                    'Organization Analytics',
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
                  // Member demographics card
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Member Demographics',
                            style: TextStyle(
                              fontFamily: 'Jost',
                              fontSize: fontSize * 1.2,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF071D99),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildPieChartItem('CS', 0.6, const Color(0xFF071D99)),
                              _buildPieChartItem('IT', 0.3, const Color(0xFFD7A61F)),
                              _buildPieChartItem('Other', 0.1, Colors.grey),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text('Department Distribution'),
                        ],
                      ),
                    ),
                  ),
                  
                  // Attendance Analytics
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Event Attendance',
                            style: TextStyle(
                              fontFamily: 'Jost',
                              fontSize: fontSize * 1.2,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF071D99),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: _buildBarChart(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Financial Analytics
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Financial Overview',
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
                                      'Income',
                                      style: TextStyle(
                                        fontFamily: 'Jost',
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$7,500',
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
                                      'Expenses',
                                      style: TextStyle(
                                        fontFamily: 'Jost',
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$850',
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
                          const SizedBox(height: 16),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Balance'),
                              Text(
                                '\$6,650',
                                style: TextStyle(
                                  fontFamily: 'Jost',
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF071D99),
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
        Text(
          label,
          style: const TextStyle(fontFamily: 'Jost'),
        ),
      ],
    );
  }

  Widget _buildBarChart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildBar('General Assembly', 0.85, const Color(0xFF071D99)),
        _buildBar('CS Career Fair', 0.95, const Color(0xFFD7A61F)),
        _buildBar('Flutter Workshop', 0.68, const Color(0xFF071D99)),
        _buildBar('Hackathon', 0.78, const Color(0xFFD7A61F)),
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
          style: const TextStyle(
            fontFamily: 'Jost',
            fontSize: 12,
          ),
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
              fontFamily: 'Jost',
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
                'Organization Activities',
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
                  message: 'Create Activity',
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
                      fontFamily: 'Jost',
                      color: Color(0xFF071D99),
                    ),
                  ),
                  subtitle: Text(
                    _formatDate(activity.date),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Jost',
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
                                  fontFamily: 'Jost',
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
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: 'Jost',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF071D99),
                                ),
                                icon: const Icon(Icons.edit),
                                label: const Text('Edit'),
                                onPressed: () {},
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF071D99),
                                ),
                                icon: const Icon(Icons.notifications, color: Colors.white),
                                label: const Text(
                                  'Notify Members',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Notification sent to all members'),
                                    ),
                                  );
                                },
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
      case 'Meeting':
        return Icons.groups;
      case 'Event':
        return Icons.event;
      case 'Workshop':
        return Icons.build;
      case 'Announcement':
        return Icons.campaign;
      case 'Deadline':
        return Icons.timelapse;
      default:
        return Icons.event_note;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  void _showMainMenu(BuildContext context) {
    Scaffold.of(context).openEndDrawer(); // Use openEndDrawer to open the drawer from the right
  }

  Drawer _buildMainMenuDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF071D99),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      // Updated profile image in drawer
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context); // Close drawer first
                          
                          // Navigate to profile page and wait for result
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                isOrganization: true,
                                orgName: _orgName,
                                description: _description,
                                orgcontact: _orgContact,
                                orgemail: _orgEmail,
                              ),
                            ),
                          ).then((result) {
                            // Update dashboard with the returned profile data
                            if (result != null && result is Map<String, dynamic>) {
                              setState(() {
                                _orgName = result['name'] ?? _orgName;
                                _description = result['description'] ?? _description;
                              });
                              _saveData();
                            }
                          });
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xFFD7A61F),
                          backgroundImage: NetworkImage(_profileImageUrl),
                          onBackgroundImageError: (_, __) => setState(() {
                            _profileImageUrl = 'https://picsum.photos/200?random=1';
                          }),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _orgName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Jost',
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              _description,
                              style: const TextStyle(
                                fontSize: 14, 
                                fontFamily: 'Jost',
                                color: Colors.white70,
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
            ListTile(
              leading: const Icon(
                Icons.person_search,
                color: Color(0xFF071D99),
              ),
              title: const Text('Member Applications', 
                style: TextStyle(fontFamily: 'Jost')),
              trailing: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF071D99),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$_pendingRequests',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Jost',
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showMemberRequests();
              },
            ),
            ListTile(
              leading: const Icon(Icons.campaign, color: Color(0xFF071D99)),
              title: const Text('Send Announcement', 
                style: TextStyle(fontFamily: 'Jost')),
              onTap: () {
                Navigator.pop(context);
                _showSendAnnouncementDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFF071D99)),
              title: const Text('Organization Settings', 
                style: TextStyle(fontFamily: 'Jost')),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help, color: Color(0xFF071D99)),
              title: const Text('Help & Support', 
                style: TextStyle(fontFamily: 'Jost')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FAQs()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF071D99)),
              title: const Text('Logout', 
                style: TextStyle(fontFamily: 'Jost')),
              onTap: () {
                showDialog(
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

  void _showMemberRequests() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
                    'Membership Requests',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jost',
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
              child: ListView.builder(
                itemCount: pendingRequests.length,
                itemBuilder: (context, index) {
                  final request = pendingRequests[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(request.imageUrl),
                      ),
                      title: Text(
                        request.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jost',
                        ),
                      ),
                      subtitle: Text(
                        '${request.department} - ${request.year}',
                        style: const TextStyle(fontFamily: 'Jost'),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check_circle, color: Colors.green),
                            onPressed: () {
                              // Approve request
                              setState(() {
                                pendingRequests.removeAt(index);
                                _pendingRequests--;
                                _memberCount++;
                              });
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${request.name} approved as member'),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () {
                              // Reject request
                              setState(() {
                                pendingRequests.removeAt(index);
                                _pendingRequests--;
                              });
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${request.name} rejected'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSendAnnouncementDialog() {
    final titleController = TextEditingController();
    final messageController = TextEditingController();
    bool isSendingToAll = true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Send Organization Announcement',
          style: TextStyle(
            fontFamily: 'Jost',
            color: Color(0xFF071D99),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Announcement Title',
                  hintText: 'Enter title',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  hintText: 'Enter announcement message',
                ),
              ),
              const SizedBox(height: 16),
              StatefulBuilder(
                builder: (context, setState) => CheckboxListTile(
                  title: const Text('Send to all members'),
                  value: isSendingToAll,
                  onChanged: (value) {
                    setState(() {
                      isSendingToAll = value!;
                    });
                  },
                ),
              ),
              if (!isSendingToAll)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Select specific members',
                    style: TextStyle(
                      color: Color(0xFF071D99),
                      fontFamily: 'Jost',
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF071D99),
            ),
            onPressed: () {
              if (titleController.text.isNotEmpty && 
                  messageController.text.isNotEmpty) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isSendingToAll
                          ? 'Announcement sent to all members'
                          : 'Announcement sent to selected members',
                    ),
                    backgroundColor: const Color(0xFF071D99),
                  ),
                );
              }
            },
            child: const Text(
              'Send',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
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
                          fontFamily: 'Jost',
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
                          fontFamily: 'Jost',
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
                                  fontFamily: 'Jost',
                                ),
                              ),
                              subtitle: Text(
                                event.description,
                                style: const TextStyle(fontFamily: 'Jost'),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.checklist,
                                  color: Color(0xFF071D99),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _showAttendanceSheet(event);
                                },
                              ),
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

  void _showAttendanceSheet(Activity event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Attendance: ${event.title}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jost',
                            color: Color(0xFF071D99),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          _formatDate(event.date),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Jost',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search members...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF071D99),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16, 
                        vertical: 16,
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Attendance recorded'),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return CheckboxListTile(
                        secondary: CircleAvatar(
                          backgroundImage: NetworkImage(member.imageUrl),
                        ),
                        title: Text(
                          member.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jost',
                          ),
                        ),
                        subtitle: Text(
                          member.role,
                          style: const TextStyle(fontFamily: 'Jost'),
                        ),
                        value: member.isAttending,
                        onChanged: (value) {
                          setState(() {
                            member.isAttending = value!;
                          });
                        },
                      );
                    }
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinanceManagement() {
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
                'Financial Management',
                style: TextStyle(
                  fontSize: fontSize * 1.2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jost',
                  color: const Color(0xFF071D99),
                ),
              ),
              GestureDetector(
                onTap: _showAddTransactionDialog,
                child: Tooltip(
                  message: 'Add Transaction',
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFFD7A61F),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFinanceItem(
                        'Income',
                        '\$7,500',
                        Icons.arrow_upward,
                        Colors.green,
                      ),
                      Container(
                        height: 50,
                        width: 1,
                        color: Colors.grey[300],
                      ),
                      _buildFinanceItem(
                        'Expenses',
                        '\$850',
                        Icons.arrow_downward,
                        Colors.red,
                      ),
                      Container(
                        height: 50,
                        width: 1,
                        color: Colors.grey[300],
                      ),
                      _buildFinanceItem(
                        'Balance',
                        '\$6,650',
                        Icons.account_balance_wallet,
                        const Color(0xFF071D99),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Recent Transactions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jost',
                        color: Color(0xFF071D99),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...transactions.map((transaction) => _buildTransactionItem(transaction)),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF071D99),
                    ),
                    onPressed: () {
                      // View full financial report
                    },
                    child: const Text('View Full Report'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinanceItem(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Jost',
            color: color,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Jost',
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    final isIncome = transaction.type == TransactionType.income;
    
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isIncome ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          isIncome ? Icons.arrow_upward : Icons.arrow_downward,
          color: isIncome ? Colors.green : Colors.red,
        ),
      ),
      title: Text(
        transaction.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Jost',
        ),
      ),
      subtitle: Text(
        '${transaction.category} • ${_formatDate(transaction.date)}',
        style: const TextStyle(fontFamily: 'Jost'),
      ),
      trailing: Text(
        '${isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isIncome ? Colors.green : Colors.red,
          fontFamily: 'Jost',
        ),
      ),
    );
  }

  void _showAddTransactionDialog() {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    String selectedCategory = 'Dues';
    TransactionType selectedType = TransactionType.income;
    
    final categories = [
      'Dues',
      'Events',
      'Sponsorship',
      'Merchandise',
      'Equipment',
      'Other',
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add Transaction',
          style: TextStyle(
            fontFamily: 'Jost',
            color: Color(0xFF071D99),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Transaction Title',
                  hintText: 'Enter title',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Enter amount',
                  prefixText: '\$ ',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              StatefulBuilder(
                builder: (context, setState) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Transaction Type'),
                    Row(
                      children: [
                        Radio<TransactionType>(
                          value: TransactionType.income,
                          groupValue: selectedType,
                          onChanged: (value) {
                            setState(() {
                              selectedType = value!;
                            });
                          },
                        ),
                        const Text('Income'),
                        const SizedBox(width: 16),
                        Radio<TransactionType>(
                          value: TransactionType.expense,
                          groupValue: selectedType,
                          onChanged: (value) {
                            setState(() {
                              selectedType = value!;
                            });
                          },
                        ),
                        const Text('Expense'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              StatefulBuilder(
                builder: (context, setState) => DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF071D99),
            ),
            onPressed: () {
              if (titleController.text.isNotEmpty && 
                  amountController.text.isNotEmpty) {
                final amount = double.tryParse(amountController.text) ?? 0.0;
                
                setState(() {
                  transactions.add(
                    Transaction(
                      title: titleController.text,
                      amount: amount,
                      date: DateTime.now(),
                      type: selectedType,
                      category: selectedCategory,
                    ),
                  );
                });
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Transaction added successfully'),
                    backgroundColor: Color(0xFF071D99),
                  ),
                );
              }
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMemberDirectory() {
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
                'Organization Leadership',
                style: TextStyle(
                  fontSize: fontSize * 1.2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jost',
                  color: const Color(0xFF071D99),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // View full directory
                },
                child: Text(
                  'View All Members',
                  style: TextStyle(
                    fontSize: fontSize * 0.9,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Jost',
                    color: const Color(0xFFD7A61F),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(member.imageUrl),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        member.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jost',
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        member.role,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Jost',
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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
            'Organization Calendar',
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
                  // Profile image that navigates to profile page
                  GestureDetector(
                    onTap: () async {
                      // Navigate to profile page and wait for result
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            isOrganization: true,
                            orgName: _orgName,
                            description: _description,
                            orgcontact: _orgContact,
                            orgemail: _orgEmail,
                          ),
                        ),
                      ).then((result) {
                        // Update dashboard with the returned profile data
                        if (result != null && result is Map<String, dynamic>) {
                          setState(() {
                            _orgName = result['name'] ?? _orgName;
                            _description = result['description'] ?? _description;
                          });
                          _saveData();
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
                          'Hello, $_orgName',
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
                            fontFamily: 'Jost',
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
                                    builder: (context) => const NotificationsPage(),
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
            _buildOrgAnalyticsSummary(),

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

            const SizedBox(height: 20),

            // Member Directory
            _buildMemberDirectory(),

            const SizedBox(height: 20),

            // Finance Management
            _buildFinanceManagement(),
          ],
        ),
      ),
    );
  }

  Widget _getPageForItem(String title) {
    switch (title) {
      case 'Member Directory':
      // return const MemberDirectoryPage(); // Uncomment and implement this when ready
      case 'Event Management':
      // return const EventManagementPage(); // Uncomment and implement this when ready
      case 'Finance Tracker':
      // return const FinanceTrackerPage(); // Uncomment and implement this when ready
      case 'Communication Hub':
      // return const CommunicationHubPage(); // Uncomment and implement this when ready
      case 'Resource Library':
      // return const ResourceLibraryPage(); // Uncomment and implement this when ready
      case 'Attendance Tracking':
      // return const AttendanceTrackingPage(); // Uncomment and implement this when ready
      case 'Analytics Portal':
      // return const AnalyticsPortalPage(); // Uncomment and implement this when ready
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

class Member {
  final String name;
  final String role;
  final DateTime joinDate;
  final String department;
  final String imageUrl;
  bool isAttending;

  Member({
    required this.name,
    required this.role,
    required this.joinDate,
    required this.department,
    required this.imageUrl,
    this.isAttending = false,
  });
}

class MembershipRequest {
  final String name;
  final String department;
  final String year;
  final DateTime date;
  final String imageUrl;

  MembershipRequest({
    required this.name,
    required this.department,
    required this.year,
    required this.date,
    required this.imageUrl,
  });
}

class Transaction {
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String category;

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  });
}

enum TransactionType { income, expense }
