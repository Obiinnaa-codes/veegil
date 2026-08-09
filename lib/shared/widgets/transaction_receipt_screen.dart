import 'package:flutter/material.dart';

import '../../core/theme/account_spacing.dart';
import '../../core/theme/app_color_extension.dart';
import '../../core/theme/app_motion_extension.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_constants.dart';
import '../../features/transactions/domain/entities/transaction.dart';
import '../../features/transactions/presentation/models/transaction_receipt_mode.dart';
import '../../features/transactions/presentation/utils/transaction_colors.dart';
import '../../features/transactions/presentation/utils/transaction_receipt_share.dart';
import '../../features/transactions/presentation/widgets/transaction_receipt_content.dart';
import 'veegil_loading_indicator.dart';

Future<void> showTransactionReceipt({
  required BuildContext context,
  required Transaction transaction,
  required VoidCallback onDone,
  TransactionReceiptMode mode = TransactionReceiptMode.success,
}) {
  return Navigator.of(context).push<void>(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (screenContext) {
        return TransactionReceiptScreen(
          transaction: transaction,
          mode: mode,
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
    this.mode = TransactionReceiptMode.success,
  });

  final Transaction transaction;
  final VoidCallback onClose;
  final TransactionReceiptMode mode;

  @override
  State<TransactionReceiptScreen> createState() =>
      _TransactionReceiptScreenState();
}

class _TransactionReceiptScreenState extends State<TransactionReceiptScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey _shareButtonKey = GlobalKey();
  AnimationController? _controller;
  Animation<double>? _iconScaleAnimation;
  Animation<double>? _iconFadeAnimation;
  Animation<Offset>? _contentSlideAnimation;
  Animation<double>? _contentFadeAnimation;
  bool _isSharing = false;

  bool get _isSuccessMode => widget.mode == TransactionReceiptMode.success;

  String get _doneLabel =>
      _isSuccessMode ? 'Done' : 'Close';

  @override
  void initState() {
    super.initState();
    if (!_isSuccessMode) return;

    final motion = AppMotionExtension.expressive;
    _controller = AnimationController(
      vsync: this,
      duration: motion.mediumDuration,
    );

    _iconScaleAnimation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeOutBack,
    );
    _iconFadeAnimation = CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0, 0.6, curve: Curves.easeOut),
    );
    _contentSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(0.2, 1, curve: Curves.easeOutCubic),
      ),
    );
    _contentFadeAnimation = CurvedAnimation(
      parent: _controller!,
      curve: const Interval(0.2, 1, curve: Curves.easeOut),
    );

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
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

  Widget _buildBodyContent({
    required BuildContext context,
    required Transaction transaction,
    required Color accentColor,
    required TextStyle titleStyle,
    required TextStyle heroAmountStyle,
    required TextStyle descriptionStyle,
    required TextStyle labelStyle,
    required TextStyle valueStyle,
    required Color backgroundColor,
    required Color borderColor,
    required Color dividerColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TransactionReceiptSuccessSection(
          transaction: transaction,
          accentColor: accentColor,
          mode: widget.mode,
          compact: true,
          titleStyle: titleStyle,
          heroAmountStyle: heroAmountStyle,
          descriptionStyle: descriptionStyle,
          iconScaleAnimation: _iconScaleAnimation,
          iconFadeAnimation: _iconFadeAnimation,
        ),
        const SizedBox(height: AppSpacing.md),
        Divider(
          height: 1,
          thickness: 1,
          color: dividerColor,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Transaction Details',
          style: titleStyle,
        ),
        const SizedBox(height: AppSpacing.sm),
        TransactionReceiptDetailsCard(
          transaction: transaction,
          compact: true,
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          dividerColor: dividerColor,
          labelStyle: labelStyle,
          valueStyle: valueStyle,
          padding: const EdgeInsets.all(AppSpacing.md),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final typography = context.typography;
    final transaction = widget.transaction;
    final accentColor =
        TransactionColors.forCategory(context, transaction.category);

    final bodyContent = _buildBodyContent(
      context: context,
      transaction: transaction,
      accentColor: accentColor,
      titleStyle: typography.title,
      heroAmountStyle: typography.display.copyWith(
        color: accentColor,
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      descriptionStyle: typography.body.copyWith(
        color: colors.subtitle,
      ),
      labelStyle: typography.caption,
      valueStyle: typography.body.copyWith(
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: colors.surfaceContainerHigh,
      borderColor: colors.outlineVariant,
      dividerColor: colors.outlineVariant,
    );

    final scrollableBody = SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AccountSpacing.pagePadding,
        AppSpacing.md,
        AccountSpacing.pagePadding,
        AppSpacing.sm,
      ),
      child: _isSuccessMode && _contentFadeAnimation != null
          ? FadeTransition(
              opacity: _contentFadeAnimation!,
              child: SlideTransition(
                position: _contentSlideAnimation!,
                child: bodyContent,
              ),
            )
          : bodyContent,
    );

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
            Expanded(child: scrollableBody),
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
                        label: _doneLabel,
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
