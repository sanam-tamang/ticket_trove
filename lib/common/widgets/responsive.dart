import 'package:flutter/material.dart';

class AutoResponsive extends StatefulWidget {
  const AutoResponsive({super.key, required this.child});
  final Widget child;
  @override
  State<AutoResponsive> createState() => _AutoResponsiveState();
}

class _AutoResponsiveState extends State<AutoResponsive> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (width > 1400) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 400),
            child: widget.child,
          );
        } else if (width > 1000) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 300),
            child: widget.child,
          );
        } else if (width > 800) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
            child: widget.child,
          );
        } else if (width > 600) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: widget.child,
          );
        } else {
          return widget.child;
        }
      },
    );
  }
}
