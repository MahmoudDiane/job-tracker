import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:job_tracker/features/jobs/domain/job.dart';
import 'package:job_tracker/features/jobs/domain/job_status.dart';
import 'package:job_tracker/features/jobs/presentation/viewmodels/job_viewmodel.dart';

class AddJobScreen extends ConsumerStatefulWidget {
  const AddJobScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends ConsumerState<AddJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _roleController = TextEditingController();
  final _notesController = TextEditingController();
  final _salaryController = TextEditingController();
  final _jobUrlController = TextEditingController();

  JobStatus _selectedStatus = JobStatus.applied;

  bool _isLoading = false;

  @override
  void dispose() {
    _companyController.dispose();
    _roleController.dispose();
    _notesController.dispose();
    _salaryController.dispose();
    _jobUrlController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final job = Job(
      companyName: _companyController.text.trim(),
      role: _roleController.text.trim(),
      status: _selectedStatus,
      appliedAt: DateTime.now(),
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      salary: _salaryController.text.trim().isEmpty
          ? null
          : _salaryController.text.trim(),
      jobUrl: _jobUrlController.text.trim().isEmpty
          ? null
          : _jobUrlController.text.trim(),
    );

    await ref.read(jobsProvider.notifier).addJob(job);

    setState(() => _isLoading = false);

    if (mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Application')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _companyController,
                decoration: const InputDecoration(
                  labelText: 'Company name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a company name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _roleController,
                decoration: const InputDecoration(
                  labelText: 'Role *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a role';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<JobStatus>(
                initialValue: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: JobStatus.values.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status.label),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedStatus = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _salaryController,
                decoration: const InputDecoration(
                  labelText: 'Salary (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _jobUrlController,
                decoration: const InputDecoration(
                  labelText: 'Job posting URL (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save Application'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
