import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/area/area.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/custom_icon_button.dart';
import 'package:myray_mobile/app/shared/widgets/my_card.dart';

class GardenDetailsCard extends StatelessWidget {
  final Garden garden;
  final Area area;
  const GardenDetailsCard({
    Key? key,
    required this.garden,
    required this.area,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CustomIconButton(
              icon: CustomIcons.pencil,
              onTap: () {},
              toolTip: AppStrings.titleEdit,
              size: 20,
            ),
          ),
          Text(
            'Thông tin vườn',
            style: Get.textTheme.headline6,
          ),
          const SizedBox(height: 12),
          CardField(
            icon: CustomIcons.sprout_outline,
            title: AppStrings.labelGardenName,
            data: garden.name,
          ),
          const SizedBox(height: 8),
          CardField(
            icon: CustomIcons.map_marker_outline,
            title: AppStrings.labelProvince,
            data: area.province,
          ),
          const SizedBox(height: 8),
          CardField(
            icon: CustomIcons.map_marker_outline,
            title: AppStrings.labelDistrict,
            data: area.district,
          ),
          const SizedBox(height: 8),
          CardField(
            icon: CustomIcons.map_marker_outline,
            title: AppStrings.labelCommune,
            data: area.commune,
          ),
          const SizedBox(height: 8),
          CardField(
            icon: CustomIcons.map_marker_outline,
            title: AppStrings.labelAddress,
            data: garden.address,
          ),
          const SizedBox(height: 8),
          CardField(
            icon: CustomIcons.mountain,
            title: AppStrings.labelLandArea,
            data: garden.landArea.toString(),
          ),
          const SizedBox(height: 8),
          CardField(
            icon: Icons.paste_outlined,
            title: AppStrings.labelDescription,
            data: garden.description,
          ),
          const SizedBox(height: 16),
          Text(
            'Hình ảnh',
            style: Get.textTheme.headline6,
          ),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ...garden.imageUrl
                  .split(CommonConstants.imageDelimiter)
                  .map((path) => _buildImage(path))
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Image.network(
          path,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
