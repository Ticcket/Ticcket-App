import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ticcket/widgets/camera_overlay.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {

  MobileScannerController cameraController = new MobileScannerController();

  String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.grey,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
          const SizedBox(width: 20)
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
              controller: cameraController,
              allowDuplicates: false,
              onDetect: (barcode, args) {
                final String? code = barcode.rawValue;
                // debugPrint('Barcode found! $code');
                setState(() {
                  text = code;
                });
              }),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
          Center(child: Text(text ?? "", style: TextStyle(fontSize: 15, color: Colors.white),))
        ],
      ),
    );
  }
}