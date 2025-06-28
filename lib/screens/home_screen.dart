import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/auth_provider.dart';
import '../services/database_service.dart';
import '../models/mood_entry.dart';
import '../widgets/mood_selector.dart';
import '../widgets/custom_button.dart';
import 'auth_screen.dart';
import 'mood_history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController _noteController = TextEditingController();
  
  String _selectedMood = '';
  String _selectedEmoji = '';
  
  final Map<String, String> _moods = {
    'Happy': '😊',
    'Sad': '😔',
    'Angry': '😡',
    'Excited': '🤩',
    'Calm': '😌',
    'Anxious': '😰',
    'Grateful': '🙏',
    'Tired': '😴',
  };

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _saveMoodEntry() async {
    if (_selectedMood.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a mood')),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    if (user == null) return;

    final entry = MoodEntry(
      id: '',
      userId: user.uid,
      mood: _selectedMood,
      emoji: _selectedEmoji,
      note: _noteController.text.trim(),
      timestamp: DateTime.now(),
    );

    try {
      await _databaseService.addMoodEntry(entry);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mood saved successfully!')),
        );
        
        setState(() {
          _selectedMood = '';
          _selectedEmoji = '';
          _noteController.clear();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving mood: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Journal'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MoodHistoryScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.signOut();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Hello, ${user?.email?.split('@')[0] ?? 'User'}!',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'How are you feeling today?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Your Mood:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            MoodSelector(
              moods: _moods,
              selectedMood: _selectedMood,
              onMoodSelected: (mood, emoji) {
                setState(() {
                  _selectedMood = mood;
                  _selectedEmoji = emoji;
                });
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Add a Note (Optional):',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'What made you feel this way?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Save Mood Entry',
              icon: Icons.save,
              onPressed: _saveMoodEntry,
            ),
          ],
        ),
      ),
    );
  }
}