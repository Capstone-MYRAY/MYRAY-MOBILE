import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/guidepost/guidepost.dart';
import 'package:myray_mobile/app/modules/comment/widgets/comment_modal_bottom_sheet.dart';
import 'package:myray_mobile/app/modules/guidepost/controllers/guidepost_controller.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class GuidePostView extends GetView<GuidepostController> {
  const GuidePostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bài hướng dẫn'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: controller.getGuidepost(),
          builder: (context, snapshot) {
            return Obx(
              () => LazyLoadingList(
                onEndOfPage: controller.getGuidepost,
                onRefresh: controller.onRefresh,
                itemCount: controller.guidepostList.length,
                isLoading: controller.isLoading.value,
                itemBuilder: (context, index) {
                  Guidepost guidepost = controller.guidepostList[index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text('Title: ${guidepost.title}'),
                        const SizedBox(
                          height: 10,
                        ),
                        // Html(
                        //   data: guidepost.content,
                        //   shrinkWrap: true,
                        // ),
                        Html.fromDom(
                          document: HtmlParser.parseHTML(guidepost.content),
                        ),
                        Divider(
                            color: Colors.grey.withOpacity(0.5),
                            indent: 15,
                            endIndent: 15,
                            height: 10),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            print('open dialog comment');
                            CommentModalBottomSheet.showCommentBox(
                              context: context,
                              guidePostId: guidepost.id,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.mode_comment_outlined,
                                size: 20,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                AppStrings.labelComment,
                                style: Get.textTheme.button!.copyWith(
                                  fontSize: Get.textScaleFactor * 17,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ));
  }
}
