import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/card_function.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';

class HistoryJobHomeView extends StatelessWidget {
  const HistoryJobHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử công việc'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('Dash board'),
            Row(
              children: [
                _buildHistoryJobCard(
                  icon: Icons.history_toggle_off_outlined,
                  title: 'Công việc đã ứng tuyển',
                  onTap:  () {
                    Get.toNamed(Routes.farmerHistoryAppliedJob);
                  },
                ),
                const SizedBox(
                  width: 30,
                ),
                _buildHistoryJobCard(
                  icon: Icons.work_history_outlined,
                  title: 'Công việc           đã làm',
                  onTap: () {
                    Get.toNamed(Routes.farmerHistoryJob);
                  },
                )
              ],
            ),
            // CardFunction(title: 'Đã làm việc', icon: Icons.history, onTap: (){
            //   Get.toNamed(Routes.farmerHistoryJob);
            // }),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryJobCard({
    required IconData icon,
    required String title,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.8),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, -20),
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              // horizontal: 10,
              vertical: Get.width * 0.5,
            ),            
            child: Column(
              children: [
                Icon(icon, size: 50, color: AppColors.brown.withOpacity(0.8)),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: Get.width * 0.4,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black.withOpacity(0.8)
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
