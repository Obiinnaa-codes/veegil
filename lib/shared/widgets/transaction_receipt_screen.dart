import 'package:flutter/material.dart';

import '../../core/theme/account_spacing.dart';
import '../../core/theme/app_color_extension.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_motion_extension.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../features/transactions/domain/entities/transaction.dart';
import '../../features/transactions/presentation/utils/transaction_receipt_formatters.dart';
import '../../features/transactions/presentation/utils/transaction_receipt_share.dart';
import '../../features/transactions/presentation/utils/transaction_colors.dart';
import 'app_surface_card.dart';
import 'primary_button.dart';

Future<void> showTransactionReceipt({
  required BuildContext context,
  required Transaction transaction,
  required VoidCallback onDone,
}) {
  return Navigator.of(context).push<void>(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (screenContext) {
        return TransactionReceiptScreen(
          transaction: transaction,
          onClose: () {
            Navigator.of(screenContext).pop();
            onDone();
          },
        );
      },
    ),
  );
}

class TransactionReceiptScreen extends StatefulWidget {
  const TransactionReceiptScreen({
    super.key,
    required this.transaction,
    required this.onClose,
  });

  final Transaction transaction;
  final VoidCallback onClose;

  @override
  State<TransactionReceiptScreen> createState() =>
      _TransactionReceiptScreenState();
}

class _TransactionReceiptScreenState extends State<TransactionReceiptScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _iconScaleAnimation;
  late final Animation<double> _iconFadeAnimation;
  late final Animation<Offset> _contentSlideAnimation;
  late final Animation<double> _contentFadeAnimation;

  @override
  void initState() {
    super.initState();
    final motion = AppMotionExtension.expressive;
    _controller = AnimationController(
      vsync: this,
      duration: motion.mediumDuration,
    );

    _iconScaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _iconFadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.6, curve: Curves.easeOut),
    );
    _contentSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1, curve: Curves.easeOutCubic),
      ),
    );
    _contentFadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 1, curve: Curves.easeOut),
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
    final colors = context.appColors;
    final typography = context.typography;
    final transaction = widget.transaction;
    final accentColor =
        TransactionColors.forCategory(context, transaction.category);
    final detailRows = TransactionReceiptFormatters.detailRows(transaction);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) widget.onClose();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: widget.onClose),
          title: const Text('Transaction Receipt'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AccountSpacing.pagePadding,
                  AppSpacing.lg,
                  AccountSpacing.pagePadding,
                  AppSpacing.md,
                ),
                child: FadeTransition(
                  opacity: _contentFadeAnimation,
                  child: SlideTransition(
                    position: _contentSlideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _SuccessSection(
                          transaction: transaction,
                          accentColor: accentColor,
                          iconScaleAnimation: _iconScaleAnimation,
                          iconFadeAnimation: _iconFadeAnimation,
                        ),
                        const SizedBox(height: AccountSpacing.sectionGap),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: colors.outlineVariant,
                        ),
                        const SizedBox(height: AccountSpacing.sectionGap),
                        Text(
                          'Transaction Details',
                          style: typography.title,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppSurfaceCard(
                          padding: const EdgeInsets.all(
                            AccountSpacing.cardPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (var i = 0; i < detailRows.length; i++) ...[
                                if (i > 0) ...[
                                  const SizedBox(height: AppSpacing.md),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: colors.outlineVariant,
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                ],
                                _ReceiptDetailRow(row: detailRows[i]),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  AccountSpacing.pagePadding,
                  AppSpacing.md,
                  AccountSpacing.pagePadding,
                  AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: colors.surface,
                  border: Border(
                    top: BorderSide(color: colors.outlineVariant),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SecondaryButton(
                      label: 'Share Receipt',
                      onPressed: () => TransactionReceiptShare.shareReceipt(
                        context: context,
                        transaction: transaction,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    PrimaryButton(
                      label: 'Done',
                      onPressed: widget.onClose,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessSection extends StatelessWidget {
  const _SuccessSection({
    required this.transaction,
    required this.accentColor,
    required this.iconScaleAnimation,
    required this.iconFadeAnimation,
  });

  final Transaction transaction;
  final Color accentColor;
  final Animation<double> iconScaleAnimation;
  final Animation<double> iconFadeAnimation;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;

    return Column(
      children: [
        FadeTransition(
          opacity: iconFadeAnimation,
          child: ScaleTransition(
            scale: iconScaleAnimation,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppColors.success,
                size: 44,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          TransactionReceiptFormatters.titleForCategory(transaction.category),
          style: typography.title,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          TransactionReceiptFormatters.heroAmount(transaction),
          style: typography.display.copyWith(
            color: accentColor,
            fontSize: 36,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          TransactionReceiptFormatters.descriptionForCategory(
            transaction.category,
          ),
          style: typography.body.copyWith(color: colors.subtitle),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ReceiptDetailRow extends StatelessWidget {
  const _ReceiptDetailRow({required this.row});

  final TransactionReceiptDetailRow row;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final valueStyle = typography.body.copyWith(fontWeight: FontWeight.w500);

    final valueWidget = row.isSelectable
        ? Tooltip(
            message: row.value,
            child: Text(
              row.value,
              style: valueStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        : Text(
            row.value,
            style: valueStyle,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(row.label, style: typography.caption),
        const SizedBox(height: AppSpacing.xs),
        valueWidget,
      ],
    );
  }
}
