import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class SwitchCameraButton extends StatelessWidget {
  const SwitchCameraButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        final int? availableCameras = state.availableCameras;

        if (availableCameras != null && availableCameras < 2) {
          return const SizedBox.shrink();
        }

        // final Widget icon;
        //
        // switch (state.cameraDirection) {
        //   case CameraFacing.front:
        //     icon = const Icon(Icons.camera_front);
        //   case CameraFacing.back:
        //     icon = const Icon(Icons.camera_rear);
        // }

        return GestureDetector(
          child: SvgPicture.asset(
            'assets/svg/camera_switch.svg',
            width: 32.0,
            height: 32.0,
          ),
          onTap: () async {
            await controller.switchCamera();
          },
          // iconSize: 32.0,
          // icon: icon,
        );
      },
    );
  }
}