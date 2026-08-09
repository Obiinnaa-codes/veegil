import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'veegil_loading_indicator.dart';

/// Pull-to-refresh wrapper that uses the M3 expressive loading indicator.
class VeegilRefreshIndicator extends StatefulWidget {
  const VeegilRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    this.displacement = 40,
    this.edgeOffset = 0,
    this.color,
    this.notificationPredicate = defaultScrollNotificationPredicate,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final double displacement;
  final double edgeOffset;
  final Color? color;
  final ScrollNotificationPredicate notificationPredicate;

  @override
  State<VeegilRefreshIndicator> createState() => _VeegilRefreshIndicatorState();
}

class _VeegilRefreshIndicatorState extends State<VeegilRefreshIndicator> {
  RefreshIndicatorStatus? _status;

  bool get _isVisible =>
      _status == RefreshIndicatorStatus.refresh ||
      _status == RefreshIndicatorStatus.snap;

  @override
  Widget build(BuildContext context) {
    final indicatorColor = widget.color ?? AppColors.primary;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        RefreshIndicator.noSpinner(
          onRefresh: widget.onRefresh,
          onStatusChange: (status) {
            if (_status != status) {
              setState(() => _status = status);
            }
          },
          notificationPredicate: widget.notificationPredicate,
          child: widget.child,
        ),
        if (_isVisible)
          Positioned(
            top: widget.edgeOffset,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Padding(
                padding: EdgeInsets.only(top: widget.displacement),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: VeegilLoadingIndicator(
                    size: 32,
                    color: indicatorColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
