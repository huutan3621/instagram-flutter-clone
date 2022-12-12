import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/dimensions.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

//the responsive layout class
class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    //LayoutBuilder widget works as a Builder widget but except it can shrinks the size
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > webScreenSize) {
          //web screen
          return widget.webScreenLayout;
        }
        //mobile screen
        return widget.mobileScreenLayout;
      },
    );
  }
}
