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
        child: OutlinedButton(
          onPressed: isEnabled ? onPressed : null,
          child: Text(label),
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
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final String? loadingLabel;

  @override
  Widget build(BuildContext context) {
    final canPress = isEnabled && !isLoading;
    final displayLabel = isLoading ? (loadingLabel ?? label) : label;
    final onPrimary = Theme.of(context).colorScheme.onPrimary;

    return Semantics(
      button: true,
      enabled: canPress,
      label: isLoading ? displayLabel : label,
      child: SizedBox(
        width: double.infinity,
        height: AppConstants.buttonHeight,
        child: FilledButton(
          onPressed: canPress ? onPressed : null,
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
    );
  }
}
