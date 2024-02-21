import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';
import 'package:ticket_trove/common/utils/debug_log.dart';
import 'package:ticket_trove/common/utils/string_parser.dart';
import 'package:ticket_trove/features/ticket/models/ticket.dart';

Future<void> printDocument(BuildContext context,
    {required Ticket ticket, required String uid}) async {
  context.canPop() ? context.pop() : null;
  final doc = pw.Document();

  doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.undefined,
      build: (pw.Context context) {
        return pw.Stack(children: [
          pw.Positioned(
              top: -45,
              right: -45,
              child: pw.Container(
                  height: 100,
                  width: 100,
                  decoration: pw.BoxDecoration(
                      shape: pw.BoxShape.circle,
                      color: PdfColor.fromHex("#EEEEEE00")))),
          pw.Positioned(
              bottom: -35,
              left: -45,
              child: pw.Container(
                  height: 100,
                  width: 100,
                  decoration: pw.BoxDecoration(
                      shape: pw.BoxShape.circle,
                      color: PdfColor.fromHex("#CCCCCC11")))),
          content(ticket, uid),
        ]);
      }));
  // showGeneralDialog(
  //   context: context,
  //   pageBuilder: (context, animation, secondaryAnimation) {
  //     return PdfPreview(pdfFileName: "${ticket.createdAt}${ticket.id}", build: (format) => doc.save());
  //   },
  // );

  // await Printing.pickPrinter(context: context).then((value) async {
  //   if (value?.model == null) {
  //     toastMessage(context, data: "No printer fount to connect");
  //     return;
  //   }

  //   await Printing.directPrintPdf(
  //       printer: value!, onLayout: (PdfPageFormat format) async => doc.save());
  // });

  // final printerInfo = await Printing.info();

  // log(printerInfo.toString());

  await Printing.layoutPdf(
      usePrinterSettings: true,
      onLayout: (PdfPageFormat format) async => doc.save());
}

pw.Container content(Ticket ticket, String uid) {
  final String ticketParser =
      jsonEncode(ticket.toJson()..addAll({"userId": uid}));
  debugLog(ticketParser);
  final totalPrice = stringToDoubleParser(ticket.pricePerTicket) *
      stringToDoubleParser(ticket.quantity);
  return pw.Container(
      height: 200,
      width: 190,
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(15),
      ),
      child: pw.Transform(
        transform: Matrix4.rotationZ(0),
        child: pw.Padding(
            padding:
                const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: pw.SizedBox(
                child: pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Text("Ticket",
                    style: pw.TextStyle(
                        fontSize: 50, fontWeight: pw.FontWeight.bold)),
                pw.Text("Quantity ${ticket.quantity}",
                    style: const pw.TextStyle(
                      fontSize: 24,
                    )),
                pw.Text("Rs $totalPrice",
                    style: pw.TextStyle(
                        fontSize: 20, color: PdfColor.fromHex("#222"))),
                pw.Spacer(),
                pw.SizedBox(
                    height: 40,
                    width: 40,
                    child: pw.BarcodeWidget(
                        data: ticketParser,
                        barcode: pw.Barcode.fromType(pw.BarcodeType.QrCode))),
              ],
            ))),
      ));
}
