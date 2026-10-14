import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_boxy_ds/components/bottomsheet/mb_main_bottomsheet.dart';
import 'package:my_boxy_ds/components/buttons/mb_upload_file_btn.dart';
import 'package:my_boxy_ds/components/caroussels/mb_main_horizontal_carousel.dart';
import 'package:my_boxy_ds/components/containers/mb_main_view.dart';
import 'package:my_boxy_ds/components/labels/mb_title_subtitled_label.dart';
import 'package:my_boxy_ds/components/mb_separator.dart';
import 'package:my_boxy_ds/components/tiles/mb_light_item_tile.dart';
import 'package:my_boxy_ds/components/views/mb_camera_view.dart';
import 'package:my_boxy_ds/components/views/mb_main_loading_view.dart';
import 'package:my_boxy_ds/components/views/mb_uploaded_image_view.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class CameraTestView extends StatefulWidget {
  const CameraTestView({super.key});

  @override
  State<CameraTestView> createState() => _CameraTestViewState();
}

class _CameraTestViewState extends State<CameraTestView> {
  final List<String> _selectedImagePaths = [];

  void _showImageSourceBottomsheet(BuildContext context) {
    MBMainBottomsheet.show(
      context,
      title: 'Adicionar imagem',
      description: 'Selecione origem da imagem',
      textAlign: .left,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.small),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MBLightItemTile(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.medium,
                vertical: AppSizes.small,
              ),
              icon: LucideIcons.images,
              label: 'Rolo da câmera',
              actionIcon: LucideIcons.chevron_right,
              onTap: () => _openGallery(context),
            ),
            MBLightItemTile(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.medium,
                vertical: AppSizes.small,
              ),
              icon: LucideIcons.camera,
              label: 'Tirar foto',
              actionIcon: LucideIcons.chevron_right,
              onTap: () => _openCamera(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openCamera(BuildContext context) async {
    await Navigator.of(context).maybePop();
    if (!context.mounted) return;

    final filePath = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (cameraContext) => MBCameraView(
          onMediaCaptured: (filePath) =>
              Navigator.of(cameraContext).pop(filePath),
        ),
      ),
    );
    if (filePath == null || !context.mounted) return;

    await _addSelectedImage(filePath);
  }

  Future<void> _openGallery(BuildContext context) async {
    await Navigator.of(context).maybePop();
    if (!context.mounted) return;

    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        requestFullMetadata: false,
      );
      if (image == null || !context.mounted) return;

      await _addSelectedImage(image.path);
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Imagem selecionada com sucesso.')),
      );
    } on PlatformException catch (error) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível abrir galeria: ${error.message}'),
        ),
      );
    }
  }

  Future<void> _addSelectedImage(String path) async {
    await _runWithLoading(() => precacheImage(FileImage(File(path)), context));
    if (!mounted) return;

    setState(() => _selectedImagePaths.add(path));
  }

  Future<T> _runWithLoading<T>(Future<T> Function() request) async {
    final navigator = Navigator.of(context);
    final controller = MBMainLoadingViewController();
    final loadingRoute = PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) =>
          MBMainLoadingView(controller: controller),
    );

    navigator.push(loadingRoute);
    try {
      return await request();
    } finally {
      await controller.dismiss();
      if (loadingRoute.isActive) navigator.removeRoute(loadingRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MBMainView(
      viewTitle: 'Teste de Câmera',
      hasBottomMenu: false,
      child: Padding(
        padding: EdgeInsets.all(AppSizes.medium),
        child: Column(
          children: [
            MBTitleSubtitled(
              title: 'Upload de Imagem',
              description: 'A funcionalidade testa o upload de imagens utilizando a câmera ou a galeria do dispositivo.',
            ),
            MBSeparator(margin: AppSizes.medium),
            MBUploadFileButton(
              height: 100,
              width: double.infinity,
              label: 'Upload de imagem',
              onTap: () => _showImageSourceBottomsheet(context),
            ),
            if (_selectedImagePaths.isNotEmpty) ...[
              const SizedBox(height: AppSizes.medium),
              SizedBox(
                height: 120,
                child: MBMainHorizontalCarousel(
                  items: List.generate(
                    _selectedImagePaths.length,
                    (index) => MBUploadedImageView(
                      imagePath: _selectedImagePaths[index],
                      onDelete: () =>
                          setState(() => _selectedImagePaths.removeAt(index)),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
