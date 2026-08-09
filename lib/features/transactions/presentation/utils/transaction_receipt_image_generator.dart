import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class TransactionReceiptImageGenerator {
  static const double pixelRatio = 3.0;

  static Future<Uint8List> generate({
    required BuildContext context,
    required Widget receiptWidget,
    double imagePixelRatio = pixelRatio,
  }) async {
    final overlayState = Overlay.of(context, rootOverlay: true);
    final repaintKey = GlobalKey();
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (overlayContext) {
        return Positioned(
          left: 0,
          top: 0,
          child: Opacity(
            opacity: 0.01,
            child: Material(
              type: MaterialType.transparency,
              child: RepaintBoundary(
                key: repaintKey,
                child: receiptWidget,
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(entry);

    try {
      await GoogleFonts.pendingFonts();
      for (var i = 0; i < 3; i++) {
        await SchedulerBinding.instance.endOfFrame;
      }

      final boundary = repaintKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;

      if (boundary == null) {
        throw StateError('Receipt render boundary was not available.');
      }

      if (!boundary.hasSize || boundary.size.isEmpty) {
        throw StateError('Receipt layout was not ready.');
      }

      final image = await boundary.toImage(pixelRatio: imagePixelRatio);
      try {
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData == null) {
          throw StateError('Failed to encode receipt image.');
        }
        return byteData.buffer.asUint8List();
      } finally {
        image.dispose();
      }
    } finally {
      entry.remove();
    }
  }
}
