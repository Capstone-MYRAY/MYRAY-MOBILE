import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/garden/garden_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class LandownerJobPostDetailsController extends GetxController {
  final Rx<JobPost> jobPost;
  final _gardenRepository = Get.find<GardenRepository>();

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
}
