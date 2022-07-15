import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

mixin MessageService {
  navigateToP2PMessageScreen(int fromId, int toId, int jobPostId,
      {String? toAvatar}) {
    if (fromId == 0 || toId == 0 || jobPostId == 0) {
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
      return;
    }

    final conventionId = StringBuffer();
    conventionId.write(jobPostId.toString());
    if (Utils.equalsIgnoreCase(
        Roles.landowner.name, AuthCredentials.instance.user!.role!)) {
      conventionId.write('$fromId$toId');
    } else {
      conventionId.write('$toId$fromId');
    }

    Get.toNamed(Routes.p2pMessages, arguments: {
      Arguments.from: AuthCredentials.instance.user!.id,
      Arguments.to: toId,
      Arguments.jobPostId: jobPostId,
      Arguments.conventionId: conventionId.toString(),
      Arguments.toAvatar: toAvatar,
    });
  }
}
