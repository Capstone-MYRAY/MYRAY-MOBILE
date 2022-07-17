import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/message/widgets/farmer_messages/farmer_message_item.dart';

class FarmerMessageList extends StatelessWidget {
  const FarmerMessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FarmerMessageItem(
          title: 'Cạo mủ cao su',
          name: 'Hồ Lâm',
          isRead: true,
          onTap: () {},
        ),
        FarmerMessageItem(
          title: 'Thu hoạch cà phê',
          name: 'Tùng Lâm',
          isRead: false,
          onTap: () {},
        ),
        FarmerMessageItem(
          title: 'Thu hoạch cây lâu năm',
          name: 'Đình Tùng',
          isRead: false,
          onTap: () {},
        ),
      ],
    );
  }
}
