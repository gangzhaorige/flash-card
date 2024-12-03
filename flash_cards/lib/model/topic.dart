class TopicInfo {
  int id;
  String subject;
  String? description; // Nullable field
  int numCards;
  DateTime createdAt;
  DateTime updatedAt;

  TopicInfo({
    required this.id,
    required this.subject,
    this.description,
    required this.numCards,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to parse JSON into a TopicInfo object
  factory TopicInfo.fromJson(Map<String, dynamic> json) {
    return TopicInfo(
      id: json['id'] as int,
      subject: json['subject'] as String,
      description: json['description'], // Nullable, might be null
      numCards: json['num_cards'] as int,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Convert a TopicInfo object into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'description': description,
      'num_cards': numCards,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'id: $id, subject: $subject, description: $description, numCards: $numCards, createdAt: $createdAt, updatedAt: $updatedAt';
  }
}