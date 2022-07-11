enum JobPostStatus {
  deleted,
  pending,
  posted,
  rejected,
  expired, // Hết hạn đăng bài
  outOfDate, // Quá hạn duyệt
  cancel,
  approved,
}

enum JobPostWorkStatus {
  pending,
  started,
  done,
}

enum PaymentHistoryStatus {
  rejected,
  pending,
  paid,
}

enum TreeTypeStatus {
  inActive,
  active,
}

enum GardenStatus {
  inActive,
  active,
}

enum AppliedJobStatus{
  pending,
  approve,
  reject,
  end
}
