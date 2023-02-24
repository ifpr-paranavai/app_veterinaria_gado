import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FloatingButton extends StatefulWidget {
  final Color? backgroundColor;
  final IconData? icon;
  final VoidCallback? onPressed;

  const FloatingButton({
    Key? key,
    this.icon,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  var _icon;
  var _function;
  var _color;

  @override
  void initState() {
    super.initState();
    if (widget.icon == null) {
      _icon = Icons.add;
    } else {
      _icon = widget.icon;
    }
    if (widget.onPressed == null) {
      _function = () {};
    } else {
      _function = widget.onPressed;
    }
    if (widget.backgroundColor == null) {
      _color = Color.fromARGB(255, 72, 27, 155);
    } else {
      _color = widget.backgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.onPressed,
      child: Icon(_icon),
      backgroundColor: widget.backgroundColor,
    );
  }
}
