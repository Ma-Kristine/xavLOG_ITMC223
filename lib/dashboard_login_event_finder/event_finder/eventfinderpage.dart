import 'package:flutter/material.dart';
import 'event_details_page.dart';
import '../../models/event.dart';
class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});
}



class EventFinderPage extends StatefulWidget {
  const EventFinderPage({super.key});

  @override
  State<EventFinderPage> createState() => _EventFinderPageState();
}

class _EventFinderPageState extends State<EventFinderPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  final List<Category> _categories = [
    Category(name: 'All', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'College', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'Organization', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'Individual', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'School', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'External', imageUrl: 'https://picsum.photos/100'),
  ];

  final List<Event> _events = [
    Event(
      title: 'College Fair 2024',
      category: 'College',
      date: DateTime.now(),
      location: 'Main Campus',
      imageUrl: 'https://picsum.photos/160/100',
      description: 'A fair showcasing various colleges and their programs.',
    ),
    Event(
      title: 'Tech Summit',
      category: 'Organization',
      date: DateTime.now().add(const Duration(days: 1)),
      location: 'Innovation Hub',
      imageUrl: 'https://picsum.photos/160/100',
      description: 'A summit for tech enthusiasts and professionals.',
    ),
    Event(
      title: 'Sports Festival',
      category: 'School',
      date: DateTime.now().add(const Duration(days: 2)),
      location: 'Sports Complex',
      imageUrl: 'https://picsum.photos/160/100',
      description: 'Annual sports festival featuring various competitions.',
    ),
    Event(
      title: 'Career Workshop',
      category: 'Individual',
      date: DateTime.now().add(const Duration(days: 3)),
      location: 'Conference Hall',
      imageUrl: 'https://picsum.photos/160/100',
      description: 'Workshop on career development and job hunting.',
    ),
    Event(
      title: 'Cultural Night',
      category: 'Organization',
      date: DateTime.now().add(const Duration(days: 4)),
      location: 'Auditorium',
      imageUrl: 'https://picsum.photos/160/100',
      description: 'A celebration of diverse cultures and traditions.',
    ),
  ];

  List<Event> _getFilteredEvents() {
    if (_selectedCategory == 'All') {
      return _events;
    }
    return _events.where((event) => event.category == _selectedCategory).toList();
  }

  List<Event> _getSearchResults(String query) {
    if (query.isEmpty) {
      return _getFilteredEvents();
    }
    
    final lowercaseQuery = query.toLowerCase();
    return _getFilteredEvents().where((event) {
      return event.title.toLowerCase().contains(lowercaseQuery) ||
             event.category.toLowerCase().contains(lowercaseQuery) ||
             event.location.toLowerCase().contains(lowercaseQuery) ||
             event.description.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  List<Event> get bookmarkedEvents => _events.where((event) => event.isBookmarked).toList();

  List<Event> get attendedEvents => _events.where((event) => event.isAttending).toList();

  void _showBookmarkedEvents() {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final fontSize = width * 0.03;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bookmarked Events',
                    style: TextStyle(
                      fontSize: fontSize * 1.3,
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
              child: bookmarkedEvents.isEmpty
                  ? Center(
                      child: Text(
                        'No bookmarked events yet',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: fontSize * 1.2,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: bookmarkedEvents.length,
                      itemBuilder: (context, index) => _buildListEventCard(
                        width,
                        MediaQuery.of(context).size.height,
                        bookmarkedEvents[index],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    final logoSize = width * 0.15;
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
                                        fontSize: fontSize * 1.4,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '2-BSIT',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: fontSize * 1.2,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: width * 0.03),
                              CircleAvatar(
                                radius: width * 0.08,
                                backgroundImage: const NetworkImage('https://picsum.photos/100'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    TextField(
                      controller: _searchController,
                      style: TextStyle(fontSize: fontSize),
                      onChanged: (value) {
                        setState(() {
                          // Trigger rebuild when search text changes
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search events by name, category, or location',
                        hintStyle: TextStyle(fontSize: fontSize),
                        prefixIcon: Icon(Icons.search, size: fontSize * 1.2),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear, size: fontSize * 1.2),
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                  });
                                },
                              )
                            : null,
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: contentPadding * 2,
                  vertical: height * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.02),
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
              ..._buildEventSections(width, height),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildEventSections(double width, double height) {
    final fontSize = width * 0.03;
    final searchQuery = _searchController.text;
    final filteredEvents = _getSearchResults(searchQuery);
    final attending = attendedEvents;

    // My Events section
    Widget myEventsSection = _buildSectionWithHeader(
      'My Events',
      attending,
      width,
      height,
      fontSize,
      true,
    );

    // Just Announced section
    Widget justAnnouncedSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.01,
          ),
          child: Text(
            'Just Announced',
            style: TextStyle(
              fontSize: fontSize * 1.3,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF071D99),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredEvents.length,
          itemBuilder: (context, index) => _buildListEventCard(
            width,
            height,
            filteredEvents[index],
          ),
        ),
      ],
    );

    return [
      myEventsSection,
      justAnnouncedSection,
    ];
  }

  Widget _buildSectionWithHeader(
    String title,
    List<Event> events,
    double width,
    double height,
    double fontSize,
    bool isHorizontalScroll,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.01,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: fontSize * 1.3,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF071D99),
                ),
              ),
              // Add bookmark icon only for My Events section
              if (title == 'My Events')
                GestureDetector(
                  onTap: _showBookmarkedEvents,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        Icons.bookmark,
                        color: const Color(0xFF071D99),
                        size: fontSize * 1.8,
                      ),
                      if (bookmarkedEvents.isNotEmpty)
                        Positioned(
                          top: -8,
                          right: -8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFFD7A61F),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              bookmarkedEvents.length.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSize * 0.8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        if (events.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              child: Text(
                'No ${title.toLowerCase()} yet',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: fontSize * 1.2,
                ),
              ),
            ),
          )
        else if (isHorizontalScroll)
          SizedBox(
            height: height * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              itemCount: events.length,
              itemBuilder: (context, index) => _buildEventCard(
                width,
                height,
                index,
                title,
                events[index],
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: events.take(3).length,
            itemBuilder: (context, index) => _buildListEventCard(
              width,
              height,
              events[index],
            ),
          ),
      ],
    );
  }

  Widget _buildListEventCard(double width, double height, Event event) {
    final fontSize = width * 0.03;
    final contentPadding = width * 0.04;
    final imageSize = width * 0.2;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: contentPadding,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailsPage(
                event: event,
                onBookmarkChanged: (bool isBookmarked) {
                  setState(() {
                    event.isBookmarked = isBookmarked;
                  });
                  _saveBookmarkedEvents();
                },
                onAttendingChanged: (bool isAttending) {
                  setState(() {
                    event.isAttending = isAttending;
                  });
                  _saveAttendedEvents();
                },
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(contentPadding * 0.5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  event.imageUrl,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: width * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize * 1.1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      event.date.toString().split(' ')[0],
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: fontSize,
                      ),
                    ),
                    Text(
                      event.location,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: fontSize,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    event.isAttending = !event.isAttending;
                  });
                  _saveAttendedEvents();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: event.isAttending 
                      ? const Color(0xFFD7A61F)
                      : const Color(0xFF071D99),
                  padding: EdgeInsets.symmetric(
                    horizontal: contentPadding * 0.8,
                    vertical: contentPadding * 0.4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  event.isAttending ? 'Attending' : 'Attend',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize * 0.9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(
              event: event,
              onBookmarkChanged: (bool isBookmarked) {
                setState(() {
                  event.isBookmarked = isBookmarked;
                });
                _saveBookmarkedEvents();
              },
              onAttendingChanged: (bool isAttending) {
                setState(() {
                  event.isAttending = isAttending;
                });
                _saveAttendedEvents();
              },
            ),
          ),
        );
      },
      child: Container(
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
                      event.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: const Color(0xFF071D99),
                      size: iconSize,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: iconSize * 1.5,
                      minHeight: iconSize * 1.5,
                    ),
                    onPressed: () {
                      setState(() {
                        event.isBookmarked = !event.isBookmarked;
                      });
                      _saveBookmarkedEvents();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveBookmarkedEvents() {
    //////save to firebase
  }

  void _saveAttendedEvents() {
    //////save to firebase
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
