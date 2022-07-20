import 'package:json_annotation/json_annotation.dart';

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

enum AppliedFarmerStatus {
  @JsonValue('Pending')
  pending,
  @JsonValue('Approve')
  approved,
  @JsonValue('Reject')
  rejected,
  @JsonValue('End')
  end,
}

enum AttendanceStatus {
  @JsonValue('UnexcusedAbsent')
  absent,
  @JsonValue('Present')
  present,
  @JsonValue('Future')
  noAttendance,
  @JsonValue('End')
  end,
  @JsonValue('DayOff')
  dayOff,
  @JsonValue('Dismissed')
  fired,
}
