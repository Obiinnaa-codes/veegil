import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/auth_spacing.dart';
import '../../core/theme/app_typography.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.value,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.obscureText = false,
    this.showVisibilityToggle = false,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
  });

  final String label;
  final String? hint;
  final String? value;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final bool showVisibilityToggle;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController _controller;
  late bool _obscureText;
  bool _isInternalUpdate = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
    _obscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != _controller.text) {
      _isInternalUpdate = true;
      _controller.text = widget.value ?? '';
      _controller.selection = TextSelection.collapsed(
        offset: _controller.text.length,
      );
      _isInternalUpdate = false;
    }
    if (widget.obscureText != oldWidget.obscureText &&
        !widget.showVisibilityToggle) {
      _obscureText = widget.obscureText;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final hasError = widget.errorText != null;
    final borderRadius =
        BorderRadius.circular(AppConstants.inputBorderRadius);

    return Semantics(
      textField: true,
      label: widget.label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: typography.label.copyWith(color: AppColors.text),
          ),
          const SizedBox(height: AuthSpacing.labelToField),
          Container(
            height: AppConstants.textFieldHeight,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.inputShadow,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: _controller,
              focusNode: widget.focusNode,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              autofillHints: widget.autofillHints,
              obscureText: _obscureText,
              inputFormatters: widget.inputFormatters,
              onChanged: (value) {
                if (!_isInternalUpdate) {
                  widget.onChanged?.call(value);
                }
              },
              onFieldSubmitted: widget.onSubmitted,
              decoration: InputDecoration(
                hintText: widget.hint,
                filled: true,
                fillColor: AppColors.background,
                enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(
                    color: hasError ? AppColors.error : AppColors.border,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(
                    color: hasError ? AppColors.error : AppColors.primary,
                    width: 1.5,
                  ),
                ),
                suffixIcon: widget.showVisibilityToggle
                    ? Semantics(
                        button: true,
                        label:
                            _obscureText ? 'Show password' : 'Hide password',
                        child: IconButton(
                          onPressed: _toggleVisibility,
                          iconSize: 20,
                          constraints: const BoxConstraints(
                            minWidth: AppConstants.minTouchTarget,
                            minHeight: AppConstants.minTouchTarget,
                          ),
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              key: ValueKey(_obscureText),
                              color: AppColors.subtitle,
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            alignment: Alignment.topLeft,
            child: hasError
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Semantics(
                      label: widget.errorText,
                      child: Text(
                        widget.errorText!,
                        style:
                            typography.label.copyWith(color: AppColors.error),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
