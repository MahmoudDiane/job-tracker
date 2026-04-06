enum JobStatus {
  applied,
  interviewing,
  offer,
  rejected,
  withdrawn;

  String get label => switch (this) {
    JobStatus.applied => 'Applied',
    JobStatus.interviewing => 'Interviewing',
    JobStatus.offer => 'Offer',
    JobStatus.rejected => 'Rejected',
    JobStatus.withdrawn => 'Withdrawn',
  };
}