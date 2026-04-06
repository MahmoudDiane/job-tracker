import 'package:flutter/material.dart';
import 'package:job_tracker/features/jobs/domain/job_status.dart';

class StatusBadge extends StatelessWidget {
  final JobStatus status;
  const StatusBadge({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(status.label, style: TextStyle(color: _textColor, fontSize: 12, fontWeight: FontWeight.w500),),
    );
  }

  Color get _backgroundColor => switch (status) {
    JobStatus.applied => Colors.blue.shade50,
    JobStatus.interviewing => Colors.orange.shade50,
    JobStatus.offer => Colors.green.shade50,
    JobStatus.rejected => Colors.red.shade50,
    JobStatus.withdrawn => Colors.grey.shade50,
  };

  Color get _textColor => switch (status) {
    JobStatus.applied => Colors.blue.shade700,
    JobStatus.interviewing => Colors.orange.shade700,
    JobStatus.offer => Colors.green.shade700,
    JobStatus.rejected => Colors.red.shade700,
    JobStatus.withdrawn => Colors.grey.shade600,
  };
}