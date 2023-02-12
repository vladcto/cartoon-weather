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
  late Animation _circleAnimation;
  late AnimationController _animationController;
  bool value = false;

  @override
  void initState() {
    super.initState();
    value = widget.startValue;
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    _animationController.value = value ? 1 : 0;
    _circleAnimation = AlignmentTween(
            begin: Alignment.centerRight, end: Alignment.centerLeft)
        .animate(
            CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            value ? _animationController.reverse() : _animationController.forward();
            value = !value;
            value ? widget.onChanged(true) : widget.onChanged(false);
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
                Positioned(right: 4, top: 0, bottom: 0, child: widget.activeChild),
                Positioned(left: 4, top: 0, bottom: 0, child: widget.inactiveChild),
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
                            )))),
              ],
            ),
          ),
        );
      },
    );
  }
}
