import 'package:flutter/material.dart';

import '../../core/theme/app_color_extension.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'primary_button.dart';

class OperationSuccessDetail {
  const OperationSuccessDetail({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
}

Future<void> showOperationSuccessDialog({
  required BuildContext context,
  required String title,
  String? message,
  List<OperationSuccessDetail>? details,
  required VoidCallback onDone,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return OperationSuccessDialog(
        title: title,
        message: message,
        details: details,
        onDone: () {
          Navigator.of(dialogContext).pop();
          onDone();
        },
      );
    },
  );
}

class OperationSuccessDialog extends StatefulWidget {
  const OperationSuccessDialog({
    super.key,
    required this.title,
    this.message,
    this.details,
    required this.onDone,
  });

  final String title;
  final String? message;
  final List<OperationSuccessDetail>? details;
  final VoidCallback onDone;

  @override
  State<OperationSuccessDialog> createState() => _OperationSuccessDialogState();
}

class _OperationSuccessDialogState extends State<OperationSuccessDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;
    final hasMessage =
        widget.message != null && widget.message!.isNotEmpty;
    final hasDetails = widget.details != null && widget.details!.isNotEmpty;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: AppColors.success,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                widget.title,
                style: typography.title,
                textAlign: TextAlign.center,
              ),
              if (hasMessage) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  widget.message!,
                  style: typography.body.copyWith(color: colors.subtitle),
                  textAlign: TextAlign.center,
                ),
              ],
              if (hasDetails) ...[
                const SizedBox(height: AppSpacing.md),
                ...widget.details!.map((detail) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            detail.label,
                            style: typography.body
                                .copyWith(color: colors.subtitle),
                          ),
                          Text(
                            detail.value,
                            style: typography.label,
                          ),
                        ],
                      ),
                    )),
              ],
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                label: 'Done',
                onPressed: widget.onDone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
