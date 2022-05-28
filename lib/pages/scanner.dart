import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ticcket/widgets/camera_overlay.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
            allowDuplicates: false,
            onDetect: (barcode, args) {
              final String? code = barcode.rawValue;
              debugPrint('Barcode found! $code');
            }),
        QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
      ],
    );
  }
}