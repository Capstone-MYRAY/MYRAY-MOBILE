import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/extend_end_date_job.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/get_extend_end_date_job_request.dart';
import 'package:myray_mobile/app/data/services/extend_job_service.dart';
import 'package:myray_mobile/app/modules/extend_history/extend_job_repository.dart';
import 'package:myray_mobile/app/modules/profile/controllers/landowner_profile_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class ExtendJobController extends GetxController with ExtendJobService {
  final _extendJobRepository = Get.find<ExtendJobRepository>();

  RxList<ExtendEndDateJob> extendRequests = RxList<ExtendEndDateJob>();
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextPage = true;

  final isLoading = false.obs;

  Future<bool?> getExtendRequests() async {
    final data = GetExtendEndDateJobRequest(
      status: ExtendJobEndDateStatus.pending.index.toString(),
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      sortColumn: ExtendTaskJobSortColumn.createdDate,
      orderBy: SortOrder.descending,
    );

    //load applied farmer

    isLoading.value = true;
    try {
      if (_hasNextPage) {
        final response = await _extendJobRepository.getList(data);
        if (response == null || response.extendRequests!.isEmpty) {
          isLoading.value = false;
          return null;
        }

        extendRequests.addAll(response.extendRequests!);
        //update hasNext
        _hasNextPage = response.metadata!.hasNextPage;
      }
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      _hasNextPage = false;
      return null;
    }
  }

  Future<void> onRefresh() async {
    //reset current page & hasNext
    _currentPage = 0;
    _hasNextPage = true;

    //clear applied farmer list
    extendRequests.clear();

    //load user info
    final profile = Get.find<LandownerProfileController>();
    profile.getUserInfo();

    update();
  }

  onApprove(ExtendEndDateJob request) async {
    try {
      bool? success = await approveExtend(request.id);

      //user cancel action
      if (!success) return;

      //update status
      request.status = ExtendJobEndDateStatus.approved.index;

      extendRequests.refresh();
    } catch (e) {
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  onReject(ExtendEndDateJob request) async {
    try {
      bool? success = await rejectExtend(request.id);

      //user cancel action
      if (!success) return;

      //update status
      request.status = ExtendJobEndDateStatus.rejected.index;

      extendRequests.refresh();
    } catch (e) {
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }
}
