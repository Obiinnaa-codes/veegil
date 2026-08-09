import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/account_spacing.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/transaction.dart';
import '../models/transaction_receipt_mode.dart';
import '../utils/transaction_receipt_formatters.dart'
    show TransactionReceiptDetailRow, TransactionReceiptFormatters;
import 'transaction_type_icon.dart';

class TransactionReceiptSuccessSection extends StatelessWidget {
  const TransactionReceiptSuccessSection({
    super.key,
    required this.transaction,
    required this.accentColor,
    required this.titleStyle,
    required this.heroAmountStyle,
    required this.descriptionStyle,
    this.mode = TransactionReceiptMode.success,
    this.iconScaleAnimation,
    this.iconFadeAnimation,
    this.successBackgroundColor,
    this.compact = false,
  });

  final Transaction transaction;
  final Color accentColor;
  final TextStyle titleStyle;
  final TextStyle heroAmountStyle;
  final TextStyle descriptionStyle;
  final TransactionReceiptMode mode;
  final Animation<double>? iconScaleAnimation;
  final Animation<double>? iconFadeAnimation;
  final Color? successBackgroundColor;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final iconSize = compact ? 64.0 : 80.0;
    final typeIconSize = compact ? 40.0 : 48.0;

    Widget heroIcon = TransactionTypeIcon.forTransaction(
      transaction: transaction,
      color: accentColor,
      size: iconSize,
      iconSize: typeIconSize,
    );

    final animatedIcon = iconScaleAnimation != null && iconFadeAnimation != null
        ? FadeTransition(
            opacity: iconFadeAnimation!,
            child: ScaleTransition(
              scale: iconScaleAnimation!,
              child: heroIcon,
            ),
          )
        : heroIcon;

    return Column(
      children: [
        animatedIcon,
        SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
        Text(
          TransactionReceiptFormatters.titleForCategory(
            transaction.category,
            mode: mode,
          ),
          style: titleStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          TransactionReceiptFormatters.heroAmount(transaction),
          style: heroAmountStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          TransactionReceiptFormatters.descriptionForCategory(
            transaction.category,
            mode: mode,
          ),
          style: descriptionStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class TransactionReceiptDetailItem extends StatelessWidget {
  const TransactionReceiptDetailItem({
    super.key,
    required this.row,
    required this.labelStyle,
    required this.valueStyle,
    this.showTooltip = true,
  });

  final TransactionReceiptDetailRow row;
  final TextStyle labelStyle;
  final TextStyle valueStyle;
  final bool showTooltip;

  @override
  Widget build(BuildContext context) {
    final valueWidget = row.isSelectable
        ? _CopyableValue(
            value: row.value,
            valueStyle: valueStyle,
            showTooltip: showTooltip,
          )
        : Text(
            row.value,
            style: valueStyle,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(row.label, style: labelStyle),
        const SizedBox(height: AppSpacing.xs),
        valueWidget,
      ],
    );
  }
}

class TransactionReceiptDetailsCard extends StatelessWidget {
  const TransactionReceiptDetailsCard({
    super.key,
    required this.transaction,
    required this.backgroundColor,
    required this.borderColor,
    required this.dividerColor,
    required this.labelStyle,
    required this.valueStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.padding = const EdgeInsets.all(AccountSpacing.cardPadding),
    this.showTooltip = true,
    this.compact = false,
  });

  final Transaction transaction;
  final Color backgroundColor;
  final Color borderColor;
  final Color dividerColor;
  final TextStyle labelStyle;
  final TextStyle valueStyle;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final bool showTooltip;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final detailRows = TransactionReceiptFormatters.detailRows(transaction);

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < detailRows.length; i++) ...[
            if (i > 0) ...[
              SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
              Divider(
                height: 1,
                thickness: 1,
                color: dividerColor,
              ),
              SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
            ],
            TransactionReceiptDetailItem(
              row: detailRows[i],
              labelStyle: labelStyle,
              valueStyle: valueStyle,
              showTooltip: showTooltip,
            ),
          ],
        ],
      ),
    );
  }
}

class _CopyableValue extends StatelessWidget {
  const _CopyableValue({
    required this.value,
    required this.valueStyle,
    required this.showTooltip,
  });

  final String value;
  final TextStyle valueStyle;
  final bool showTooltip;

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaction ID copied')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final text = Text(
      value,
      style: valueStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    final content = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _copy(context),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Row(
            children: [
              Expanded(child: showTooltip ? Tooltip(message: value, child: text) : text),
              const SizedBox(width: AppSpacing.xs),
              Icon(
                Icons.copy_outlined,
                size: 18,
                color: colors.primary,
              ),
            ],
          ),
        ),
      ),
    );

    return Semantics(
      button: true,
      label: 'Copy transaction ID',
      child: content,
    );
  }
}
