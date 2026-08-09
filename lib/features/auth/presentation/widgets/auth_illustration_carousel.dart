import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/auth_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/auth_spacing.dart';
import '../../../../core/utils/responsive.dart';

class AuthIllustrationCarousel extends StatefulWidget {
  const AuthIllustrationCarousel({super.key});

  @override
  State<AuthIllustrationCarousel> createState() =>
      _AuthIllustrationCarouselState();
}

class _AuthIllustrationCarouselState extends State<AuthIllustrationCarousel> {
  static const _autoAdvanceInterval = Duration(seconds: 4);

  late final PageController _pageController;
  Timer? _autoAdvanceTimer;
  int _currentPage = 0;
  bool _isAutoAdvancePaused = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoAdvance();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncAutoAdvanceWithKeyboard();
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoAdvance() {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = Timer.periodic(_autoAdvanceInterval, (_) {
      if (!mounted || _isAutoAdvancePaused) return;

      final assets = AuthAssets.illustrationCarousel;
      final nextPage = (_currentPage + 1) % assets.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  void _syncAutoAdvanceWithKeyboard() {
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    final shouldPause = keyboardOpen;

    if (shouldPause == _isAutoAdvancePaused) return;

    _isAutoAdvancePaused = shouldPause;
    if (shouldPause) {
      _autoAdvanceTimer?.cancel();
      _autoAdvanceTimer = null;
    } else {
      _startAutoAdvance();
    }
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final illustrationHeight = Responsive.authIllustrationHeight(context);
    final assets = AuthAssets.illustrationCarousel;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          label: 'Authentication illustrations',
          child: ExcludeSemantics(
            child: SizedBox(
              height: illustrationHeight,
              child: PageView.builder(
                controller: _pageController,
                itemCount: assets.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  return Center(
                    child: Lottie.asset(
                      assets[index],
                      fit: BoxFit.contain,
                      repeat: true,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: AuthSpacing.illustrationToDots),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(assets.length, (index) {
            final isActive = index == _currentPage;
            return Semantics(
              button: true,
              selected: isActive,
              label: 'Show illustration ${index + 1} of ${assets.length}',
              child: GestureDetector(
                onTap: () => _goToPage(index),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 8,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isActive ? 8 : 6,
                    height: isActive ? 8 : 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.25),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
