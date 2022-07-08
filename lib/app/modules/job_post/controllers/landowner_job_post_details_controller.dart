import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history_models.dart';
import 'package:myray_mobile/app/modules/garden/garden_repository.dart';
import 'package:myray_mobile/app/modules/payment_history/payment_history_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class LandownerJobPostDetailsController extends GetxController {
  final Rx<JobPost> jobPost;
  final List<PaymentHistory> paymentHistories = [];
  final _gardenRepository = Get.find<GardenRepository>();
  final _paymentHistoryRepository = Get.find<PaymentHistoryRepository>();

  LandownerJobPostDetailsController({required this.jobPost});

  @override
  void onInit() {
    print('init');

    super.onInit();
  }

  viewGardenDetails() async {
    //get garden by id
    Garden? garden = await _gardenRepository.getById(jobPost.value.gardenId);

    if (garden == null) {
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );

      return;
    }

    Get.toNamed(Routes.gardenDetails, arguments: {
      Arguments.tag: garden.id.toString(),
      Arguments.item: garden,
      Arguments.action: Activities.view,
    });
  }

  Future<bool?> getPaymentHistory() async {
    paymentHistories.clear();
    final int _accountId = AuthCredentials.instance.user!.id!;
    final _data = GetPaymentHistoryRequest(
      page: 1.toString(),
      pageSize: 10.toString(),
      jobPostId: jobPost.value.id.toString(),
      sortColumn: PaymentHistorySortColumn.createdDate,
      orderBy: SortOrder.descending,
    );

    final _response =
        await _paymentHistoryRepository.getList(_accountId, _data);
    if (_response == null || _response.paymentHistories!.isEmpty) {
      return null;
    }

    paymentHistories.addAll(_response.paymentHistories!);
    return true;
  }

  Future<void> onRefresh() async {}
}
