import 'package:flutter/material.dart';
import 'package:kradadtod/common/widgets/appBar/commonAppBar.dart';
import 'package:kradadtod/common/widgets/components/qrScanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final qrKey = GlobalKey(debugLabel: "QR");

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CommonAppBar(
            showBackArrow: true,
            title: Text("QR Code"),
          ),
          QRScanner(),
        ],
      ),
    );
  }
}
