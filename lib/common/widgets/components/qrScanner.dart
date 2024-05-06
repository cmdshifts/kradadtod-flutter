import 'package:flutter/material.dart';
import 'package:kradadtod/common/widgets/appBar/commonAppBar.dart';
import 'package:kradadtod/features/scanner/screens/slipDataScreen.dart';
import 'package:kradadtod/utils/constants/colors.dart';
import 'package:kradadtod/utils/constants/sizes.dart';
import 'package:kradadtod/utils/devices/deviceUtility.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;
  bool _navigatedToNewScreen = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (KAppDeviceUtils.isAndroid()) {
      controller!.pauseCamera();
    } else if (KAppDeviceUtils.isIOS()) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
                overlayColor: Colors.white,
                borderRadius: KAppSizes.md,
                borderColor: KAppColors.azure,
                borderLength: KAppSizes.xl,
                borderWidth: 5.0,
                cutOutSize: KAppDeviceUtils.getScreenWidth(context) * 0.6),
          ),
          const CommonAppBar(
            showBackArrow: true,
            title: Text('Add a Slip'),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (result == null && !_navigatedToNewScreen) {
          result = scanData;
          _navigatedToNewScreen = true;
          Navigator.of(context).pushReplacement(
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: SlipDataScreen(slipCode: scanData.code!),
              isIos: KAppDeviceUtils.isIOS(),
            ),
          );
        }
      });
    });
  }
}
