import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<String> scanQR() async {
  String barcodeScanRes;
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
    if (barcodeScanRes == "-1") {
      throw "Cancel by user";
    }
  } on PlatformException {
    rethrow;
  }

  return barcodeScanRes;
}
