import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:photo_view/photo_view.dart';

class HeroPhotoView extends StatefulWidget {
  final ImageProvider imageProvider;
  final String tag;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  const HeroPhotoView({
    Key? key,
    required this.imageProvider,
    required this.tag,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  }) : super(key: key);

  @override
  State<HeroPhotoView> createState() => _HeroPhotoViewState();
}

class _HeroPhotoViewState extends State<HeroPhotoView> {
  bool _isDisplayAppBar = true;

  _toggleDisplay() {
    setState(() {
      _isDisplayAppBar = !_isDisplayAppBar;
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.featureColor,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      sized: true,
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.black.withOpacity(0.8),
      ),
      child: Scaffold(
        body: GestureDetector(
          onTap: _toggleDisplay,
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.height,
                ),
                child: PhotoView(
                  imageProvider: widget.imageProvider,
                  backgroundDecoration: widget.backgroundDecoration,
                  minScale: widget.minScale,
                  maxScale: widget.maxScale,
                  heroAttributes: PhotoViewHeroAttributes(tag: widget.tag),
                ),
              ),
              if (_isDisplayAppBar)
                SafeArea(
                  child: Material(
                    elevation: 1.0,
                    color: AppColors.black.withOpacity(0.8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16.0,
                      ),
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Text(
                          AppStrings.titleClose,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
