import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/custom_textButton.dart';

class FarmerInprogressJobList extends StatelessWidget {
  const FarmerInprogressJobList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Card(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: 
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child:
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                                "Thu hoạch cà phê vào năm tới + Thu hoạch hồ tiêu, mắc ca, hột điều",
                                style: Get.textTheme.headline3?.copyWith(
                                  color: AppColors.brown,
                                ),
                                softWrap: true,
                                maxLines: 3,
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis
                              ),
                          ),
                        ],
                      ),
                      
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Row(
                      children: [
                        const Icon(CustomIcons.map_marker_outline, size: 20),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                              "144 Dương Đình Hội, lô 17 - D11, phường Phước Long B, thành phố Thủ Đức, thành phố Hồ Chí Minh",
                              style: Get.textTheme.bodyText2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              maxLines: 10,
                            ),
                        ),
                        
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              AppStrings.labelWorkingTime,
                              style: Get.textTheme.labelMedium,
                            ),
                            const SizedBox(height: 7),
                            Row(
                              children: [
                                Text(
                                  '7:00',
                                  style: Get.textTheme.labelSmall!.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                                Text(
                                  ' - ',
                                  style: Get.textTheme.labelMedium!.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                                Text(
                                  '17:00',
                                  style: Get.textTheme.labelSmall!.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 7),
                            CustomTextButton(onPressed: (){}, title: "Báo cáo",),
                           
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              AppStrings.labelPresentDate,
                              style: Get.textTheme.labelMedium,
                            ),
                            const SizedBox(height: 7),
                            Text(
                              '26-06-2022',
                              style: Get.textTheme.labelSmall!.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            CustomTextButton(
                              onPressed: () {},
                              title: AppStrings.labelOnLeave,
                              border: Border.all(
                                color: AppColors.primaryColor,
                              ),
                              foreground: AppColors.primaryColor,
                              background: AppColors.white,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              AppStrings.labelShortJobEndDate,
                              style: Get.textTheme.labelMedium,
                            ),
                            const SizedBox(height: 7),
                            Text(
                              '26-01-2023',
                              style: Get.textTheme.labelSmall!.copyWith(
                                color: AppColors.errorColor,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            index % 2 == 0 ?
                            CustomTextButton(onPressed: (){}, title: AppStrings.extendButton,)
                            : CustomTextButton(onPressed: (){}, title: AppStrings.buttonCheckAttendance,),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
