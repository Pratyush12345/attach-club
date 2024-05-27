import 'dart:async';
import 'package:attach_club/constants.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:attach_club/views/profile/profile.dart';
import 'package:attach_club/views/qr_code/scanner_error_widget.dart';
import 'package:attach_club/views/qr_code/switch_camera_button.dart';
import 'package:attach_club/views/qr_code/toggle_flashlight_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final TabController _controller;
  int activeTabIndex = 0;
  final MobileScannerController controller = MobileScannerController(
      // formats: [BarcodeFormat.qrCode]
      // detectionTimeoutMs: 1000,
      );
  Barcode? _barcode;
  StreamSubscription<Object?>? _subscription;
  bool isNavigated = false;

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scan something!',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) async {
    if (mounted && !isNavigated) {
      isNavigated = true;
      // _barcode = barcodes.barcodes.firstOrNull;
      await Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return Profile(uid: barcodes.barcodes.firstOrNull?.displayValue ?? "", buttonTitle: "Connect" ,);
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    //mobile scanner
    WidgetsBinding.instance.addObserver(this);
    _subscription = controller.barcodes.listen(_handleBarcode);
    unawaited(controller.start());

    //tab controller
    _controller = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {
        activeTabIndex = _controller.index;
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Scan QR"),
          centerTitle: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 32,
                child: (_controller.index == 1)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SwitchCameraButton(controller: controller),
                          SizedBox(
                            width: 0.03472222222 * width,
                          ),
                          ToggleFlashlightButton(controller: controller),
                        ],
                      )
                    : null,
              ),
              Container(
                width: 0.6813953488 * width,
                height: 0.6813953488 * width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(19),
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      QrImageView(
                        data: "${GlobalVariable.metaData.webURL}${GlobalVariable.userData.username}",
                        version: QrVersions.auto,
                        size: 0.6813953488 * width,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: 0.6813953488 * width,
                        height: 0.6813953488 * width,
                        child: MobileScanner(
                          controller: controller,
                          errorBuilder: (context, error, child) {
                            return ScannerErrorWidget(error: error);
                          },
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              _getTabBar(width),
            ],
          ),
        ),
      ),
    );
  }

  _getTabBar(double width) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 0.4279069767 * width,
        maxWidth: 0.5279069767 * width,
      ),
      height: 48,
      decoration: const BoxDecoration(
        color: Color(0xFF26293B),
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                surfaceVariant: Colors.transparent,
              ),
        ),
        child: TabBar(
          controller: _controller,
          tabAlignment: TabAlignment.center,
          isScrollable: true,
          indicator: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          tabs: [
            Tab(
              child: (activeTabIndex == 0)
                  ? _getActivePill("QR Code")
                  : const Text(
                      "QR Code",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
            Tab(
              child: (activeTabIndex == 1)
                  ? _getActivePill("Scan")
                  : const Text(
                      "Scan",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _getActivePill(String title) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 12.0,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: use `Offset.zero & size` instead of Rect.largest
    // we need to pass the size to the custom paint widget
    final backgroundPath = Path()..addRect(Rect.largest);

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    // First, draw the background,
    // with a cutout area that is a bit larger than the scan window.
    // Finally, draw the scan window itself.
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}
