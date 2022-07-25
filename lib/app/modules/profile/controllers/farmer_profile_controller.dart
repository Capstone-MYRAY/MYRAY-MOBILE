import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/modules/profile/profile_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';

class FarmerProfileController extends GetxController{

  final _profileRepository = Get.find<ProfileRepository>();
  var user = Account().obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserInfor();

  }

  getUserInfor() async {
    Account? user = await _profileRepository.getUser(AuthCredentials.instance.user!.id!);
     if(user != null){
      this.user.value = user;
     }
  }

  void  navigateToDetailpage(){
    Get.toNamed(Routes.farmerProfile);
  }

  void navigateToBookmarkPage(){
    Get.toNamed(Routes.farmerBookmarkAccount);
  }
 
  void navigateToAttendancePage(){
    Get.toNamed(Routes.farmerCheckAttendance);
  }
 
}