/// Notifications Page
/// 
/// Purpose: Displays and manages user notifications, allowing users to view,
/// filter, and interact with different types of notifications.
/// 
/// Flow:
/// 1. User navigates to the notifications page
/// 2. User can view all notifications categorized by type
/// 3. User can mark notifications as read or delete them
/// 4. User can filter notifications by category
/// 
/// Backend Implementation Needed:
/// - Real-time notification fetching from server
/// - Notification read status tracking
/// - Push notification integration
/// - Notification preference settings
library;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class NotificationsPage extends StatefulWidget {
  final String? orgName;
  // BACKEND: This should be determined by the user's account type in the authentication system
  final bool isOrganization;

  // Constructor with parameters
  const NotificationsPage({
    super.key,
    this.orgName,
    this.isOrganization = false, // Default to student view if not specified
  });

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // BACKEND: These should be loaded from the backend notification service
  // DYNAMIC: This list should update in real-time when new notifications arrive
  final List<Notification> _allNotifications = [];
  List<Notification> _filteredNotifications = [];
  bool _isLoading = true;
  String _selectedFilter = "All";
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
    _loadNotifications();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        switch (_tabController.index) {
          case 0:
            _selectedFilter = "All";
            break;
          case 1:
            _selectedFilter = "Unread";
            break;
          case 2:
            _selectedFilter = "Important";
            break;
        }
        _filterNotifications();
      });
    }
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _isLoading = true;
    });

    // Simulating API call delay
    await Future.delayed(const Duration(seconds: 1));

    // Generate sample notifications
    final random = Random();
    final List<Notification> notifications = [];

    final List<String> orgTitles = [
      "Meeting Reminder",
      "Event Update",
      "Budget Approval",
      "New Member Request",
      "Announcement",
      "Event Cancelled",
      "Deadline Approaching",
      "Feedback Required",
      "Document Shared",
      "Task Assignment"
    ];

    final List<String> orgContents = [
      "Don't forget about our upcoming general meeting tomorrow at 5 PM. Your attendance is required.",
      "The venue for the annual gala has been changed. Please check the updated location.",
      "The budget for the next quarter has been approved. Review the allocation details.",
      "3 new member requests are awaiting your approval. Please review their applications.",
      "Important announcement: Campus will be closed this Friday for maintenance.",
      "The workshop scheduled for Saturday has been cancelled due to low registration.",
      "Reminder: The deadline for submitting event proposals is next Monday.",
      "Please provide feedback on last week's event by completing the survey.",
      "New resources have been added to the shared drive. Check them out!",
      "You've been assigned to lead the fundraising committee. Details in your email."
    ];

    final List<String> studentTitles = [
      "Class Cancelled",
      "Grade Posted",
      "Scholarship Opportunity",
      "New Event",
      "Application Status",
      "Deadline Reminder",
      "Campus Announcement",
      "Meeting Invitation",
      "Assignment Update",
      "Survey Request"
    ];

    final List<String> studentContents = [
      "Your class tomorrow has been cancelled. The professor will send makeup details.",
      "Grades for your recent exam have been posted. Check your portal.",
      "New scholarship opportunity available. Application deadline is in two weeks.",
      "Computer Science Society is hosting a networking event this Thursday.",
      "Your application for the internship program has been received.",
      "Reminder: Your project submission is due this Friday at midnight.",
      "Campus library will have extended hours during finals week.",
      "You've been invited to join the student leadership forum.",
      "Changes to your assignment requirements have been posted.",
      "Please complete the student satisfaction survey by the end of the week."
    ];

    final now = DateTime.now();

    // Create sample notifications (more recent ones are unread)
    for (int i = 0; i < 20; i++) {
      final isOrgNotification = widget.isOrganization || random.nextBool();
      final titles = isOrgNotification ? orgTitles : studentTitles;
      final contents = isOrgNotification ? orgContents : studentContents;
      final titleIndex = random.nextInt(titles.length);
      
      final daysAgo = random.nextInt(30);
      final hoursAgo = random.nextInt(24);
      final minutesAgo = random.nextInt(60);
      
      final date = now.subtract(Duration(
        days: daysAgo,
        hours: hoursAgo,
        minutes: minutesAgo,
      ));
      
      final isUnread = daysAgo < 7 && random.nextBool();
      final isImportant = random.nextBool() && (daysAgo < 14 || isUnread);
      
      notifications.add(Notification(
        id: i.toString(),
        title: titles[titleIndex],
        content: contents[titleIndex],
        timestamp: date,
        isRead: !isUnread,
        isImportant: isImportant,
        type: isOrgNotification ? "Organization" : "Academic",
        sender: isOrgNotification 
            ? widget.orgName ?? "Computer Science Society" 
            : "Xavier University",
      ));
    }

    // Sort by date (newest first)
    notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    setState(() {
      _allNotifications.clear();
      _allNotifications.addAll(notifications);
      _filterNotifications();
      _isLoading = false;
    });
  }

  void _filterNotifications() {
    setState(() {
      switch (_selectedFilter) {
        case "Unread":
          _filteredNotifications = _allNotifications
              .where((notification) => !notification.isRead)
              .toList();
          break;
        case "Important":
          _filteredNotifications = _allNotifications
              .where((notification) => notification.isImportant)
              .toList();
          break;
        case "All":
        default:
          _filteredNotifications = List.from(_allNotifications);
          break;
      }

      // Apply search filter if text is entered
      if (_searchController.text.isNotEmpty) {
        final searchText = _searchController.text.toLowerCase();
        _filteredNotifications = _filteredNotifications
            .where((notification) =>
                notification.title.toLowerCase().contains(searchText) ||
                notification.content.toLowerCase().contains(searchText) ||
                notification.sender.toLowerCase().contains(searchText))
            .toList();
      }
    });
  }

  void _markAsRead(String id) {
    setState(() {
      final index = _allNotifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        _allNotifications[index] = _allNotifications[index].copyWith(isRead: true);
        _filterNotifications();
      }
    });
  }

  void _toggleImportant(String id) {
    setState(() {
      final index = _allNotifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        _allNotifications[index] = _allNotifications[index].copyWith(
          isImportant: !_allNotifications[index].isImportant,
        );
        _filterNotifications();
      }
    });
  }

  void _deleteNotification(String id) {
    setState(() {
      _allNotifications.removeWhere((n) => n.id == id);
      _filterNotifications();
    });
  }

  void _showNotificationDetails(Notification notification) {
    // Mark as read when opened
    if (!notification.isRead) {
      _markAsRead(notification.id);
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jost',
                            color: Color(0xFF071D99),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "From: ${notification.sender}",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Jost',
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.close),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            
            // Notification details
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Metadata
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF071D99).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              notification.type == "Organization" 
                                  ? Icons.groups 
                                  : Icons.school,
                              color: const Color(0xFF071D99),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            notification.type,
                            style: const TextStyle(
                              fontFamily: 'Jost',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF071D99),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF071D99).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              _formatTimestamp(notification.timestamp),
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF071D99),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Content
                    Text(
                      notification.content,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Jost',
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                    
                    // Additional placeholder content to make it look realistic
                    const SizedBox(height: 24),
                    if (notification.type == "Organization")
                      ..._buildOrganizationContent(notification)
                    else
                      ..._buildAcademicContent(notification),
                  ],
                ),
              ),
            ),
            
            // Actions
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.delete_outline,
                    label: "Delete",
                    color: Colors.red,
                    onTap: () {
                      _deleteNotification(notification.id);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Notification deleted"),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: notification.isImportant 
                        ? Icons.star 
                        : Icons.star_border,
                    label: notification.isImportant 
                        ? "Unmark" 
                        : "Important",
                    color: const Color(0xFFD7A61F),
                    onTap: () {
                      _toggleImportant(notification.id);
                      Navigator.pop(context);
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.reply,
                    label: "Reply",
                    color: const Color(0xFF071D99),
                    onTap: () {
                      Navigator.pop(context);
                      // Show reply dialog (not implemented in this example)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Reply feature coming soon"),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
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

  List<Widget> _buildOrganizationContent(Notification notification) {
    // Sample additional content for organization notifications
    return [
      if (notification.title.contains("Meeting"))
        ...[
          _buildSectionTitle("Meeting Details"),
          _buildDetailItem(Icons.calendar_today, "Date", "April 21, 2025"),
          _buildDetailItem(Icons.access_time, "Time", "5:00 PM - 6:30 PM"),
          _buildDetailItem(Icons.location_on, "Location", "Xavier Hall, Room 305"),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            icon: const Icon(Icons.event_available),
            label: const Text("Add to Calendar"),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF071D99),
            ),
            onPressed: () {
              // Calendar functionality would go here
            },
          ),
        ]
      else if (notification.title.contains("Event"))
        ...[
          _buildSectionTitle("Event Information"),
          _buildDetailItem(Icons.event, "Event", "Annual Networking Event"),
          _buildDetailItem(Icons.calendar_today, "Date", "April 25, 2025"),
          _buildDetailItem(Icons.location_on, "Venue", "Xavier University Grand Hall"),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.how_to_reg, color: Colors.white),
            label: const Text("Register Now", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF071D99),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            onPressed: () {
              // Registration functionality would go here
            },
          ),
        ]
      else if (notification.title.contains("Budget") || notification.title.contains("Feedback"))
        ...[
          _buildSectionTitle("Required Action"),
          _buildDetailItem(Icons.assignment, "Task", "Review and approve budget allocation"),
          _buildDetailItem(Icons.timelapse, "Deadline", "April 24, 2025"),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.check_circle, color: Colors.white),
            label: const Text("Take Action", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF071D99),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            onPressed: () {
              // Action functionality would go here
            },
          ),
        ]
      else
        ...[
          const SizedBox(height: 16),
          Text(
            "For more information, please contact the organization administrator.",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey[600],
              fontFamily: 'Jost',
            ),
          ),
        ],
    ];
  }

  List<Widget> _buildAcademicContent(Notification notification) {
    // Sample additional content for academic notifications
    return [
      if (notification.title.contains("Class") || notification.title.contains("Grade"))
        ...[
          _buildSectionTitle("Course Information"),
          _buildDetailItem(Icons.book, "Course", "CS 301 - Advanced Programming"),
          _buildDetailItem(Icons.person, "Professor", "Dr. Emily Chen"),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.launch, color: Colors.white),
            label: const Text("View Course Portal", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF071D99),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            onPressed: () {
              // Course portal navigation would go here
            },
          ),
        ]
      else if (notification.title.contains("Scholarship") || notification.title.contains("Application"))
        ...[
          _buildSectionTitle("Opportunity Details"),
          _buildDetailItem(Icons.school, "Program", "Merit Scholarship 2025"),
          _buildDetailItem(Icons.attach_money, "Award", "Up to \$5,000 per semester"),
          _buildDetailItem(Icons.date_range, "Deadline", "May 15, 2025"),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.edit_document, color: Colors.white),
            label: const Text("Apply Now", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF071D99),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            onPressed: () {
              // Application functionality would go here
            },
          ),
        ]
      else if (notification.title.contains("Deadline") || notification.title.contains("Assignment"))
        ...[
          _buildSectionTitle("Assignment Details"),
          _buildDetailItem(Icons.assignment, "Assignment", "Final Project Submission"),
          _buildDetailItem(Icons.calendar_today, "Due Date", "April 28, 2025 at 11:59 PM"),
          _buildDetailItem(Icons.grading, "Points", "150 points (15% of final grade)"),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.remove_red_eye),
                  label: const Text("View Instructions"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF071D99),
                  ),
                  onPressed: () {
                    // View instructions functionality would go here
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.upload_file, color: Colors.white),
                  label: const Text("Submit", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF071D99),
                  ),
                  onPressed: () {
                    // Submission functionality would go here
                  },
                ),
              ),
            ],
          ),
        ]
      else
        ...[
          const SizedBox(height: 16),
          Text(
            "For more information, please check your student portal or contact student services.",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey[600],
              fontFamily: 'Jost',
            ),
          ),
        ],
    ];
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Jost',
          color: Color(0xFF071D99),
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: const Color(0xFF071D99),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontFamily: 'Jost',
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Jost',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontFamily: 'Jost',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 7) {
      return DateFormat('MMM d, yyyy').format(timestamp);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.bold,
            color: Color(0xFF071D99),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF071D99),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF071D99),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Unread'),
            Tab(text: 'Important'),
          ],
          labelStyle: const TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Jost',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF071D99)),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: const Text(
                    'Search Notifications',
                    style: TextStyle(
                      fontFamily: 'Jost',
                      color: Color(0xFF071D99),
                    ),
                  ),
                  content: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Enter search term',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                    onChanged: (value) {
                      _filterNotifications();
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _searchController.clear();
                        _filterNotifications();
                        Navigator.pop(context);
                      },
                      child: const Text('Clear'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF071D99),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        _filterNotifications();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Search',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF071D99)),
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  MediaQuery.of(context).size.width,
                  kToolbarHeight,
                  0,
                  0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                items: [
                  const PopupMenuItem(
                    value: 'mark_all_read',
                    child: Text('Mark all as read'),
                  ),
                  const PopupMenuItem(
                    value: 'delete_all',
                    child: Text('Delete all'),
                  ),
                  const PopupMenuItem(
                    value: 'settings',
                    child: Text('Notification settings'),
                  ),
                ],
              ).then((value) {
                if (value == 'mark_all_read') {
                  setState(() {
                    for (var notification in _allNotifications) {
                      if (!notification.isRead) {
                        _markAsRead(notification.id);
                      }
                    }
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All notifications marked as read'),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  );
                } else if (value == 'delete_all') {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Text('Delete All Notifications'),
                      content: const Text(
                        'Are you sure you want to delete all notifications? This cannot be undone.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            setState(() {
                              _allNotifications.clear();
                              _filterNotifications();
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('All notifications deleted'),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Delete All',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (value == 'settings') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notification settings coming soon'),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  );
                }
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF071D99),
              ),
            )
          : _filteredNotifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_off_outlined,
                        size: 80,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _searchController.text.isNotEmpty
                            ? 'No notifications match your search'
                            : 'No notifications to display',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontFamily: 'Jost',
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (_searchController.text.isNotEmpty)
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF071D99),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            _filterNotifications();
                          },
                          icon: const Icon(Icons.clear, color: Colors.white),
                          label: const Text(
                            'Clear Search',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  color: const Color(0xFF071D99),
                  onRefresh: _loadNotifications,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredNotifications.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final notification = _filteredNotifications[index];
                      return _buildNotificationCard(notification);
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF071D99),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.refresh, color: Colors.white),
        onPressed: _loadNotifications,
      ),
    );
  }

  Widget _buildNotificationCard(Notification notification) {
    final bool isToday = DateTime.now().difference(notification.timestamp).inHours < 24;
    
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: notification.isRead 
              ? Colors.grey.withOpacity(0.15) 
              : const Color(0xFF071D99).withOpacity(0.5),
          width: notification.isRead ? 1 : 1.5,
        ),
      ),
      color: notification.isRead ? Colors.white : const Color(0xFF071D99).withOpacity(0.05),
      child: InkWell(
        onTap: () => _showNotificationDetails(notification),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: notification icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: notification.isRead
                      ? Colors.grey.withOpacity(0.1)
                      : const Color(0xFF071D99).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  notification.type == "Organization" ? Icons.groups : Icons.school,
                  color: notification.isRead ? Colors.grey : const Color(0xFF071D99),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              
              // Center: notification content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontWeight: notification.isRead ? FontWeight.w500 : FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Jost',
                              color: notification.isRead ? Colors.black87 : const Color(0xFF071D99),
                            ),
                          ),
                        ),
                        if (notification.isImportant)
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD7A61F).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.star,
                              color: Color(0xFFD7A61F),
                              size: 16,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          notification.type == "Organization" ? Icons.business : Icons.school,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          notification.sender,
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Jost',
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      notification.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                        fontFamily: 'Jost',
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _formatTimestamp(notification.timestamp),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontFamily: 'Jost',
                          ),
                        ),
                        const Spacer(),
                        if (isToday && !notification.isRead)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF071D99),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'NEW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}

// Model classes
/// Notification model representing a single notification
class Notification {
  final String id;          // Unique identifier
  final String title;       // Notification title
  final String content;     // Detailed notification message
  final DateTime timestamp; // When the notification was sent
  final String type;        // Category for filtering (Academic, Event, etc.)
  final bool isImportant;   // Whether the notification is marked as important
  bool isRead;              // Whether the user has read this notification
  final String sender;      // Sender of the notification
  
  // BACKEND: This constructor should be used when deserializing from API
  Notification({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.type,
    required this.isImportant,
    this.isRead = false,
    required this.sender,
  });
  
  // BACKEND: Add a factory constructor to create from JSON
  Notification copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? timestamp,
    String? type,
    bool? isImportant,
    bool? isRead,
    String? sender,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isImportant: isImportant ?? this.isImportant,
      isRead: isRead ?? this.isRead,
      sender: sender ?? this.sender,
    );
  }
}