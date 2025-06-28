import 'package:cloud_firestore/cloud_firestore.dart';

class MoodEntry {
  final String id;
  final String userId;
  final String mood;
  final String emoji;
  final String note;
  final DateTime timestamp;

  MoodEntry({
    required this.id,
    required this.userId,
    required this.mood,
    required this.emoji,
    required this.note,
    required this.timestamp,
  });

  factory MoodEntry.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MoodEntry(
      id: doc.id,
      userId: data['userId'] ?? '',
      mood: data['mood'] ?? '',
      emoji: data['emoji'] ?? '',
      note: data['note'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'mood': mood,
      'emoji': emoji,
      'note': note,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}