import 'package:flutter/material.dart';
import 'package:prawitama_care_admin/common/utils.dart';

class CustomAppBarMobile extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Container(
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
      title: Text(
        "Prawitama Care",
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
