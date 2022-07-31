
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/guidepost/guidepost.dart';

class FullGuidepost{
  final Guidepost guidepost;
  final Account? account;

  FullGuidepost({
    required this.guidepost,
    this.account
  });

}