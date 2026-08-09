import 'package:flutter/material.dart';

abstract final class AuthScrollHelper {
  static void scrollToFocusedField(FocusNode focusNode) {
    if (!focusNode.hasFocus) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = focusNode.context;
      if (context == null || !context.mounted) return;

      Scrollable.ensureVisible(
        context,
        alignment: 0.2,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
      );
    });
  }

  static void attachScrollOnFocus(
    FocusNode focusNode,
    VoidCallback onFocus,
  ) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        onFocus();
      }
    });
  }
}
