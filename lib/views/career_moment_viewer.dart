import 'dart:async';
import 'package:flutter/material.dart';

class CareerMomentViewer extends StatefulWidget {
  final int initialIndex;

  const CareerMomentViewer({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<CareerMomentViewer> createState() => _CareerMomentViewerState();
}

class _CareerMomentViewerState extends State<CareerMomentViewer> {
  final PageController _pageController = PageController();
  late int _currentIndex;
  Timer? _timer;

  // ⏱ Story duration
  static const Duration storyDuration = Duration(seconds: 5);
  double _progress = 0.0;

  // 🔥 Demo stories (replace with Firestore later)
  final List<Map<String, dynamic>> stories = [
    {
      'name': 'You',
      'text': 'Got placed at Google 🎉',
      'image': 'lib/images/profile.jpg',
    },
    {
      'name': 'John Smith',
      'text': 'Flutter workshop today 🚀',
      'image': 'lib/images/profile.jpg',
    },
    {
      'name': 'Sarah Johnson',
      'text': 'Promoted to Product Lead 💼',
      'image': 'lib/images/profile.jpg',
    },
    {
      'name': 'Alex',
      'text': 'Started new role at Amazon',
      'image': 'lib/images/profile.jpg',
    },
    {
      'name': 'Emily',
      'text': 'Tech conference vibes 🎤',
      'image': 'lib/images/profile.jpg',
    },
    {
      'name': 'Rahul',
      'text': 'Late night coding 😴💻',
      'image': 'lib/images/profile.jpg',
    },
    {
      'name': 'Neha',
      'text': 'Building my startup 🚀',
      'image': 'lib/images/profile.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController.jumpToPage(_currentIndex);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // ---------------- TIMER ----------------

  void _startTimer() {
    _timer?.cancel();
    _progress = 0;

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _progress += 0.01;
      });

      if (_progress >= 1) {
        _nextStory();
      }
    });
  }

  void _nextStory() {
    if (_currentIndex < stories.length - 1) {
      _currentIndex++;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startTimer();
    } else {
      Navigator.pop(context); // ✅ auto close
    }
  }

  void _prevStory() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startTimer();
    }
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // 📖 STORIES
            GestureDetector(
              onTapUp: (details) {
                final width = MediaQuery.of(context).size.width;
                if (details.globalPosition.dx < width / 2) {
                  _prevStory();
                } else {
                  _nextStory();
                }
              },
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  _currentIndex = index;
                  _startTimer();
                },
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  final story = stories[index];
                  return _storyPage(story);
                },
              ),
            ),

            // 📊 PROGRESS BAR
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Row(
                children: List.generate(
                  stories.length,
                      (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 3,
                      decoration: BoxDecoration(
                        color: index < _currentIndex
                            ? Colors.white
                            : index == _currentIndex
                            ? Colors.white.withOpacity(_progress)
                            : Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ❌ CLOSE BUTTON
            Positioned(
              top: 12,
              right: 12,
              child: IconButton(
                icon: const Icon(Icons.close,
                    color: Colors.white, size: 28),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- STORY PAGE ----------------

  Widget _storyPage(Map<String, dynamic> story) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          story['image'],
          fit: BoxFit.cover,
        ),

        // 🌑 OVERLAY
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black54,
                Colors.transparent,
                Colors.black87,
              ],
            ),
          ),
        ),

        // 🧾 TEXT
        Positioned(
          bottom: 80,
          left: 20,
          right: 20,
          child: Text(
            story['text'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // 👤 NAME
        Positioned(
          top: 40,
          left: 16,
          child: Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundImage:
                AssetImage('lib/images/profile.jpg'),
              ),
              const SizedBox(width: 10),
              Text(
                story['name'],
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
