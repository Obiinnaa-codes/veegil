import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/widgets/primary_card_background.dart';
import 'dashboard_shimmer.dart';

class BalanceCard extends StatefulWidget {
  const BalanceCard({
    super.key,
    required this.balance,
    required this.isLoading,
    this.errorMessage,
    this.onRetry,
  });

  final double? balance;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool _isBalanceVisible = true;
  double _displayedBalance = 0;

  @override
  void didUpdateWidget(BalanceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.balance != null && widget.balance != oldWidget.balance) {
      _displayedBalance = widget.balance!;
    }
  }

  @override
  void initState() {
    super.initState();
    _displayedBalance = widget.balance ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading && widget.balance == null) {
      return ShimmerBox(
        width: double.infinity,
        height: 140,
        borderRadius: AppConstants.cardBorderRadius,
      );
    }

    final typography = context.typography;

    return PrimaryCardBackground(
      borderRadius: AppConstants.cardBorderRadius,
      child: Padding(
        padding: const EdgeInsets.all(DashboardSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Available Balance',
                    style: typography.caption.copyWith(
                      color: AppColors.onPrimary.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => _isBalanceVisible = !_isBalanceVisible);
                  },
                  icon: Icon(
                    _isBalanceVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.onPrimary,
                  ),
                  tooltip: _isBalanceVisible ? 'Hide balance' : 'Show balance',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            if (widget.errorMessage != null && widget.balance == null)
              _ErrorContent(
                message: widget.errorMessage!,
                onRetry: widget.onRetry,
              )
            else
              TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: _displayedBalance,
                  end: widget.balance ?? _displayedBalance,
                ),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                onEnd: () {
                  if (widget.balance != null) {
                    _displayedBalance = widget.balance!;
                  }
                },
                builder: (context, value, child) {
                  final displayText = _isBalanceVisible
                      ? CurrencyFormatter.format(value)
                      : '••••••';

                  return Text(
                    displayText,
                    style: typography.display.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  );
                },
              ),
            if (widget.errorMessage != null && widget.balance != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                widget.errorMessage!,
                style: typography.label.copyWith(
                  color: AppColors.secondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  const _ErrorContent({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: typography.body.copyWith(color: AppColors.onPrimary),
        ),
        if (onRetry != null) ...[
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.secondary,
            ),
            child: const Text('Retry'),
          ),
        ],
      ],
    );
  }
}
