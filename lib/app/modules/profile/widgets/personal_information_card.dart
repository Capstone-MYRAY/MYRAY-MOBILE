import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field_no_icon.dart';

class PersonalInformation extends StatelessWidget {
  final Rx<Account> user;

  const PersonalInformation({
    Key? key,
    required this.user,
  }) : super(key: key);

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
                  CardFieldNoIcon(
                    title: 'Số điện thoại',
                    data: user.value.phoneNumber ?? '',
                  ),
                  const SizedBox(height: 24.0),
                  CardFieldNoIcon(
                    title: 'Ngày sinh',
                    data: _dob,
                  ),
                  const SizedBox(height: 24.0),
                  CardFieldNoIcon(
                    title: 'Giới tính',
                    data: user.value.genderString,
                  ),
                  const SizedBox(height: 24.0),
                  CardFieldNoIcon(
                    title: 'Email',
                    data: user.value.email ?? '',
                  ),
                  const SizedBox(height: 24.0),
                  CardFieldNoIcon(
                    title: 'Địa chỉ',
                    data: user.value.address ?? '',
                  ),
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
                    'Mô tả',
                    style: Get.textTheme.headline6,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: user.value.aboutMe == null
                            ? const Text(
                                'Chưa có thông tin',
                              )
                            : Text(
                                user.value.aboutMe!,
                              ),
                      ),
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
