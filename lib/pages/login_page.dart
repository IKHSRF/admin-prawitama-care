import 'package:flutter/material.dart';
import 'package:prawitama_care_admin/common/utils.dart';
import 'package:prawitama_care_admin/widgets/custom_appbar_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatelessWidget {
  static const String id = '/login';
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          appBar:
              (sizingInformation.isMobile) ? null : CustomAppBarDesktopTablet(),
          body: Center(
            child: Container(
              margin: EdgeInsets.only(top: defaultPadding * 2),
              padding: EdgeInsets.all(defaultPadding * 6),
              width: 500,
              height: 460,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 23,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "MASUK KE AKUN ANDA",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: defaultPadding * 6),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Alamat Email',
                    ),
                  ),
                  SizedBox(height: defaultPadding * 4),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(height: defaultPadding * 4),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(buttonColor),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(defaultPadding * 2),
                      alignment: Alignment.center,
                      child: Text(
                        "MASUK",
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: defaultPadding * 4),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'SMK Wikrama Bogor',
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
