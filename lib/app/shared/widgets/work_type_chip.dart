import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';

class WorkTypeChip extends StatelessWidget {
  final String? workType;
  const WorkTypeChip({ Key? key, this.workType = "" }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                width: 52,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppColors.primaryColor,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      workType!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
  }
}