import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final Function() openCamera;
  final Function() openGallery;

  const CustomBottomSheet({
    super.key,
    required this.openCamera,
    required this.openGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Ink(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            width: 48,
            height: 48,
            child: InkWell(
              child: const Icon(CommunityMaterialIcons.camera_outline),
              onTap: () => openCamera(),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Ink(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            width: 48,
            height: 48,
            child: InkWell(
              child: const Icon(CommunityMaterialIcons.image_multiple_outline),
              onTap: () => openGallery(),
            ),
          ),
        ],
      ),
    );
  }
}
