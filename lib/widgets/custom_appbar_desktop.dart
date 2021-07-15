import 'package:flutter/material.dart';
import 'package:prawitama_care_admin/common/utils.dart';
import 'package:prawitama_care_admin/pages/donation_page.dart';
import 'package:prawitama_care_admin/pages/home_page.dart';
import 'package:prawitama_care_admin/pages/report_page.dart';

class CustomAppBarDesktopTablet extends StatefulWidget
    with PreferredSizeWidget {
  @override
  _CustomAppBarDesktopTabletState createState() =>
      _CustomAppBarDesktopTabletState();
  @override
  Size get preferredSize => Size.fromHeight(80);
}

class _CustomAppBarDesktopTabletState extends State<CustomAppBarDesktopTablet> {
  int indexNumber = 0;
  bool isHover = true;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      flexibleSpace: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: defaultPadding,
              horizontal: defaultPadding * 3,
            ),
            child: Image.asset('assets/images/logo.png'),
          ),
          Spacer(),
          InkWell(
            hoverColor: Colors.transparent,
            onHover: (value) {
              setState(() {
                indexNumber = 0;
                isHover = value;
              });
            },
            onTap: () {
              setState(() {
                pageNumber = 0;
              });
              Navigator.pushNamed(context, HomePage.id);
            },
            child: Center(
              child: Text(
                'Beranda',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: (indexNumber == 0 && isHover != false ||
                            pageNumber == 0)
                        ? Colors.black
                        : Colors.grey),
              ),
            ),
          ),
          SizedBox(
            width: defaultPadding * 2,
          ),
          InkWell(
            hoverColor: Colors.transparent,
            onHover: (value) {
              setState(() {
                indexNumber = 1;
                isHover = value;
              });
            },
            onTap: () {
              setState(() {
                pageNumber = 1;
              });
              Navigator.pushNamed(context, Donation.id);
            },
            child: Center(
              child: Text(
                'Donasi',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: (indexNumber == 1 && isHover != false ||
                            pageNumber == 1)
                        ? Colors.black
                        : Colors.grey),
              ),
            ),
          ),
          SizedBox(
            width: defaultPadding * 2,
          ),
          InkWell(
            hoverColor: Colors.transparent,
            onHover: (value) {
              setState(() {
                indexNumber = 2;
                isHover = value;
              });
            },
            onTap: () {
              setState(() {
                pageNumber = 2;
                Navigator.pushNamed(context, ReportPage.id);
              });
            },
            child: Center(
              child: Text(
                'Laporan',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: (indexNumber == 2 && isHover != false ||
                            pageNumber == 2)
                        ? Colors.black
                        : Colors.grey),
              ),
            ),
          ),
          SizedBox(
            width: defaultPadding * 4,
          ),
        ],
      ),
    );
  }
}
