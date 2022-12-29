import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:frenly/presentation/screens/post/widgets/custom_bottom_sheet.dart';

class ImageList extends StatelessWidget {
  final List<File> imageList;
  final Function() pickImage;
  final Function() pickMultiImage;
  final Function(File image) removeImage;

  const ImageList({
    super.key,
    required this.imageList,
    required this.pickImage,
    required this.pickMultiImage,
    required this.removeImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 78,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              width: 70,
              child: InkWell(
                child: const Icon(
                  CommunityMaterialIcons.camera_plus_outline,
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return CustomBottomSheet(
                        openCamera: () {
                          pickImage();
                          Navigator.pop(context);
                        },
                        openGallery: () {
                          pickMultiImage();
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Image.file(
                        imageList[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    child: InkWell(
                      onTap: () {
                        removeImage(imageList[index]);
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: const Icon(
                        CommunityMaterialIcons.close_circle_outline,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 4,
              );
            },
            itemCount: imageList.length,
          ),
        ],
      ),
    );
  }
}
