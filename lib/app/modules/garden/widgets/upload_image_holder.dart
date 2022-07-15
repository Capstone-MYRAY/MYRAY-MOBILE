import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:images_picker/images_picker.dart";
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';

class UploadImage {
  int id;
  String path;

  UploadImage({required this.id, required this.path});
}

class UploadImageHolder extends StatefulWidget {
  const UploadImageHolder({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadImageHolder> createState() => UploadImageHolderState();
}

class UploadImageHolderState extends State<UploadImageHolder> {
  final List<UploadImage> _selectedImages = [];
  final List<String> _tempDelete = [];
  bool _isError = false;
  final String _errorContent = 'Hãy chọn tối thiểu một bức ảnh';

  @override
  Widget build(BuildContext context) {
    return _selectedImages.isEmpty
        ? _buildImagePicker()
        : _buildImagesDisplay();
  }

  bool validate() {
    setState(() {
      _isError = _selectedImages.isEmpty;
    });
    return !_isError;
  }

  List<UploadImage> get selectedImages => _selectedImages;
  List<String> get deleteImages {
    return _tempDelete.map((image) => image.split('/').last).toList();
  }

  setImages(List<UploadImage> images) {
    _selectedImages.addAll(images);
    setState(() {});
  }

  _showImageDialog({int maxImage = CommonConstants.maxImage}) async {
    return await ImagesPicker.pick(
      count: maxImage,
      pickType: PickType.image,
      language: Language.System,
      quality: 0.6,
    );
  }

  _addImage({int maxImage = CommonConstants.maxImage}) async {
    List<Media>? tempImages = await _showImageDialog(maxImage: maxImage);
    if (tempImages != null) {
      for (var image in tempImages) {
        int id = _selectedImages.length + 1;
        _selectedImages.add(UploadImage(id: id, path: image.path));
      }
      setState(() {});
    }
  }

  Widget _buildImagePicker() {
    return Material(
      borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      color: AppColors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
        onTap: () async => await _addImage(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
            vertical: 64.0,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              CustomIcons.image_plus,
              size: 40,
            ),
            const SizedBox(height: 8.0),
            const Text('Bấm để chọn ảnh'),
            const SizedBox(height: 4.0),
            Text(
              '(Tối đa 4 ảnh)',
              style: Get.textTheme.caption,
            ),
            _isError
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _errorContent,
                      style: Get.textTheme.bodyText2!.copyWith(
                        color: AppColors.errorColor,
                      ),
                    ),
                  )
                : const SizedBox(),
          ]),
        ),
      ),
    );
  }

  //clear all images when click on "x" button
  _clearImages() {
    _selectedImages.clear();
    setState(() {});
  }

  _addTempDeletImg(String path) {
    if (Utils.isNetworkImage(path)) {
      _tempDelete.add(path);
    }
  }

  _removeImage(int id) {
    print('xóa $id nè');
    final index = _selectedImages.indexWhere((image) => image.id == id);
    if (index >= 0) {
      //add image to temp delete
      _addTempDeletImg(_selectedImages[index].path);

      _selectedImages.removeAt(index);
      setState(() {});
    }
  }

  _editImage(int id) async {
    final tempImage = await _showImageDialog(maxImage: 1);
    if (tempImage != null) {
      final UploadImage? found =
          _selectedImages.firstWhere((image) => image.id == id);
      if (found != null) {
        //add image to temp delete
        _addTempDeletImg(found.path);

        //Update image
        found.path = tempImage[0].path;
        setState(() {});
      }
    }
  }

  //build widget which clicks to add more picture
  Widget _buildAddImagePlaceHolder() {
    return Material(
      borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      child: InkWell(
        onTap: () async => await _addImage(
            maxImage: CommonConstants.maxImage - _selectedImages.length),
        borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
        child: Container(
          margin:
              const EdgeInsets.only(bottom: 1), //fix lose bottom dash border
          child: DottedBorder(
            borderType: BorderType.RRect,
            color: AppColors.black,
            radius: const Radius.circular(CommonConstants.borderRadius),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      CustomIcons.camera_plus,
                      size: 40.0,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Còn ${CommonConstants.maxImage - _selectedImages.length} ảnh',
                      style: Get.textTheme.caption,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  //build grid item
  Widget _buildImagePlaceHolder(String path, int id) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Utils.isNetworkImage(path)
                  ? Image.network(
                      path,
                      fit: BoxFit.fill,
                    )
                  : Image.file(
                      File(path),
                      fit: BoxFit.fill,
                    ),
            ),
          ),
          const SizedBox(height: 16.0),
          FilledButton(
            title: AppStrings.titleEdit,
            onPressed: () => _editImage(id),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 4.0,
            ),
          ),
          const SizedBox(height: 16.0),
          FilledButton(
            title: AppStrings.titleDelete,
            onPressed: () => _removeImage(id),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 4.0,
            ),
            color: AppColors.errorColor,
          ),
        ],
      ),
    );
  }

  //build images display in grid view
  Widget _buildImagesDisplay() {
    return SizedBox(
        width: Get.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 5 / 8,
                children: [
                  ..._selectedImages
                      .map(
                        (image) => ClipRRect(
                          borderRadius: BorderRadius.circular(
                            CommonConstants.borderRadius,
                          ),
                          child: _buildImagePlaceHolder(image.path, image.id),
                        ),
                      )
                      .toList(),
                  if (_selectedImages.length < CommonConstants.maxImage)
                    _buildAddImagePlaceHolder(),
                ],
              ),
            ),
          ],
        ));
  }
}
