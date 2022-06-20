import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/home/widgets/farmer_post_card.dart';
import 'package:myray_mobile/app/shared/widgets/status_chip.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';

class FarmerHomeView extends StatelessWidget {
  const FarmerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.home),
          centerTitle: true,
        ),
        body: const FarmerPostCard(
            title: "Thu hoạch cà phê",
            address: "142 Lâm Đồng",
            price: 30000,
            treeType: "Cây cà phê",
            workType: "Làm khoán",
            isStatus: true,
            ));
  }
}
