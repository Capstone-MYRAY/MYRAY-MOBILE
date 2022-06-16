import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class PersonalInformation extends StatelessWidget {
  final Rx<Account> user;

  const PersonalInformation({
    Key? key,
    required this.user,
  }) : super(key: key);

  _buildInformation(String left, String right) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: AppColors.backgroundColor,
              style: BorderStyle.solid,
              width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            left,
            style: Get.textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(right),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String _dob = user.value.dob != null
        ? DateFormat(CommonConstants.ddMMyyyy).format(user.value.dob!)
        : '';
    return SizedBox(
      width: Get.width * 0.9,
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thông tin cá nhân',
                    style: Get.textTheme.headline6,
                  ),
                  const SizedBox(height: 16.0),
                  _buildInformation(
                      'Số điện thoại', user.value.phoneNumber ?? ''),
                  const SizedBox(height: 24.0),
                  _buildInformation('Ngày sinh', _dob),
                  const SizedBox(height: 24.0),
                  _buildInformation('Giới tính', user.value.gender.toString()),
                  const SizedBox(height: 24.0),
                  _buildInformation('Email', user.value.email ?? ''),
                  const SizedBox(height: 24.0),
                  _buildInformation('Địa chỉ', user.value.address ?? ''),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thông tin cá nhân',
                    style: Get.textTheme.headline6,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      user.value.aboutMe == null
                          ? const Text('Chưa có thông tin')
                          : Text(user.value.aboutMe!),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
