import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/mood_entry.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addMoodEntry(MoodEntry entry) async {
    await _db.collection('mood_entries').add(entry.toFirestore());
  }

  Stream<List<MoodEntry>> getMoodEntries(String userId) {
    return _db
        .collection('mood_entries')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          final entries = snapshot.docs
              .map((doc) => MoodEntry.fromFirestore(doc))
              .toList();

          // Sort di client side
          entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));
          return entries;
        });
  }

  Future<void> deleteMoodEntry(String entryId) async {
    await _db.collection('mood_entries').doc(entryId).delete();
  }
}
