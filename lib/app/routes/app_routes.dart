part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const init = _Paths.init;
  static const login = _Paths.login;
  static const chooseRole = _Paths.chooseRole;
  static const forgotPassword = _Paths.forgotPassword;
  static const signup = _Paths.signup;
  static const enterOtp = _Paths.enterOtp;
  static const resetPassword = _Paths.resetPassword;
  static const enterPassword = _Paths.enterPassword;

  static const p2pMessages = _Paths.p2pMessages;
  static const guidepost = _Paths.guidepost;
  static const updateProfile = _Paths.updateProfile;
  static const changePassword = _Paths.changePassword;

  //landowner
  static const landownerDashboard = _Paths.landownerDashboard;
  static const landownerProfile = _Paths.landownerProfile;
  static const gardenHome = _Paths.gardenHome;
  static const gardenForm = _Paths.gardenForm;
  static const gardenDetails = _Paths.gardenDetails;
  static const jobPostForm = _Paths.jobPostForm;
  static const landownerJobPostDetails = _Paths.landownerJobPostDetails;
  static const paymentHistoryHome = _Paths.paymentHistoryHome;
  static const paymentHistoryDetails = _Paths.paymentHistoryDetails;
  static const appliedFarmerDetails = _Paths.appliedFarmerDetails;
  static const checkAttendance = _Paths.checkAttendance;
  static const landownerBookmark = _Paths.landownerBookmark;
  static const landownerBookmarkDetails = _Paths.landownerBookmarkDetails;
  static const jobFarmerList = _Paths.jobFarmerList;
  static const jobFarmerDetails = _Paths.jobFarmerDetails;
  static const landownerReportList = _Paths.landownerReportList;
  static const landownerReportDetails = _Paths.landownerReportDetails;
  static const landownerJobPostByType = _Paths.landownerJobPostByType;
  static const landownerJobPostByGarden = _Paths.landownerJobPostByGarden;

  //farmer
  static const farmerDashboard = _Paths.farmerDashboard;
  static const farmerProfile = _Paths.farmerProfile;
  static const farmerJobPostDetail = _Paths.farmerJobPostDetail;
  static const farmerBookmarkAccount = _Paths.farmerBookmarkAccount;
  static const farmerInprogressJobDetail = _Paths.farmerInprogressJobDetail;
  static const farmerCheckAttendance = _Paths.farmerCheckAttendance;
  static const farmerAttendanceWorkDay = _Paths.farmerAttendanceWorkDay;
  static const farmerHistoryJob = _Paths.farmerHistoryJob;
  static const farmerHistoryJobDetail = _Paths.farmerHistoryJobDetail;
  static const test = _Paths.test;
}

abstract class _Paths {
  static const _landowner = '/landowner';
  static const _farmer = '/farmer';

  static const init = '/init';
  static const login = '/login';
  static const chooseRole = '/choose_role';
  static const forgotPassword = '/forgot_password';
  static const signup = '/signup';
  static const enterOtp = '/enter_otp';
  static const resetPassword = '/reset_password';
  static const enterPassword = '/enter_password';

  static const p2pMessages = '/p2pMessages';
  static const guidepost = '/guidepost';
  static const updateProfile = '/update_profile';
  static const changePassword = '/change_password';

  //Landowner views
  static const landownerDashboard = '$_landowner/dashboard';
  static const landownerProfile = '$_landowner/profile';
  static const gardenHome = '$_landowner/garden_home';
  static const gardenForm = '$_landowner/garden_form';
  static const gardenDetails = '$_landowner/garden_details';
  static const jobPostForm = '$_landowner/job_post_form';
  static const landownerJobPostDetails = '$_landowner/job_post_details';
  static const paymentHistoryHome = '$_landowner/payment_history_home';
  static const paymentHistoryDetails = '$_landowner/payment_history_details';
  static const appliedFarmerDetails = '$_landowner/applied_farmer_details';
  static const checkAttendance = '$_landowner/check_attendance';
  static const landownerBookmark = '$_landowner/bookmark';
  static const landownerBookmarkDetails = '$_landowner/bookmark_details';
  static const jobFarmerList = '$_landowner/job_farmer_list';
  static const jobFarmerDetails = '$_landowner/job_farmer_details';
  static const landownerReportList = '$_landowner/report_list';
  static const landownerReportDetails = '$_landowner/report_details';
  static const landownerJobPostByType = '$_landowner/job_post_by_type';
  static const landownerJobPostByGarden = '$_landowner/job_post_by_garden';

  //farmer views
  static const farmerDashboard = '$_farmer/dashboard';
  static const farmerProfile = '$_farmer/profile';
  static const farmerJobPostDetail = '$_farmer/job_post_detail';
  static const farmerBookmarkAccount = '$_farmer/bookmark';
  static const farmerInprogressJobDetail = '$_farmer/inprogres_job_detail';
  static const farmerCheckAttendance = '$_farmer/check_attendance';
  static const farmerAttendanceWorkDay = '$_farmer/attendance_work_day';
  static const farmerHistoryJob = '$_farmer/history_job';
  static const farmerHistoryJobDetail = '$_farmer/history_job_detail';
  static const test = '/test';
}
