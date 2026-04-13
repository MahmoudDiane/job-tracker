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
      JobStatus.applied => const Color(0xFFEEF2FF),
      JobStatus.interviewing => const Color(0xFFFFF7ED),
      JobStatus.offer => const Color(0xFFECFDF5),
      JobStatus.rejected => const Color(0xFFFEF2F2),
      JobStatus.withdrawn => const Color(0xFFF9FAFB),
    };

Color get _textColor => switch (status) {
      JobStatus.applied => const Color(0xFF4338CA),
      JobStatus.interviewing => const Color(0xFFC2410C),
      JobStatus.offer => const Color(0xFF065F46),
      JobStatus.rejected => const Color(0xFFB91C1C),
      JobStatus.withdrawn => const Color(0xFF6B7280),
    };
}