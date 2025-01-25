import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/dialogs/parent_access_dialog.dart';

class ChildHomeHeader extends StatelessWidget {
  final int totalStars;
  final int maxStars;

  const ChildHomeHeader({
    super.key,
    required this.totalStars,
    required this.maxStars,
  });

  String _getFirstName(String fullName) {
    if (fullName.isEmpty) return 'Friend';
    return fullName.trim().split(' ')[0];
  }

  Stream<String> _getSelectedChildName() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      print('No user ID found');
      return Stream.value('Friend');
    }

    // Since there's only one child per user currently, let's get the first child
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('children')
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        print('No children found');
        return 'Friend';
      }

      final childDoc = snapshot.docs.first;
      final name = childDoc.data()['name'] as String? ?? 'Friend';
      print('Found child name: $name');
      return name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      decoration: BoxDecoration(
        color: AppTheme.childCream,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32),
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
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const ParentAccessDialog(),
                  );
                },
                icon: Icon(
                  Icons.lock_outlined,
                  color: AppTheme.childTurquoise.withOpacity(0.7),
                  size: 28,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello Little',
                      style: AppTheme.childBodyText.copyWith(
                        color: AppTheme.childTurquoise.withOpacity(0.7),
                      ),
                    ),
                    StreamBuilder<String>(
                      stream: _getSelectedChildName(),
                      builder: (context, snapshot) {
                        String displayName = 'Friend';

                        if (snapshot.hasData && snapshot.data != null) {
                          displayName = _getFirstName(snapshot.data!);
                        }

                        return Text(
                          displayName,
                          style: AppTheme.childHeadingLarge.copyWith(
                            color: AppTheme.childTurquoise,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        );
                      },
                    ),
                  ],
                ),
              ),
              _buildStarCounter(),
            ],
          ),
          const SizedBox(height: 24),
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildStarCounter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.childYellow.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.childYellow.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            color: AppTheme.childYellow,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            '$totalStars',
            style: AppTheme.childTitleLarge.copyWith(
              color: AppTheme.childYellow,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Journey',
          style: AppTheme.childBodyText.copyWith(
            color: AppTheme.childTurquoise.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 12,
          decoration: BoxDecoration(
            color: AppTheme.childTurquoise.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final progress = maxStars > 0 ? totalStars / maxStars : 0.0;
              return Stack(
                children: [
                  Container(
                    width: constraints.maxWidth * progress,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.childTurquoise,
                          AppTheme.childTurquoise.withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
