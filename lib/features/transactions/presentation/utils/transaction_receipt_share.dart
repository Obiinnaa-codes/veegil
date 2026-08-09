import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/entities/transaction.dart';
import '../widgets/transaction_receipt_image.dart';
import 'transaction_receipt_image_generator.dart';
import 'transaction_receipt_image_theme.dart';

abstract final class TransactionReceiptShare {
  static String filenameFor(Transaction transaction) {
    final id = transaction.id.trim().replaceAll(RegExp(r'[^\w\-.]'), '_');
    if (id.isEmpty) {
      return 'veegil_transaction_receipt.png';
    }
    return 'veegil_transaction_$id.png';
  }

  static Future<void> shareReceipt({
    required BuildContext context,
    required Transaction transaction,
    Rect? sharePositionOrigin,
  }) async {
    final Uint8List bytes;
    try {
      final brightness = Theme.of(context).brightness;
      final theme = TransactionReceiptImageTheme.fromBrightness(brightness);
      final receiptWidget = TransactionReceiptImage(
        transaction: transaction,
        theme: theme,
      );

      bytes = await TransactionReceiptImageGenerator.generate(
        context: context,
        receiptWidget: receiptWidget,
      );

      if (bytes.isEmpty) {
        throw StateError('Receipt image was empty.');
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('Receipt image generation failed: $error\n$stackTrace');
      }
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to create receipt\nPlease try again.'),
        ),
      );
      return;
    }

    try {
      final filename = filenameFor(transaction);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$filename');
      await file.writeAsBytes(bytes, flush: true);

      if (!file.existsSync()) {
        throw StateError('Receipt file was not saved.');
      }

      await Share.shareXFiles(
        [
          XFile(
            file.path,
            mimeType: 'image/png',
            name: filename,
          ),
        ],
        sharePositionOrigin: sharePositionOrigin,
      );
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('Receipt share failed: $error\n$stackTrace');
      }
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to share receipt\nPlease try again.'),
        ),
      );
    }
  }
}
