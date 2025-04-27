class Event {
  final String title;
  final String category;
  final String location;
  final DateTime date;
  final String imageUrl;
  final String description;
  bool isBookmarked;
  bool isAttending;

  Event({
    required this.title,
    required this.category,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.description,
    this.isBookmarked = false,
    this.isAttending = false,
  });
}

