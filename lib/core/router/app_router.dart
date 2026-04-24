import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:job_tracker/features/jobs/domain/job.dart';
import 'package:job_tracker/features/jobs/presentation/screens/add_job_screen.dart';
import 'package:job_tracker/features/jobs/presentation/screens/dashboard_screen.dart';
import 'package:job_tracker/features/jobs/presentation/screens/job_detail_screen.dart';
import 'package:job_tracker/features/jobs/presentation/screens/job_list_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
      GoRoute(path: '/', builder: (context, state) => JobListScreen(),),
      GoRoute(path: '/dashboard', builder: (context, state) => DashboardScreen(),),
    ]),
    GoRoute(
      path: '/job/:id',
      builder:(context, state) {
        final job = state.extra as Job;
        return JobDetailScreen(job: job);
      },
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => AddJobScreen(),
    ),
  ],
);

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: location == '/' ? 0 : 1,
        onDestinationSelected: (index) {
          if (index == 0) context.go('/');
          if (index == 1) context.go('/dashboard');
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.work_outline),
            selectedIcon: Icon(Icons.work),
            label: 'Applications',
          ),
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }
}