import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> downloadCV() async {
  try {
    final byteData = await rootBundle.load('assets/cv/bhomaram_flutter_resume.pdf');
    final bytes = byteData.buffer.asUint8List();

    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'Bhoma_Ram_CV.pdf')
      ..click();

    html.Url.revokeObjectUrl(url);
  } catch (e) {
    debugPrint('CV download failed: $e');
  }
}