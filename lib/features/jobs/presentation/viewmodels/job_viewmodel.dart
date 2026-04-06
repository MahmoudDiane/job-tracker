import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/features/jobs/data/job_repository.dart';
import 'package:job_tracker/features/jobs/domain/job.dart';
import 'package:job_tracker/features/jobs/domain/job_status.dart';

final jobRepositoryProvider = Provider<JobRepository>((ref) {
  return JobRepository();
});

class JobNotifier extends AsyncNotifier<List<Job>> {
  @override
  Future<List<Job>> build() async {
    return _fetchJobs();
  }

  Future<List<Job>> _fetchJobs() async {
    final repository = ref.read(jobRepositoryProvider);
    return repository.getAllJobs();
  }

  Future<void> addJob(Job job) async {
    final repository = ref.read(jobRepositoryProvider);
    await repository.insertJob(job);
    ref.invalidateSelf();
  }

  Future<void> updateJob(Job job) async {
    final repository = ref.read(jobRepositoryProvider);
    await repository.updateJob(job);
    ref.invalidateSelf();
  }

  Future<void> deleteJob(int id) async {
    final repository = ref.read(jobRepositoryProvider);
    await repository.deleteJob(id);
    ref.invalidateSelf();
  }

  Future<void> updateJobStatus(Job job, JobStatus newStatus) async {
    final updatedJob = job.copyWith(status: newStatus);
    await updateJob(updatedJob);
  }

  final jobsProvider = AsyncNotifierProvider<JobNotifier, List<Job>>(
    JobNotifier.new,
  );
}
