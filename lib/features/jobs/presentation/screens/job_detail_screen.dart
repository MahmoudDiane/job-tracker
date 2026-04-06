import 'package:flutter/material.dart';
import 'package:job_tracker/features/jobs/domain/job.dart';

class JobDetailScreen extends StatelessWidget {
  final Job job;
  const JobDetailScreen({required this.job, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(job.companyName)),
      body: const Center(child: Text('Job Detail - Coming soon...')),
    );
  }
}
