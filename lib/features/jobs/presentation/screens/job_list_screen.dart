import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:job_tracker/features/jobs/presentation/viewmodels/job_viewmodel.dart';
import 'package:job_tracker/features/jobs/presentation/widgets/job_card.dart';

class JobListScreen extends ConsumerWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(jobsProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Job Tracker')),
      body: jobAsync.when(
        data: (jobs) {
          if (jobs.isEmpty) {
            return const Center(
              child: Text('No applications yet.\nTap + to add one.'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final job = jobs[index];
              return JobCard(
                job: job,
                onTap: () => context.go('/job/${job.id}', extra: job),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemCount: jobs.length,
          );
        },
        error: (e, st) => Center(child: Text('Error: $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
