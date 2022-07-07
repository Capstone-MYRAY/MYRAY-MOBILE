import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class PaymentHistoryDetailsController extends GetxController {
  final Rx<PaymentHistory> paymentHistory;
  final _jobPostRepository = Get.find<JobPostRepository>();

  PaymentHistoryDetailsController({required this.paymentHistory});

  viewJobPostDetails() async {
    //get job post by id
    try {
      JobPost? jobPost =
          await _jobPostRepository.getById(paymentHistory.value.jobPostId!);

      if (jobPost == null) {
        CustomSnackbar.show(
          title: AppStrings.titleError,
          message: 'Có lỗi xảy ra',
          backgroundColor: AppColors.errorColor,
        );

        return;
      }

      Get.toNamed(Routes.landownerJobPostDetails, arguments: {
        Arguments.tag: jobPost.id.toString(),
        Arguments.item: jobPost,
        Arguments.action: Activities.view,
      });
    } on Exception {
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }
}
