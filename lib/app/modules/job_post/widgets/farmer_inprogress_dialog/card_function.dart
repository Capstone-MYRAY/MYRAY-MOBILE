import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';

class CardFunction extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onTap;

  const CardFunction(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2.5,
              blurRadius: 5,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 9),
                child: Icon(icon, size: 50, color: AppColors.primaryColor),
              ),
              // const Size
              Expanded(
                child: Text.rich(
                  TextSpan(text: title),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.labelMedium!.copyWith(
                    fontSize: Get.textScaleFactor * 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.brown
                  ),
                ),
              ),
              // SizedBox(height: Get.height * 0.05,),
            ],
          ),
        ),
      ),
    );
  }
}
