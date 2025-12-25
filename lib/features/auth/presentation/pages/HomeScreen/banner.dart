import 'dart:async';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  final List<String> imageUrls;
  final double height;
  final Duration autoSlideDuration;

  const BannerSlider({
    super.key,
    required this.imageUrls,
    this.height = 180,
    this.autoSlideDuration = const Duration(seconds: 5),
  });

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  late PageController _pageController;
  Timer? _timer;

  // 🔑 Big index for infinite forward scroll
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.imageUrls.length * 1000;
    _pageController = PageController(initialPage: _currentIndex);

    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(widget.autoSlideDuration, (_) {
      if (_pageController.hasClients) {
        _currentIndex++;

        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int indicatorIndex =
        _currentIndex % widget.imageUrls.length;

    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final int realIndex =
                  index % widget.imageUrls.length;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    widget.imageUrls[realIndex],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        // 🔘 Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.imageUrls.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: indicatorIndex == index ? 18 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: indicatorIndex == index
                    ? Colors.indigo
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
