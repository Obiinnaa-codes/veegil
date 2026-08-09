import 'package:flutter/material.dart';

import '../../core/theme/account_spacing.dart';
import '../../core/theme/app_color_extension.dart';
import '../../core/theme/app_motion_extension.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_constants.dart';
import '../../features/transactions/domain/entities/transaction.dart';
import '../../features/transactions/presentation/utils/transaction_colors.dart';
import '../../features/transactions/presentation/utils/transaction_receipt_share.dart';
import '../../features/transactions/presentation/widgets/transaction_receipt_content.dart';
import 'veegil_loading_indicator.dart';

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
            WidgetsBinding.instance.addPostFrameCallback((_) => onDone());
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
  final GlobalKey _shareButtonKey = GlobalKey();
  late final AnimationController _controller;
  late final Animation<double> _iconScaleAnimation;
  late final Animation<double> _iconFadeAnimation;
  late final Animation<Offset> _contentSlideAnimation;
  late final Animation<double> _contentFadeAnimation;
  bool _isSharing = false;

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

  Rect? _sharePositionOrigin() {
    final box =
        _shareButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    return box.localToGlobal(Offset.zero) & box.size;
  }

  Future<void> _handleShareReceipt() async {
    if (_isSharing) return;

    setState(() => _isSharing = true);
    try {
      await TransactionReceiptShare.shareReceipt(
        context: context,
        transaction: widget.transaction,
        sharePositionOrigin: _sharePositionOrigin(),
      );
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.typography;
    final transaction = widget.transaction;
    final accentColor =
        TransactionColors.forCategory(context, transaction.category);

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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AccountSpacing.pagePadding,
                  AppSpacing.md,
                  AccountSpacing.pagePadding,
                  AppSpacing.sm,
                ),
                child: FadeTransition(
                  opacity: _contentFadeAnimation,
                  child: SlideTransition(
                    position: _contentSlideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TransactionReceiptSuccessSection(
                          transaction: transaction,
                          accentColor: accentColor,
                          compact: true,
                          titleStyle: typography.title,
                          heroAmountStyle: typography.display.copyWith(
                            color: accentColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                          descriptionStyle: typography.body.copyWith(
                            color: colors.subtitle,
                          ),
                          iconScaleAnimation: _iconScaleAnimation,
                          iconFadeAnimation: _iconFadeAnimation,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: colors.outlineVariant,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Transaction Details',
                          style: typography.title,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Expanded(
                          child: TransactionReceiptDetailsCard(
                            transaction: transaction,
                            compact: true,
                            backgroundColor: colors.surfaceContainerHigh,
                            borderColor: colors.outlineVariant,
                            dividerColor: colors.outlineVariant,
                            labelStyle: typography.caption,
                            valueStyle: typography.body.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            padding: const EdgeInsets.all(AppSpacing.md),
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
                child: Row(
                  children: [
                    Expanded(
                      child: _ReceiptActionButton(
                        key: _shareButtonKey,
                        label: 'Share Receipt',
                        isOutlined: true,
                        isEnabled: !_isSharing,
                        isLoading: _isSharing,
                        onPressed: _handleShareReceipt,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _ReceiptActionButton(
                        label: 'Done',
                        onPressed: widget.onClose,
                      ),
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

class _ReceiptActionButton extends StatelessWidget {
  const _ReceiptActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isOutlined = false,
    this.isEnabled = true,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final bool isEnabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final canPress = isEnabled && !isLoading;
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final onPrimary = theme.colorScheme.onPrimary;
    final labelStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w600,
    );

    final labelWidget = FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        label,
        maxLines: 1,
        style: labelStyle?.copyWith(
          color: isOutlined ? primary : onPrimary,
        ),
      ),
    );

    final child = isLoading
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VeegilLoadingIndicator.small(
                color: isOutlined ? primary : onPrimary,
              ),
              const SizedBox(width: 8),
              Flexible(child: labelWidget),
            ],
          )
        : labelWidget;

    return SizedBox(
      height: AppConstants.buttonHeight,
      child: isOutlined
          ? OutlinedButton(
              onPressed: canPress ? onPressed : null,
              child: child,
            )
          : FilledButton(
              onPressed: canPress ? onPressed : null,
              child: child,
            ),
    );
  }
}
