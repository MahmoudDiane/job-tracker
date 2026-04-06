import 'job_status.dart';

class Job {
  final int? id;
  final String companyName;
  final String role;
  final JobStatus status;
  final DateTime appliedAt;
  final String? notes;
  final String? jobUrl;
  final String? salary;

  const Job({
    this.id,
    required this.companyName,
    required this.role,
    required this.status,
    required this.appliedAt,
    this.notes,
    this.jobUrl,
    this.salary,
  });

  Job copyWith({
    int? id,
    String? companyName,
    String? role,
    JobStatus? status,
    DateTime? appliedAt,
    String? notes,
    String? jobUrl,
    String? salary,
  }) {
    return Job(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      role: role ?? this.role,
      status: status ?? this.status,
      appliedAt: appliedAt ?? this.appliedAt,
      notes: notes ?? this.notes,
      jobUrl: jobUrl ?? this.jobUrl,
      salary: salary ?? this.salary,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'company_name': companyName,
      'role': role,
      'status': status.name,
      'applied_at': appliedAt.toIso8601String(),
      'notes': notes,
      'job_url': jobUrl,
      'salary': salary,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      id: map['id'] as int?,
      companyName: map['company_name'] as String,
      role: map['role'] as String,
      status: JobStatus.values.byName(map['status'] as String),
      appliedAt: DateTime.parse(map['applied_at'] as String),
      notes: map['notes'] as String?,
      jobUrl: map['job_url'] as String?,
      salary: map['salary'] as String?,
    );
  }
}
