import 'package:flutter/material.dart';
import 'eventfinderpage.dart';

class EventDetailsPage extends StatefulWidget {
  final Event event;
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
  bool isBookmarked = false;
  bool isAttending = false;   

  @override
  void initState() {
    super.initState();
    // Initialize bookmark state from the event
    isBookmarked = widget.event.isBookmarked;
    isAttending = widget.event.isAttending;   
  }

  void _toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
      // Update the event's bookmark status
      widget.event.isBookmarked = isBookmarked;
      // Notify parent widget about the change
      widget.onBookmarkChanged?.call(isBookmarked);
    });
  }

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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF071D99),
                    Color(0xFFD7A61F), 
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      widget.event.imageUrl,
                      width: double.infinity,
                      height: height * 0.3,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height: height * 0.3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.all(contentPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            IconButton(
                              icon: Icon(
                                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                color: Colors.white,
                              ),
                              onPressed: _toggleBookmark,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: height * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * 0.04),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(contentPadding * 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.event.title,
                            style: TextStyle(
                              fontSize: fontSize * 2,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF071D99),
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, 
                                   size: fontSize * 1.2,
                                   color: const Color(0xFF071D99)),
                              SizedBox(width: width * 0.02),
                              Text(
                                widget.event.date.toString().split(' ')[0],
                                style: TextStyle(
                                  fontSize: fontSize * 1.2,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(width: width * 0.04),
                              Icon(Icons.location_on,
                                   size: fontSize * 1.2,
                                   color: const Color(0xFF071D99)),
                              SizedBox(width: width * 0.02),
                              Text(
                                widget.event.location,
                                style: TextStyle(
                                  fontSize: fontSize * 1.2,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.03),
                          Text(
                            widget.event.description,
                            style: TextStyle(
                              fontSize: fontSize * 1.2,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: height * 0.04),
                          SizedBox(
                            width: double.infinity,
                            height: height * 0.06,
                            child: ElevatedButton(
                              onPressed: _toggleAttending,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isAttending ? const Color(0xFFD7A61F) : const Color(0xFF071D99),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                isAttending ? 'Attending' : 'Attend Event',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSize * 1.1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

