import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import 'veegil_loading_indicator.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: isEnabled,
      label: label,
      child: SizedBox(
        width: double.infinity,
        height: AppConstants.buttonHeight,
        child: FilledButton(
          onPressed: isEnabled ? onPressed : null,
          child: Text(label),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final canPress = isEnabled && !isLoading;
    final primary = Theme.of(context).colorScheme.primary;

    return Semantics(
      button: true,
      enabled: canPress,
      label: label,
      child: SizedBox(
        width: double.infinity,
        height: AppConstants.buttonHeight,
        child: OutlinedButton(
          onPressed: canPress ? onPressed : null,
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    VeegilLoadingIndicator.small(color: primary),
                    const SizedBox(width: 12),
                    Text(label),
                  ],
                )
              : Text(label),
        ),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.loadingLabel,
    this.disabledHelper,
    this.onInvalidTap,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final String? loadingLabel;
  final String? disabledHelper;
  final VoidCallback? onInvalidTap;

  @override
  Widget build(BuildContext context) {
    final canPress = isEnabled && !isLoading;
    final displayLabel = isLoading ? (loadingLabel ?? label) : label;
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          button: true,
          enabled: !isLoading,
          label: isLoading ? displayLabel : label,
          child: SizedBox(
            width: double.infinity,
            height: AppConstants.buttonHeight,
            child: FilledButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (!isEnabled) {
                        onInvalidTap?.call();
                        return;
                      }
                      onPressed?.call();
                    },
              style: FilledButton.styleFrom(
                backgroundColor: canPress ? null : colorScheme.primary.withValues(alpha: 0.45),
                foregroundColor: onPrimary,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isLoading
                    ? Row(
                        key: const ValueKey('loading'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          VeegilLoadingIndicator.small(
                            color: onPrimary,
                          ),
                          const SizedBox(width: 12),
                          Text(displayLabel),
                        ],
                      )
                    : Text(
                        label,
                        key: const ValueKey('label'),
                      ),
              ),
            ),
          ),
        ),
        if (!canPress && disabledHelper != null) ...[
          const SizedBox(height: 8),
          Text(
            disabledHelper!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ],
    );
  }
}
