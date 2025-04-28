/// Organization Event Management Page
/// 
/// Purpose: Allows organization administrators to create, manage, and track events,
/// as well as monitor attendance and engagement metrics.
/// 
/// Flow:
/// 1. Organization admin can view all their events
/// 2. Admin can create new events with detailed information
/// 3. Admin can edit existing events
/// 4. Admin can view attendance metrics for each event
/// 5. Admin can manage event visibility and status
/// 
/// UI Components:
/// - Search bar for finding specific events
/// - Category filters with visual indicators
/// - "Upcoming Events" section showing events not yet occurred
/// - "Past Events" section showing completed events
/// - "Draft Events" section showing unpublished events
/// - Event creation and editing functionality
/// 
/// Backend Implementation Needed:
/// - Real-time event data syncing with database
/// - Attendance tracking and metrics storage
/// - Image upload for event banners
/// - Event sharing and promotion options
library;

import 'package:flutter/material.dart';
import 'profile.dart';

/// OrgEvent model containing all event details specific to organization events
class OrgEvent {
  final String id;
  String title;
  String category;
  String location;
  DateTime date;
  DateTime endDate;
  String imageUrl;
  String description;
  int maxAttendees;
  int currentAttendees;
  bool isPublished;
  bool requiresApproval;
  bool isEditable;


  OrgEvent({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.description,
    DateTime? endDate,
    this.maxAttendees = 100,
    this.currentAttendees = 0,
    this.isPublished = true,
    this.requiresApproval = false,
    this.isEditable = true,
  }) : endDate = endDate ?? DateTime.now();
}

class OrgEventManagementPage extends StatefulWidget {
  const OrgEventManagementPage({super.key});

  @override
  State<OrgEventManagementPage> createState() => _OrgEventManagementPageState();
}

class _OrgEventManagementPageState extends State<OrgEventManagementPage> with SingleTickerProviderStateMixin {
  // Controller for the search text field
  final TextEditingController _searchController = TextEditingController();
  
  // Currently selected category filter
  String _selectedCategory = 'All';
  
  // Tab controller for event status tabs
  late TabController _tabController;
  
  // Text controllers for event form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _maxAttendeesController = TextEditingController();
  
  // Selected date range for event
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now().add(const Duration(hours: 2));
  
  // Flag to track if we're in edit mode
  bool _isEditMode = false;

  // List of predefined categories for filtering events
  final List<Category> _categories = [
    Category(name: 'All', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'Academic', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'Social', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'Sports', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'Career', imageUrl: 'https://picsum.photos/100'),
    Category(name: 'Cultural', imageUrl: 'https://picsum.photos/100'),
  ];

  // Sample events data
  // BACKEND: Should be fetched from database based on organization ID
  final List<OrgEvent> _orgEvents = [
    OrgEvent(
      id: '1',
      title: 'Annual General Meeting',
      category: 'Academic',
      date: DateTime.now().add(const Duration(days: 7)),
      endDate: DateTime.now().add(const Duration(days: 7, hours: 3)),
      location: 'Main Auditorium',
      imageUrl: 'https://picsum.photos/160/100?random=10',
      description: 'Annual meeting discussing organization goals and achievements.',
      maxAttendees: 150,
      currentAttendees: 78,
    ),
    OrgEvent(
      id: '2',
      title: 'Leadership Workshop',
      category: 'Career',
      date: DateTime.now().add(const Duration(days: 14)),
      endDate: DateTime.now().add(const Duration(days: 14, hours: 4)),
      location: 'Room 301',
      imageUrl: 'https://picsum.photos/160/100?random=11',
      description: 'Workshop focused on developing leadership skills for college students.',
      maxAttendees: 50,
      currentAttendees: 32,
    ),
    OrgEvent(
      id: '3',
      title: 'Welcome Party',
      category: 'Social',
      date: DateTime.now().subtract(const Duration(days: 10)),
      endDate: DateTime.now().subtract(const Duration(days: 10)).add(const Duration(hours: 5)),
      location: 'Campus Garden',
      imageUrl: 'https://picsum.photos/160/100?random=12',
      description: 'Welcome celebration for new members joining the organization.',
      maxAttendees: 200,
      currentAttendees: 175,
    ),
    OrgEvent(
      id: '4',
      title: 'Tech Bootcamp',
      category: 'Academic',
      date: DateTime.now().add(const Duration(days: 3)),
      endDate: DateTime.now().add(const Duration(days: 5)),
      location: 'Computer Lab 2',
      imageUrl: 'https://picsum.photos/160/100?random=13',
      description: 'Three-day intensive bootcamp on modern web development technologies.',
      maxAttendees: 40,
      currentAttendees: 10,
    ),
    OrgEvent(
      id: '5',
      title: 'Fundraising Concert',
      category: 'Cultural',
      date: DateTime.now().add(const Duration(days: 21)),
      endDate: DateTime.now().add(const Duration(days: 21, hours: 6)),
      location: 'Open Field',
      imageUrl: 'https://picsum.photos/160/100?random=14',
      description: 'Concert to raise funds for organizational activities and community outreach.',
      maxAttendees: 300,
      currentAttendees: 0,
      isPublished: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    setState(() {
      // Reset search and filter when tab changes
      _searchController.clear();
      _selectedCategory = 'All';
    });
  }

  // Filter events based on their status (upcoming, past, draft)
  List<OrgEvent> _filterEventsByStatus(int tabIndex) {
    final now = DateTime.now();
    
    switch(tabIndex) {
      case 0: // Upcoming Events
        return _orgEvents.where((event) => 
          event.date.isAfter(now) && 
          event.isPublished).toList();
      case 1: // Past Events
        return _orgEvents.where((event) => 
          event.date.isBefore(now) && 
          event.isPublished).toList();
      case 2: // Draft Events
        return _orgEvents.where((event) => 
          !event.isPublished).toList();
      default:
        return [];
    }
  }

  // Filters events based on the selected category
  List<OrgEvent> _getFilteredEvents(int tabIndex) {
    final statusFiltered = _filterEventsByStatus(tabIndex);
    
    if (_selectedCategory == 'All') {
      return statusFiltered;
    }
    
    return statusFiltered
        .where((event) => event.category == _selectedCategory)
        .toList();
  }

  // Searches events based on the query text
  List<OrgEvent> _getSearchResults(String query, int tabIndex) {
    if (query.isEmpty) {
      return _getFilteredEvents(tabIndex);
    }
    
    final lowercaseQuery = query.toLowerCase();
    return _getFilteredEvents(tabIndex).where((event) {
      return event.title.toLowerCase().contains(lowercaseQuery) ||
             event.category.toLowerCase().contains(lowercaseQuery) ||
             event.location.toLowerCase().contains(lowercaseQuery) ||
             event.description.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  // Shows the event creation/editing form
  void _showEventForm({OrgEvent? event}) {
    _isEditMode = event != null;
    //_currentlyEditingEventId = event?.id;
    
    // Initialize form with event data if editing
    if (_isEditMode) {
      _titleController.text = event!.title;
      _locationController.text = event.location;
      _descriptionController.text = event.description;
      _maxAttendeesController.text = event.maxAttendees.toString();
      _selectedStartDate = event.date;
      _selectedEndDate = event.endDate;
    } else {
      _titleController.clear();
      _locationController.clear();
      _descriptionController.clear();
      _maxAttendeesController.text = "100";
      _selectedStartDate = DateTime.now();
      _selectedEndDate = DateTime.now().add(const Duration(hours: 2));
    }

    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final fontSize = width * 0.03;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            height: screenSize.height * 0.85,
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
                        _isEditMode ? 'Edit Event' : 'Create New Event',
                        style: TextStyle(
                          fontSize: fontSize * 1.4,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF071D99),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Event Details',
                          style: TextStyle(
                            fontSize: fontSize * 1.2,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF071D99),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Event Title
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Event Title',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Event Category
                        DropdownButtonFormField<String>(
                          value: _isEditMode ? event!.category : _categories[1].name,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                          ),
                          items: _categories
                              .where((category) => category.name != 'All')
                              .map((category) {
                                return DropdownMenuItem(
                                  value: category.name,
                                  child: Text(category.name),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setModalState(() {
                              if (_isEditMode && event != null) {
                                event.category = newValue!;
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Event Location
                        TextField(
                          controller: _locationController,
                          decoration: const InputDecoration(
                            labelText: 'Location',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Start Date & Time
                        Row(
                          children: [
                            Expanded(
                              child: Text('Start Date & Time',
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedStartDate,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                );
                                if (picked != null) {
                                  final TimeOfDay? timePicked = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(_selectedStartDate),
                                  );
                                  if (timePicked != null) {
                                    setModalState(() {
                                      _selectedStartDate = DateTime(
                                        picked.year,
                                        picked.month,
                                        picked.day,
                                        timePicked.hour,
                                        timePicked.minute,
                                      );
                                      // Ensure end date is not before start date
                                      if (_selectedEndDate.isBefore(_selectedStartDate)) {
                                        _selectedEndDate = _selectedStartDate.add(const Duration(hours: 2));
                                      }
                                    });
                                  }
                                }
                              },
                              child: Text(
                                '${_selectedStartDate.month}/${_selectedStartDate.day}/${_selectedStartDate.year} - ${_formatTime(_selectedStartDate)}',
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: const Color(0xFF071D99),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // End Date & Time
                        Row(
                          children: [
                            Expanded(
                              child: Text('End Date & Time',
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedEndDate,
                                  firstDate: _selectedStartDate,
                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                );
                                if (picked != null) {
                                  final TimeOfDay? timePicked = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(_selectedEndDate),
                                  );
                                  if (timePicked != null) {
                                    setModalState(() {
                                      _selectedEndDate = DateTime(
                                        picked.year,
                                        picked.month,
                                        picked.day,
                                        timePicked.hour,
                                        timePicked.minute,
                                      );
                                    });
                                  }
                                }
                              },
                              child: Text(
                                '${_selectedEndDate.month}/${_selectedEndDate.day}/${_selectedEndDate.year} - ${_formatTime(_selectedEndDate)}',
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: const Color(0xFF071D99),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Max Attendees
                        TextField(
                          controller: _maxAttendeesController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Maximum Attendees',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Event Description
                        TextField(
                          controller: _descriptionController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Image Upload
                        Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: _isEditMode 
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  event!.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Text('Error loading image'),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate,
                                      size: 40,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Upload Event Banner',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: fontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Event Options
                        Text(
                          'Event Options',
                          style: TextStyle(
                            fontSize: fontSize * 1.2,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF071D99),
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // Requires Approval Option
                        SwitchListTile(
                          title: const Text('Require approval for attendees'),
                          value: _isEditMode ? event!.requiresApproval : false,
                          onChanged: (bool value) {
                            setModalState(() {
                              if (_isEditMode && event != null) {
                                event.requiresApproval = value;
                              }
                            });
                          },
                        ),
                        
                        // Published Option
                        SwitchListTile(
                          title: const Text('Publish event immediately'),
                          value: _isEditMode ? event!.isPublished : true,
                          onChanged: (bool value) {
                            setModalState(() {
                              if (_isEditMode && event != null) {
                                event.isPublished = value;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Cancel Button
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: fontSize * 1.1,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      
                      // Save Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF071D99),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 12.0,
                          ),
                        ),
                        onPressed: () {
                          _saveEvent(event);
                          Navigator.pop(context);
                        },
                        child: Text(
                          _isEditMode ? 'Update Event' : 'Create Event',
                          style: TextStyle(
                            fontSize: fontSize * 1.1,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Save event to database
  void _saveEvent(OrgEvent? existingEvent) {
    // Validate form
    if (_titleController.text.isEmpty || 
        _locationController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      return;
    }

    setState(() {
      if (_isEditMode && existingEvent != null) {
        // Update existing event
        existingEvent.title = _titleController.text;
        existingEvent.location = _locationController.text;
        existingEvent.description = _descriptionController.text;
        existingEvent.date = _selectedStartDate;
        existingEvent.endDate = _selectedEndDate;
        existingEvent.maxAttendees = int.tryParse(_maxAttendeesController.text) ?? 100;
      } else {
        // Create new event
        final newEvent = OrgEvent(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _titleController.text,
          category: _categories.where((c) => c.name != 'All').first.name,
          location: _locationController.text,
          description: _descriptionController.text,
          date: _selectedStartDate,
          endDate: _selectedEndDate,
          maxAttendees: int.tryParse(_maxAttendeesController.text) ?? 100,
          imageUrl: 'https://picsum.photos/160/100?random=${DateTime.now().millisecondsSinceEpoch}',
        );
        _orgEvents.add(newEvent);
      }
    });
  }

  // Helper to format time
  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${dateTime.minute.toString().padLeft(2, '0')} $period';
  }

  // Shows event details and management options
  void _showEventDetails(OrgEvent event) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final fontSize = width * 0.03;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: screenSize.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Header with event image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(
                    event.imageUrl,
                    height: screenSize.height * 0.25,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Row(
                    children: [
                      // Edit button
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Color(0xFF071D99)),
                          onPressed: () {
                            Navigator.pop(context);
                            _showEventForm(event: event);
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Close button
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
                // Dark gradient overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 80,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                // Event title on image
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Text(
                    event.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize * 1.5,
                    ),
                  ),
                ),
              ],
            ),
            
            // Event details
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event metadata
                    Row(
                      children: [
                        _buildInfoChip(Icons.calendar_today, _formatDate(event.date)),
                        const SizedBox(width: 8),
                        _buildInfoChip(Icons.access_time, _formatTime(event.date)),
                        const SizedBox(width: 8),
                        _buildInfoChip(Icons.location_on, event.location),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Attendance stats
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Attendance Stats',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize * 1.2,
                              color: const Color(0xFF071D99),
                            ),
                          ),
                          const SizedBox(height: 12),
                          LinearProgressIndicator(
                            value: event.maxAttendees > 0 
                                ? event.currentAttendees / event.maxAttendees 
                                : 0,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF071D99)),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Current: ${event.currentAttendees}',
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                'Max: ${event.maxAttendees}',
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Event description
                    Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize * 1.2,
                        color: const Color(0xFF071D99),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      event.description,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.grey[800],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Manage attendees button
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF071D99),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        minimumSize: const Size(double.infinity, 0),
                      ),
                      onPressed: () {
                        _showAttendeesManagement(event);
                      },
                      icon: const Icon(Icons.people, color: Colors.white),
                      label: Text(
                        'Manage Attendees',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize * 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Event status controls
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: event.isPublished 
                                  ? Colors.red[700] 
                                  : const Color(0xFFD7A61F),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () {
                              setState(() {
                                event.isPublished = !event.isPublished;
                              });
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              event.isPublished ? Icons.unpublished : Icons.publish,
                              color: Colors.white,
                            ),
                            label: Text(
                              event.isPublished ? 'Unpublish' : 'Publish',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[700],
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () {
                              _showDeleteConfirmation(event);
                            },
                            icon: const Icon(Icons.delete, color: Colors.white),
                            label: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show the attendees management interface
  void _showAttendeesManagement(OrgEvent event) {
    // This would show a list of attendees with options to approve/remove
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final fontSize = width * 0.03;
    
    // Mock data for attendees
    final List<Map<String, dynamic>> attendees = List.generate(
      event.currentAttendees,
      (index) => {
        'name': 'Student ${index + 1}',
        'email': 'student${index + 1}@example.com', //////////////////////////for email
        'approved': index < event.currentAttendees * 0.8,
        'avatar': 'https://picsum.photos/50?random=${index + 20}',
      },
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: screenSize.height * 0.7,
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
                        'Manage Attendees',
                        style: TextStyle(
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
                attendees.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            'No attendees yet',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: fontSize * 1.2,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: attendees.length,
                          itemBuilder: (context, index) {
                            final attendee = attendees[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(attendee['avatar']),
                              ),
                              title: Text(attendee['name']),
                              subtitle: Text(attendee['email']),
                              trailing: attendee['approved']
                                  ? TextButton.icon(
                                      icon: const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                      label: const Text(
                                        'Approved',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      onPressed: null,
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF071D99),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          attendee['approved'] = true;
                                        });
                                      },
                                      child: const Text(
                                        'Approve',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD7A61F),
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.email, color: Colors.white),
                    label: Text(
                      'Email All Attendees',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize * 1.1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Confirmation dialog for deleting an event
  void _showDeleteConfirmation(OrgEvent event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Event'),
          content: Text('Are you sure you want to delete "${event.title}"? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _orgEvents.removeWhere((e) => e.id == event.id);
                });
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close event details
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // Helper to format date
  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  // Helper to create info chips
  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF071D99).withOpacity(0.2)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF071D99)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF071D99),
              fontWeight: FontWeight.w500,
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
    final height = screenSize.height;

    final fontSize = width * 0.03;
    final contentPadding = width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header section with search and profile
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: contentPadding,
                vertical: height * 0.03,
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
                        child: Image.asset(
                          'images/xavloglogo.png',
                          height: height * 0.08,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Computer Science Society',
                                style: TextStyle(
                                  fontFamily: 'Jost',
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize * 1.2,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'College of Computer Studies',
                                style: TextStyle(
                                  fontFamily: 'Jost',
                                  color: Colors.white70,
                                  fontSize: fontSize,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: width * 0.03),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(isOrganization: true),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'orgProfilePicture',
                              child: CircleAvatar(
                                radius: width * 0.06,
                                backgroundImage: const NetworkImage('https://picsum.photos/100?random=org'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.02),
                  TextField(
                    controller: _searchController,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: fontSize,
                    ),
                    onChanged: (value) {
                      setState(() {
                        // Trigger rebuild when search text changes
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search events by name or location',
                      prefixIcon: Icon(Icons.search, size: fontSize * 1.4),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, size: fontSize * 1.4),
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
                        vertical: height * 0.018,
                        horizontal: width * 0.05,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Categories
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              child: SizedBox(
                height: height * 0.1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: contentPadding),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: width * 0.04),
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
                                  width: 2.5,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: width * 0.06,
                                backgroundImage: NetworkImage(_categories[index].imageUrl),
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              _categories[index].name,
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontSize: fontSize,
                                fontWeight: _selectedCategory == _categories[index].name
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: _selectedCategory == _categories[index].name
                                    ? const Color(0xFF071D99)
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Tab bar for event status
            TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF071D99),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFF071D99),
              tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'Past'),
                Tab(text: 'Drafts'),
              ],
            ),
            
            // Tab views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Upcoming events tab
                  _buildEventsList(0),
                  
                  // Past events tab
                  _buildEventsList(1),
                  
                  // Draft events tab
                  _buildEventsList(2),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // FAB to create new event
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showEventForm(),
        backgroundColor: const Color(0xFF071D99),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Create Event', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  // Builds the event list for a specific tab
  Widget _buildEventsList(int tabIndex) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;
    final contentPadding = width * 0.05;
    
    final events = _getSearchResults(_searchController.text, tabIndex);
    
    if (events.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              tabIndex == 0 ? Icons.event_available : 
              tabIndex == 1 ? Icons.event_busy : Icons.drafts,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              tabIndex == 0 
                  ? 'No upcoming events' 
                  : tabIndex == 1 
                      ? 'No past events' 
                      : 'No draft events',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: width * 0.04,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the + button to create an event',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: width * 0.035,
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: contentPadding,
      ),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return _buildOrgEventCard(event, width, height);
      },
    );
  }

  // Build event card for organization management
  Widget _buildOrgEventCard(OrgEvent event, double width, double height) {
    final fontSize = width * 0.03;
    
    return Card(
      margin: EdgeInsets.only(bottom: height * 0.02),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _showEventDetails(event),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event image with overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    event.imageUrl,
                    height: height * 0.15,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Status indicator
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: event.isPublished
                          ? const Color(0xFF071D99)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      event.isPublished ? 'Published' : 'Draft',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize * 0.9,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Event details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and category
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize * 1.2,
                            color: const Color(0xFF071D99),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD7A61F).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          event.category,
                          style: TextStyle(
                            color: const Color(0xFFD7A61F),
                            fontSize: fontSize * 0.9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Date, time and location
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: fontSize * 1.2,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(event.date),
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: fontSize,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        size: fontSize * 1.2,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatTime(event.date),
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: fontSize * 1.2,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: fontSize,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Attendance stats
                  Row(
                    children: [
                      Text(
                        'Attendance: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: fontSize,
                        ),
                      ),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: event.maxAttendees > 0 
                              ? event.currentAttendees / event.maxAttendees 
                              : 0,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF071D99),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${event.currentAttendees}/${event.maxAttendees}',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF071D99),
                            side: const BorderSide(color: Color(0xFF071D99)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () => _showEventForm(event: event),
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF071D99),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () => _showEventDetails(event),
                          icon: const Icon(Icons.visibility, color: Colors.white),
                          label: const Text(
                            'Details',
                            style: TextStyle(color: Colors.white),
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
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _maxAttendeesController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}

/// Helper class for categories
class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});
}