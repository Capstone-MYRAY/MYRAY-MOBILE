import 'package:flutter/cupertino.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class StatusChip extends StatelessWidget {

  final String statusName; 
  final Color color;

  const StatusChip({Key? key, required this.statusName, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: Color(0xfff34740),
        color:color,
      ),
      padding: const EdgeInsets.only(
        top: 4,
        bottom: 5,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            statusName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
              letterSpacing: 0.45,
            ),
          ),
        ],
      ),
    );
  }
}
