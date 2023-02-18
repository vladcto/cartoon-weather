import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool startValue;
  final double width;
  final double height;
  final int duration;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Widget activeChild;
  final Widget inactiveChild;

  const CustomSwitch({
    Key? key,
    required this.onChanged,
    this.startValue = false,
    this.width = 75,
    this.height = 30,
    this.duration = 160,
    this.activeColor = Colors.pink,
    this.inactiveColor = Colors.yellow,
    this.activeChild = const SizedBox.shrink(),
    this.inactiveChild = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  static const double startScale = .1;
  static const double endScale = 1.0;

  // 0 - when false value, 1 - true value.
  late AnimationController _animationController;
  late Animation _circleAnimation;
  late Animation _rotateActiveAnimation;
  bool value = false;

  @override
  void initState() {
    super.initState();
    value = widget.startValue;
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    _animationController.value = value ? 1 : 0;
    _circleAnimation = AlignmentTween(
            begin: Alignment.centerLeft, end: Alignment.centerRight)
        .animate(
            CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _rotateActiveAnimation = Tween<double>(begin: startScale, end: endScale).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            value = !value;
            value ? _animationController.forward() : _animationController.reverse();
            widget.onChanged(value);
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color.lerp(widget.activeColor, widget.inactiveColor,
                    _animationController.value)),
            child: Stack(
              children: [
                Positioned(
                  right: 4,
                  top: 0,
                  bottom: 0,
                  child: Transform.scale(
                      scale: (startScale + endScale) - _rotateActiveAnimation.value,
                      child: widget.activeChild),
                ),
                Positioned(
                  left: 4,
                  top: 0,
                  bottom: 0,
                  child: Transform.scale(
                      scale: _rotateActiveAnimation.value,
                      child: widget.inactiveChild),
                ),
                // slider
                Positioned(
                  top: 4,
                  right: 4,
                  bottom: 4,
                  left: 4,
                  child: Align(
                    alignment: _circleAnimation.value,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
