import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics_wrapper/levels/animal_puzzle_game/animal_puzzle_wrapper.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/shared/game_theme.dart';

class EverydayBasicsWrapper extends StatefulWidget {
  final VoidCallback onBack;

  const EverydayBasicsWrapper({
    super.key,
    required this.onBack,
  });

  @override
  State<EverydayBasicsWrapper> createState() => _EverydayBasicsWrapperState();
}

class _EverydayBasicsWrapperState extends State<EverydayBasicsWrapper> {
  final List<Map<String, dynamic>> games = [
    {
      'id': 'animals_nature',
      'title': 'Animals in Nature',
      'description': 'Match animals with their shadows',
      'icon': Icons.pets,
      'color': AppTheme.childTurquoise,
      'difficulty': 'Easy',
      'isLocked': false,
      'totalStars': 3,
      'earnedStars': 0,
      'requiredStars': 0,
    },
    {
      'id': 'happy_helpers',
      'title': 'Happy Helpers',
      'description': 'Learn about helping at home',
      'icon': Icons.home,
      'color': AppTheme.childPurple,
      'difficulty': 'Easy',
      'isLocked': false,
      'totalStars': 3,
      'earnedStars': 0,
      'requiredStars': 3,
    },
    {
      'id': 'weather_fun',
      'title': 'Weather Fun',
      'description': 'Explore different weather types',
      'icon': Icons.wb_sunny,
      'color': AppTheme.childPink,
      'difficulty': 'Medium',
      'isLocked': true,
      'totalStars': 3,
      'earnedStars': 0,
      'requiredStars': 6,
    },
    {
      'id': 'my_emotions',
      'title': 'My Emotions',
      'description': 'Express how you feel',
      'icon': Icons.emoji_emotions,
      'color': AppTheme.childOrange,
      'difficulty': 'Medium',
      'isLocked': true,
      'totalStars': 3,
      'earnedStars': 0,
      'requiredStars': 9,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildProgressBar(),
            Expanded(
              child: _buildGameGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.childCream,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.childTurquoise.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: AppTheme.childTurquoise,
                iconSize: 32,
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Everyday Basics',
                  style: AppTheme.childHeadingLarge.copyWith(
                    color: AppTheme.childTurquoise,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.childYellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppTheme.childYellow,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '0/12',
                      style: AppTheme.childTitleLarge.copyWith(
                        color: AppTheme.childYellow,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Complete games to unlock new adventures!',
              style: AppTheme.childTitleLarge.copyWith(
                color: AppTheme.childTurquoise.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 12,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: 0.25, // Progress percentage
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.childTurquoise,
                    AppTheme.childTurquoise.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameGrid() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _buildGameCard(game),
        );
      },
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: game['color'].withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: game['isLocked']
              ? () => _showLockedGameDialog(game)
              : () => _navigateToGame(game),
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    _buildGameIcon(game),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            game['title'],
                            style: AppTheme.childTitleLarge.copyWith(
                              color: game['color'],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            game['description'],
                            style: AppTheme.childBodyText.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const Spacer(),
                          _buildDifficultyBadge(game),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (game['isLocked']) _buildLockedOverlay(game),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameIcon(Map<String, dynamic> game) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: game['color'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        game['icon'],
        size: 32,
        color: game['color'],
      ),
    );
  }

  Widget _buildDifficultyBadge(Map<String, dynamic> game) {
    final isEasy = game['difficulty'] == 'Easy';
    final color = isEasy ? AppTheme.childSoftGreen : AppTheme.childOrange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        game['difficulty'],
        style: AppTheme.childBodyText.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLockedOverlay(Map<String, dynamic> game) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lock_rounded,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              '${game['requiredStars']} stars needed',
              style: AppTheme.childBodyText.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToGame(Map<String, dynamic> game) {
    Widget gameScreen;

    switch (game['id']) {
      case 'animals_nature':
        gameScreen = const AnimalPuzzleWrapper();
        break;
      // Add cases for other games as they are implemented
      default:
        gameScreen = const Placeholder();
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => gameScreen),
    );
  }

  void _showLockedGameDialog(Map<String, dynamic> game) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_rounded,
              size: 48,
              color: game['color'],
            ),
            const SizedBox(height: 16),
            Text(
              'Game Locked',
              style: AppTheme.childHeadingMedium.copyWith(
                color: game['color'],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Complete previous games to earn ${game['requiredStars']} stars and unlock this game!',
              textAlign: TextAlign.center,
              style: AppTheme.childBodyText,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: game['color'],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: Text(
                'OK',
                style: AppTheme.childBodyText.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
