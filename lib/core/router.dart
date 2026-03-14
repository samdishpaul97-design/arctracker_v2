import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../features/dashboard/dashboard_screen.dart';
import '../features/habits/habits_screen.dart';
import '../features/habits/arc_detail_screen.dart';
import '../features/planning/daily_plan_screen.dart';
import '../features/reviews/weekly_review_screen.dart';
import '../features/quests/quest_list_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithBottomNav(child: child);
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/habits',
            builder: (context, state) => const HabitsScreen(),
            routes: [
              GoRoute(
                path: 'arc-detail',
                builder: (context, state) => const ArcDetailScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/plan',
            builder: (context, state) => const DailyPlanScreen(),
          ),
          GoRoute(
            path: '/review',
            builder: (context, state) => const WeeklyReviewScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/quests',
        builder: (context, state) => const QuestListScreen(),
      ),
    ],
  );
}

class ScaffoldWithBottomNav extends StatefulWidget {
  final Widget child;

  const ScaffoldWithBottomNav({super.key, required this.child});

  @override
  State<ScaffoldWithBottomNav> createState() => _ScaffoldWithBottomNavState();
}

class _ScaffoldWithBottomNavState extends State<ScaffoldWithBottomNav> {
  int _selectedIndex = 0;

  static const List<String> _routes = ['/dashboard', '/habits', '/plan', '/review'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Habits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review),
            label: 'Review',
          ),
        ],
      ),
    );
  }
}