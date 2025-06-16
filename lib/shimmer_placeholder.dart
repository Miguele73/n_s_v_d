import 'package:flutter/material.dart';

class ShimmerPlaceholder extends StatefulWidget {
  const ShimmerPlaceholder({Key? key}) : super(key: key);

  @override
  _ShimmerPlaceholderState createState() => _ShimmerPlaceholderState();
}

class _ShimmerPlaceholderState extends State<ShimmerPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildShimmerItem(width: 200, height: 28),
            const SizedBox(height: 16),

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _buildShimmerItem(width: 250, height: 250),
            ),
            const SizedBox(height: 16),

            _buildShimmerItem(width: 150, height: 20),
            const SizedBox(height: 8),

            _buildShimmerItem(width: 250, height: 40),
            const SizedBox(height: 8),

            _buildShimmerItem(width: double.infinity, height: 100),
          ],
        );
      },
    );
  }

  Widget _buildShimmerItem({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [Colors.grey[300]!, Colors.grey[100]!, Colors.grey[300]!],
          stops: const [0.1, 0.3, 0.5],
          begin: Alignment(_animation.value - 0.5, 0.0),
          end: Alignment(_animation.value + 0.5, 0.0),
        ),
      ),
    );
  }
}
