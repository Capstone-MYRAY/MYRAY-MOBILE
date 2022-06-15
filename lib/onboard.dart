import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:myray_mobile/app/modules/auth/views/views.dart';
import 'package:myray_mobile/app/modules/dashboard/views/farmer_dashboard_view.dart';
import 'package:myray_mobile/app/modules/dashboard/views/landowner_dashboard_view.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class OnBoard extends GetView<AuthController> {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLogged.value) {
        if (Utils.equalsIgnoreCase(
            Roles.landowner.name, AuthCredentials.instance.user!.role!)) {
          return const LandownerDashboardView();
        }
        return const FarmerDashboardView();
      }
      return const LoginView();
    });
  }
}
