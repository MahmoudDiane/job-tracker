import 'package:go_router/go_router.dart';
import 'package:job_tracker/features/jobs/domain/job.dart';
import 'package:job_tracker/features/jobs/presentation/screens/add_job_screen.dart';
import 'package:job_tracker/features/jobs/presentation/screens/job_detail_screen.dart';
import 'package:job_tracker/features/jobs/presentation/screens/job_list_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/', 
      builder: (context, state) => JobListScreen(),
    ),
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
