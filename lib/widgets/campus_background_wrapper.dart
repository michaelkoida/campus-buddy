// lib/widgets/campus_background_wrapper.dart
import 'package:flutter/material.dart';

class CampusBackgroundWrapper extends StatelessWidget {
  final Widget screenContent;
  const CampusBackgroundWrapper({super.key, required this.screenContent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.04, 
          child: Center(child: Image.asset("assets/rsu_logo.png", width: MediaQuery.of(context).size.width * 0.8, fit: BoxFit.contain, errorBuilder: (c,e,s) => const SizedBox())),
        ),
        screenContent,
      ],
    );
  }
}
