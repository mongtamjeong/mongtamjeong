import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'start.dart';
import 'dart:async';


class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/images/grandpa.svg',
          width: 243,
          height: 332,
        ),
      )
    );
  }
}
