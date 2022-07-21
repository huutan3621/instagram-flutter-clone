import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/dimensions.dart';

//the responsive layout class
class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > webScreenSize) {
          //web screen
          return webScreenLayout;
        }
        //mobile screen
        return mobileScreenLayout;
      },
    );
  }
}
