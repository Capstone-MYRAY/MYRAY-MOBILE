import 'package:flutter/material.dart';

import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/landowner_appbar.dart';
import 'package:myray_mobile/app/shared/widgets/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/status_chip.dart';

class LandownerJobPostView extends StatelessWidget {
  const LandownerJobPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LandownerAppbar(
        title: Text(
          AppStrings.jobPost,
          textScaleFactor: 1,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyCard(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: StatusChip(
                        backgroundColor: AppColors.grey,
                        foregroundColor: AppColors.white,
                        statusName: 'Thường',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
