  import 'package:flutter/material.dart';

class MoodSelector extends StatelessWidget {
  final Map<String, String> moods;
  final String selectedMood;
  final Function(String mood, String emoji) onMoodSelected;

  const MoodSelector({
    super.key,
    required this.moods,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: moods.length,
      itemBuilder: (context, index) {
        final mood = moods.keys.elementAt(index);
        final emoji = moods[mood]!;
        final isSelected = selectedMood == mood;

        return MoodTile(
          mood: mood,
          emoji: emoji,
          isSelected: isSelected,
          onTap: () => onMoodSelected(mood, emoji),
        );
      },
    );
  }
}

class MoodTile extends StatelessWidget {
  final String mood;
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;

  const MoodTile({
    super.key,
    required this.mood,
    required this.emoji,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 4),
            Text(
              mood,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}