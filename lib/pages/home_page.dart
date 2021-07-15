import 'package:flutter/material.dart';
import 'package:prawitama_care_admin/services/firestore_services.dart';
import 'package:prawitama_care_admin/widgets/custom_appbar_desktop.dart';
import 'package:prawitama_care_admin/widgets/custom_appbar_mobile.dart';
import 'package:prawitama_care_admin/widgets/custom_bottomNav.dart';
import 'package:prawitama_care_admin/widgets/program_card.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatelessWidget {
  static const String id = '/';
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          appBar: (sizingInformation.isMobile)
              ? CustomAppBarMobile()
              : CustomAppBarDesktopTablet(),
          body: SizedBox.expand(
            child: StreamBuilder(
              stream: FirestoreServices.getDonationProgram(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      children: snapshot.data.docs.map<Widget>((program) {
                        return ProgramCard(
                          programName: program['programName'],
                          programDetail: program['programDetail'],
                          totalFunds: program['totalFunds'].toString(),
                          fundRaised: program['fundRaised'].toString(),
                          programImagePath: program['programImagePath'],
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar:
              (sizingInformation.isMobile) ? CustomBottomNavBar() : null,
        );
      },
    );
  }
}
