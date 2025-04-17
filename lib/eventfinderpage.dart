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
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    // Adjusted dimensions for better fit
    final logoSize = width * 0.15; // Reduced from 0.45
    final fontSize = width * 0.03;
    final contentPadding = width * 0.02;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: contentPadding * 2,
                  vertical: height * 0.04,
                ),
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: logoSize,
                          child: Image.asset(
                            'images/xavloglogo.png',
                            height: height * 0.08,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Hello, Francis',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize * 1.2,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '2-BSIT',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: fontSize,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: width * 0.03),
                              CircleAvatar(
                                radius: width * 0.04,
                                backgroundImage: const NetworkImage('https://picsum.photos/100'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    // Search TextField
                    TextField(
                      controller: _searchController,
                      style: TextStyle(fontSize: fontSize),
                      decoration: InputDecoration(
                        hintText: 'Search events',
                        hintStyle: TextStyle(fontSize: fontSize),
                        prefixIcon: Icon(Icons.search, size: fontSize * 1.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: height * 0.015,
                          horizontal: width * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Categories Section
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: contentPadding * 2,
                  vertical: height * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: fontSize * 1.3,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF071D99),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    SizedBox(
                      height: height * 0.10,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: width * 0.03),
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
                                      radius: width * 0.05,
                                      backgroundImage: NetworkImage(_categories[index].imageUrl),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Text(
                                    _categories[index].name,
                                    style: TextStyle(
                                      fontSize: fontSize,
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
              ..._buildEventSections(width, height),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build event sections
  List<Widget> _buildEventSections(double width, double height) {
    final fontSize = width * 0.03;
    final filteredEvents = _getFilteredEvents();
    final sectionTitles = ['Just Announced', 'Your Events', 'Calendar Events'];

    return sectionTitles.map((title) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.01,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: fontSize * 1.3,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF071D99),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.25,
            child: filteredEvents.isEmpty
                ? Center(
                    child: Text(
                      'No events found for $_selectedCategory',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: fontSize * 1.2,
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) => _buildEventCard(
                      width,
                      height,
                      index,
                      title,
                      filteredEvents[index],
                    ),
                  ),
          ),
          SizedBox(height: height * 0.02),
        ],
      );
    }).toList();
  }

  Widget _buildEventCard(
    double width,
    double height,
    int index,
    String sectionTitle,
    Event event,
  ) {
    final cardWidth = width * 0.45;
    final cardHeight = height * 0.28;
    final imageHeight = cardHeight * 0.45;
    final contentPadding = width * 0.03;
    final iconSize = width * 0.05;

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.only(right: width * 0.04),
      child: Card(
        elevation: 2,
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
                    height: imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: imageHeight,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_not_supported,
                          size: iconSize * 2,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(contentPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          event.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.035,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          event.date.toString().split(' ')[0],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: width * 0.03,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          event.location,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: width * 0.03,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: contentPadding,
              right: contentPadding,
              child: Container(
                padding: EdgeInsets.all(contentPadding * 0.5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(iconSize),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.bookmark_border,
                    color: const Color(0xFF071D99),
                    size: iconSize,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(
                    minWidth: iconSize * 1.5,
                    minHeight: iconSize * 1.5,
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