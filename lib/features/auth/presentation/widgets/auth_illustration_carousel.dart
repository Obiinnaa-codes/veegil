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
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final illustrationHeight = Responsive.authIllustrationHeight(context);
    final assets = AuthAssets.illustrationCarousel;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
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
        const SizedBox(height: AuthSpacing.illustrationToDots),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(assets.length, (index) {
            final isActive = index == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 8 : 6,
              height: isActive ? 8 : 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: 0.25),
              ),
            );
          }),
        ),
      ],
    );
  }
}
