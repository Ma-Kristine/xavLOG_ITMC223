import 'package:flutter/material.dart';

class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});
}

class Event {
  final String title;
  final String category;
  final String location;
  final DateTime date;
  final String imageUrl;

  Event({
    required this.title,
    required this.category,
    required this.date,
    required this.location,
    required this.imageUrl,
  });
}

class EventFinderPage extends StatefulWidget {
  const EventFinderPage({super.key});

  @override
  State<EventFinderPage> createState() => _EventFinderPageState();
}

class _EventFinderPageState extends State<EventFinderPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';


////////picsum for temp pics ////////////////
  final List<Category> _categories = [
    Category(name: 'All', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'College', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'Organization', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'Individual', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'School', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'External', imageUrl: 'https://picsum.photos/100'),
  ];

  // Sample events data
  final List<Event> _events = [
    Event(
      title: 'College Fair 2024',
      category: 'College',
      date: DateTime.now(),
      location: 'Main Campus',
      imageUrl: 'https://picsum.photos/160/100',
    ),
    Event(
      title: 'Tech Summit',
      category: 'Organization',
      date: DateTime.now().add(const Duration(days: 1)),
      location: 'Innovation Hub',
      imageUrl: 'https://picsum.photos/160/100',
    ),
    //////////////////// Add more events as needed //////////////////////
  ];

  List<Event> _getFilteredEvents() {
    if (_selectedCategory == 'All') {
      return _events;
    }
    return _events.where((event) => event.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Search and Filter Section
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF071D99),  // Blue
                      Color(0xFF2C3E91),  // Lighter blue
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.2,
                          child: Image.asset(
                            'images/xavloglogo.png',
                            height: screenHeight * 0.06,
                            fit: BoxFit.contain,
                            color: Colors.white,  // Make logo white
                          ),
                        ),
                        // Profile Section
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [
                                    Text(
                                      'Hello, Francis',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,  // Make text white
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '2-BSIT',
                                      style: TextStyle(
                                        color: Colors.white70,  // Make text white with opacity
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.03),
                              CircleAvatar(
                                radius: screenWidth * 0.06,
                                backgroundImage: const NetworkImage('https://picsum.photos/100'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Search TextField with white background
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search events',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,  // Remove border
                        ),
                        filled: true,
                        fillColor: Colors.white,  // White background for search box
                        contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                          horizontal: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Categories Section
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.01, // Reduced from 0.02
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF071D99),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    SizedBox(
                      height: screenHeight * 0.10, // Reduced from 0.12
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: screenWidth * 0.03),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = _categories[index].name;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: _selectedCategory == _categories[index].name
                                            ? const Color(0xFF071D99)
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: screenWidth * 0.05,
                                      backgroundImage: NetworkImage(_categories[index].imageUrl),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    _categories[index].name,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: _selectedCategory == _categories[index].name
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
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

              // Just Announced Section starts immediately after
              ..._buildEventSections(screenWidth, screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build event sections
  List<Widget> _buildEventSections(double screenWidth, double screenHeight) {
    final filteredEvents = _getFilteredEvents();
    final sectionTitles = ['Just Announced', 'Your Events', 'Calendar Events'];
    
    return sectionTitles.map((title) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.01,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF071D99),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.25,
            child: filteredEvents.isEmpty
                ? Center(
                    child: Text(
                      'No events found for ${_selectedCategory}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) => _buildEventCard(
                      screenWidth,
                      screenHeight,
                      index,
                      title,
                      filteredEvents[index],
                    ),
                  ),
          ),
          SizedBox(height: screenHeight * 0.02),
        ],
      );
    }).toList();
  }

  Widget _buildEventCard(
    double screenWidth,
    double screenHeight,
    int index,
    String sectionTitle,
    Event event,
  ) {
    return Container(
      width: screenWidth * 0.45,
      margin: EdgeInsets.only(right: screenWidth * 0.04),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    event.imageUrl,
                    height: screenHeight * 0.12,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        event.date.toString().split(' ')[0],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        event.location,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Bookmark Button (replaced heart/favorite icon)
            Positioned(
              top: screenHeight * 0.01,
              right: screenWidth * 0.02,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.bookmark_border, // Changed to bookmark icon
                    color: Color(0xFF071D99), // Changed to blue color to match theme
                    size: 20,
                  ),
                  onPressed: () {
                    // Add bookmark functionality
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}