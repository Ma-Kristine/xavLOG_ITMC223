/// Event Details Page
/// 
/// Purpose: Displays detailed information about a selected event and allows
/// users to bookmark events or mark attendance.
/// 
/// Flow:
/// 1. User navigates to this page from the event finder
/// 2. Event details are displayed including image, title, date, location, and description
/// 3. User can mark themselves as attending the event
/// 4. User can bookmark the event for later reference
/// 
/// UI Components:
/// - Header image with gradient overlay
/// - Back navigation and bookmark buttons
/// - Event title and key information chips
/// - Detailed event description
/// - Attendance toggle button
/// 
/// Backend Implementation Needed:
/// - Save bookmark status to user profile
/// - Track event attendance for analytics
/// - Notify event organizers of attendance changes
/// - Sync attendance status across devices

import 'package:flutter/material.dart';
import 'package:xavlogsigninpage/models/event.dart' as eventfinder;

class EventDetailsPage extends StatefulWidget {
  final eventfinder.Event event;
  final Function(bool)? onBookmarkChanged;
  final Function(bool)? onAttendingChanged;

  const EventDetailsPage({
    super.key,
    required this.event,
    this.onBookmarkChanged,
    this.onAttendingChanged,
  });

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  // Track whether the event is bookmarked or being attended by the user
  bool isBookmarked = false;
  bool isAttending = false;

  @override
  void initState() {
    super.initState();
    // Initialize state from passed event data
    isBookmarked = widget.event.isBookmarked;
    isAttending = widget.event.isAttending;
  }

  /// Toggles the bookmark status and notifies parent via callback
  void _toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
      widget.event.isBookmarked = isBookmarked;
      widget.onBookmarkChanged?.call(isBookmarked);
    });
  }

  /// Toggles the attending status and notifies parent via callback
  void _toggleAttending() {
    setState(() {
      isAttending = !isAttending;
      widget.event.isAttending = isAttending;
      widget.onAttendingChanged?.call(isAttending);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;
    
    final fontSize = width * 0.03;
    final contentPadding = width * 0.02;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Image with Overlay
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                    child: Image.network(
                      widget.event.imageUrl,
                      width: double.infinity,
                      height: height * 0.35,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: height * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // App Bar
                  Padding(
                    padding: EdgeInsets.all(contentPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: Icon(
                              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                              color: isBookmarked ? Color(0xFFD7A61F) : Colors.white,
                            ),
                            onPressed: _toggleBookmark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              // Event Details
              Padding(
                padding: EdgeInsets.all(width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.event.title,
                      style: TextStyle(
                        fontSize: fontSize * 2.2,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF071D99),
                        letterSpacing: -0.5,
                      ),
                    ),
                    
                    SizedBox(height: height * 0.025),
                    
                    // Date and Location
                    Row(
                      children: [
                        _buildInfoChip(
                          Icons.calendar_today,
                          widget.event.date.toString().split(' ')[0],
                          fontSize,
                        ),
                        SizedBox(width: width * 0.03),
                        _buildInfoChip(
                          Icons.location_on,
                          widget.event.location,
                          fontSize,
                        ),
                      ],
                    ),
                    
                    // Divider
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.025),
                      child: Divider(thickness: 1, color: Colors.grey.shade200),
                    ),
                    
                    // About Section Header
                    Text(
                      "About Event",
                      style: TextStyle(
                        fontSize: fontSize * 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    
                    SizedBox(height: height * 0.015),
                    
                    // Description
                    Text(
                      widget.event.description,
                      style: TextStyle(
                        fontSize: fontSize * 1.2,
                        color: Colors.grey[700],
                        height: 1.6,
                      ),
                    ),
                    
                    SizedBox(height: height * 0.04),
                    
                    // Attend Button
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.065,
                      child: ElevatedButton(
                        onPressed: _toggleAttending,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isAttending ? const Color(0xFFD7A61F) : const Color(0xFF071D99),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(isAttending ? Icons.check_circle : Icons.calendar_month),
                            SizedBox(width: width * 0.02),
                            Text(
                              isAttending ? 'Attending' : 'Attend Event',
                              style: TextStyle(
                                fontSize: fontSize * 1.3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: height * 0.03),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Builds a styled information chip with an icon and label
  Widget _buildInfoChip(IconData icon, String label, double fontSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: fontSize * 1.3, color: const Color(0xFF071D99)),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize * 1.1,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

