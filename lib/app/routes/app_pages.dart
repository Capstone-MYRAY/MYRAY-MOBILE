import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/applied_farmer/bindings/applied_farmer_details_binding.dart';
import 'package:myray_mobile/app/modules/applied_farmer/views/applied_farmer_details_view.dart';
import 'package:myray_mobile/app/modules/attendance/bindings/farmer_attendance_binding.dart';
import 'package:myray_mobile/app/modules/attendance/views/farmer_attendance/farmer_attendance_view.dart';
import 'package:myray_mobile/app/modules/attendance/views/farmer_attendance/farmer_workday_view.dart';
import 'package:myray_mobile/app/modules/auth/auth.dart';
import 'package:myray_mobile/app/modules/auth/views/enter_password_view.dart';
import 'package:myray_mobile/app/modules/bookmark/bindings/farmer_bookmark_binding.dart';
import 'package:myray_mobile/app/modules/bookmark/bindings/landowner_bookmark_binding.dart';
import 'package:myray_mobile/app/modules/bookmark/bindings/landowner_bookmark_details_binding.dart';
import 'package:myray_mobile/app/modules/bookmark/views/famer_bookmark.dart';
import 'package:myray_mobile/app/modules/bookmark/views/landowner_bookmark_details_view.dart';
import 'package:myray_mobile/app/modules/bookmark/views/landowner_bookmark_view.dart';
import 'package:myray_mobile/app/modules/change_password/bindings/change_password_binding.dart';
import 'package:myray_mobile/app/modules/change_password/views/change_password_view.dart';
import 'package:myray_mobile/app/modules/comment/bindings/comment_binding.dart';
import 'package:myray_mobile/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:myray_mobile/app/modules/dashboard/views/farmer_dashboard_view.dart';
import 'package:myray_mobile/app/modules/dashboard/views/landowner_dashboard_view.dart';
import 'package:myray_mobile/app/modules/garden/bindings/garden_details_binding.dart';
import 'package:myray_mobile/app/modules/garden/bindings/garden_form_binding.dart';
import 'package:myray_mobile/app/modules/garden/bindings/garden_home_binding.dart';
import 'package:myray_mobile/app/modules/garden/bindings/job_post_by_garden_binding.dart';
import 'package:myray_mobile/app/modules/garden/views/garden_details_view.dart';
import 'package:myray_mobile/app/modules/garden/views/garden_form_view.dart';
import 'package:myray_mobile/app/modules/garden/views/garden_home_view.dart';
import 'package:myray_mobile/app/modules/garden/views/job_post_by_garden_view.dart';
import 'package:myray_mobile/app/modules/guidepost/bindings/guidepost_binding.dart';
import 'package:myray_mobile/app/modules/guidepost/views/guidepost_view.dart';
import 'package:myray_mobile/app/modules/history_job/bindings/farmer_history_job_binding.dart';
import 'package:myray_mobile/app/modules/history_job/bindings/farmer_history_job_detail_binding.dart';
import 'package:myray_mobile/app/modules/history_job/bindings/history_applied_job_binding.dart';
import 'package:myray_mobile/app/modules/history_job/views/farmer_history_job_view.dart';
import 'package:myray_mobile/app/modules/history_job/views/farmer_hitory_job_detail_view.dart';
import 'package:myray_mobile/app/modules/history_job/views/history_applied_job_view.dart';
import 'package:myray_mobile/app/modules/home/bindings/farmer_home_binding.dart';
import 'package:myray_mobile/app/modules/home/bindings/farmer_job_post_detail_binding.dart';
import 'package:myray_mobile/app/modules/attendance/bindings/job_post_attendance_binding.dart';
import 'package:myray_mobile/app/modules/home/views/farmer_job_post_detail.dart';
import 'package:myray_mobile/app/modules/home/views/farmer_job_post_filter.dart';
import 'package:myray_mobile/app/modules/home/widgets/landowner_main_feature/job_post_by_type/job_post_by_type.dart';
import 'package:myray_mobile/app/modules/home/widgets/landowner_main_feature/job_post_by_type/job_post_by_type_binding.dart';
import 'package:myray_mobile/app/modules/job_farmer_list/job_farmer_list_module.dart';
import 'package:myray_mobile/app/modules/job_post/bindings/farmer_inprogress_job_detail_binding.dart';
import 'package:myray_mobile/app/modules/attendance/views/job_post_attendance_view.dart';
import 'package:myray_mobile/app/modules/job_post/bindings/job_post_form_binding.dart';
import 'package:myray_mobile/app/modules/job_post/bindings/landowner_job_post_details_binding.dart';
import 'package:myray_mobile/app/modules/job_post/views/job_post_form_view.dart';
import 'package:myray_mobile/app/modules/job_post/views/landowner_job_post_details_view.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_job/farmer_inprogress_job_detail.dart';
import 'package:myray_mobile/app/modules/message/bindings/p2p_message_binding.dart';
import 'package:myray_mobile/app/modules/message/views/p2p_message_view.dart';
import 'package:myray_mobile/app/modules/message/widgets/new_message/new_message_binding.dart';
import 'package:myray_mobile/app/modules/payment_history/payment_history_module.dart';
import 'package:myray_mobile/app/modules/profile/bindings/update_profile_binding.dart';
import 'package:myray_mobile/app/modules/profile/views/farmer_profile_detail.dart';
import 'package:myray_mobile/app/modules/profile/views/landowner_profile_details_view.dart';
import 'package:myray_mobile/app/modules/profile/views/update_profile_view.dart';
import 'package:myray_mobile/app/modules/report/bindings/landowner_report_binding.dart';
import 'package:myray_mobile/app/modules/report/bindings/landowner_report_details_binding.dart';
import 'package:myray_mobile/app/modules/report/views/landowner_report_details_view.dart';
import 'package:myray_mobile/app/modules/report/views/landowner_report_view.dart';
import 'package:myray_mobile/app/modules/topup/bindings/top_up_binding.dart';
import 'package:myray_mobile/app/modules/topup/views/top_up_view.dart';
import 'package:myray_mobile/init_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.init;

  static final routes = [
    GetPage(
      name: _Paths.init,
      page: () => const InitView(),
    ),
    GetPage(
      name: _Paths.chooseRole,
      page: () => const ChooseRoleView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.signup,
      page: () => const SignupView(),
      binding: SignupBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.enterOtp,
      page: () => const EnterOtpView(),
      binding: EnterOtpBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.resetPassword,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.enterPassword,
      page: () => const EnterPasswordView(),
      binding: SignupBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.p2pMessages,
      page: () => const P2PMessageView(),
      bindings: [NewMessageBinding(), P2PMessageBinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.guidepost,
      page: () => const GuidePostView(),
      bindings: [GuidepostBinding(), CommentBinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.updateProfile,
      page: () => const UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),

    //landowner
    GetPage(
      name: _Paths.landownerDashboard,
      page: () => const LandownerDashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.landownerProfile,
      page: () => const LandownerProfileDetailsView(),
    ),
    GetPage(
      name: _Paths.gardenHome,
      page: () => const GardenHomeView(),
      binding: GardenHomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.gardenForm,
      page: () => const GardenFormView(),
      binding: GardenFormBinding(),
    ),
    GetPage(
      name: _Paths.gardenDetails,
      page: () => const GardenDetailsView(),
      binding: GardenDetailsBinding(),
    ),
    GetPage(
      name: _Paths.jobPostForm,
      page: () => const JobPostFormView(),
      binding: JobPostFormBinding(),
    ),
    GetPage(
      name: _Paths.landownerJobPostDetails,
      page: () => LandownerJobPostDetailsView(),
      binding: LandownerJobPostDetailsBinding(),
    ),
    GetPage(
      name: _Paths.paymentHistoryHome,
      page: () => const PaymentHistoryHomeView(),
      binding: PaymentHistoryHomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.paymentHistoryDetails,
      page: () => const PaymentHistoryDetailsView(),
      binding: PaymentHistoryDetailsBinding(),
    ),
    GetPage(
      name: _Paths.appliedFarmerDetails,
      page: () => const AppliedFarmerDetailsView(),
      binding: AppliedFarmerDetailsBinding(),
    ),
    GetPage(
      name: _Paths.checkAttendance,
      page: () => const JobPostAttendanceView(),
      binding: JobPostAttendanceBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.landownerBookmark,
      page: () => const LandownerBookmarkView(),
      binding: LandownerBookmarkBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.landownerBookmarkDetails,
      page: () => const LandownerBookmarkDetailsView(),
      binding: LandownerBookmarkDetailsBinding(),
    ),
    GetPage(
      name: _Paths.jobFarmerList,
      page: () => const JobFarmerListView(),
      binding: JobFarmerListBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.jobFarmerDetails,
      page: () => const JobFarmerDetailsView(),
      binding: JobFarmerDetailsBinding(),
    ),
    GetPage(
      name: _Paths.landownerReportList,
      page: () => const LandownerReportView(),
      binding: LandownerReportBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.landownerReportDetails,
      page: () => const LandownerReportDetailsView(),
      binding: LandownerReportDetailsBinding(),
    ),
    GetPage(
      name: _Paths.landownerJobPostByType,
      page: () => const JobPostByType(),
      binding: JobPostByTypeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.landownerJobPostByGarden,
      page: () => const JobPostByGardenView(),
      binding: JobPostByGardenBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.topUp,
      page: () => const TopUpView(),
      binding: TopUpBinding(),
      transition: Transition.rightToLeft,
    ),

    //farmer
    GetPage(
      name: _Paths.farmerDashboard,
      page: () => const FarmerDashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.farmerProfile,
      page: () => const FarmerProfileDetailView(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.farmerJobPostDetail,
      page: () => const FarmerJobPostDetail(),
      binding: FarmerJobPostDetailBinding(),
    ),
    GetPage(
      name: _Paths.farmerBookmarkAccount,
      page: () => const FarmerBookmark(),
      binding: FarmerBookmarkBinding(),
    ),
    GetPage(
      name: _Paths.farmerInprogressJobDetail,
      page: () => FarmerInProgressJobDetail(),
      transition: Transition.rightToLeftWithFade,
      binding: FarmerInprogressJobDetailBinding(),
    ),
    GetPage(
      name: _Paths.farmerCheckAttendance,
      page: () => const FarmerAttendanceView(),
      transition: Transition.topLevel,
      binding: FarmerAttendanceBinding(),
    ),
    GetPage(
      name: _Paths.farmerAttendanceWorkDay,
      page: () => const FarmerWorkDayView(),
      transition: Transition.rightToLeft,
      binding: FarmerAttendanceBinding(),
    ),
    GetPage(
      name: _Paths.farmerHistoryJob,
      page: () => const FarmerHistoryJobView(),
      binding: FarmerHistoryJobBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.farmerHistoryJobDetail,
      page: () => const FarmerHistoryJobDetail(),
      binding: FarmerHistoryJobDetailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.changePassword,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.farmerHistoryAppliedJob,
      page: () => const HistoryAppliedJobView(),
      binding: HistoryAppliedJobBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.farmerJobPostFilter,
      page: () => FarmerJobPostFilter(),
      binding: FarmerJobPostBinding(),
      transition: Transition.downToUp,
    )
  ];
}
