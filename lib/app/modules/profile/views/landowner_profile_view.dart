import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';

class LandownerProfileView extends StatelessWidget {
  const LandownerProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final AuthController _authController = Get.find<AuthController>();
            _authController.logOut();
          },
          child: const Text(AppStrings.titleLogout),
        ),
      ),
    );
  }
}
