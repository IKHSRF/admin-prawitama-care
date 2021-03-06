import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prawitama_care_admin/common/utils.dart';
import 'package:prawitama_care_admin/pages/edit_page.dart';
import 'package:prawitama_care_admin/providers/donation_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProgramCard extends StatefulWidget {
  const ProgramCard({
    Key? key,
    this.page = false,
    required this.id,
    required this.programName,
    required this.programDetail,
    required this.totalFunds,
    required this.fundRaised,
    required this.programImagePath,
  }) : super(key: key);

  final bool page;
  final String? id;
  final String? programName;
  final String? programDetail;
  final String totalFunds;
  final String fundRaised;
  final String? programImagePath;

  @override
  _ProgramCardState createState() => _ProgramCardState();
}

class _ProgramCardState extends State<ProgramCard> {
  String _formatNumber(String number) =>
      NumberFormat.decimalPattern('id').format(int.parse(number));
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    final donationProvider = Provider.of<DonationProvider>(context);

    return InkWell(
      onTap: () {},
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          TextStyle titleTextStyle = (sizingInformation.isMobile)
              ? Theme.of(context).textTheme.bodyText2!
              : Theme.of(context).textTheme.bodyText1!;
          TextStyle? subtitleTextStyle = (sizingInformation.isMobile)
              ? Theme.of(context).textTheme.overline
              : Theme.of(context).textTheme.subtitle2;
          return AnimatedContainer(
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.all(defaultPadding * 2),
            width: 300,
            height: 550,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                if (isHover || sizingInformation.isMobile)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 23,
                    offset: Offset(1, 1),
                  )
              ],
            ),
            child: Column(
              children: [
                Image.network(
                  widget.programImagePath!,
                  width: 300,
                  height: 250,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    defaultPadding * 2,
                    defaultPadding * 2,
                    defaultPadding * 2,
                    0,
                  ),
                  child: Text(
                    widget.programName!,
                    style: titleTextStyle.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding * 2,
                  ),
                  child: Text(
                    widget.programDetail!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 2,
                    vertical: defaultPadding * 2,
                  ),
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.black,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Dana Terkumpul",
                        style: subtitleTextStyle,
                      ),
                      Text(
                        _formatNumber(widget.fundRaised),
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 500,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(5),
                            child: AnimatedContainer(
                              height: 10,
                              width: 500 * (num.parse(widget.fundRaised) as double),
                              duration: Duration(microseconds: 500),
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Rp ${widget.fundRaised} dari Rp ${_formatNumber(widget.totalFunds)}",
                          style: subtitleTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
                (widget.page == false)
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: PopupMenuButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.dehaze),
                          ),
                          onSelected: (dynamic value) {
                            if (value == 'delete') {
                              donationProvider.deleteDonation(
                                  context, widget.id);
                            } else if (value == 'selesai') {
                              donationProvider.createReport(
                                context,
                                widget.programName,
                                widget.programDetail,
                                widget.programImagePath,
                                int.parse(widget.totalFunds),
                                int.parse(widget.fundRaised),
                                widget.id,
                              );
                            } else {
                              Navigator.pushNamed(
                                context,
                                EditDonation.id,
                                arguments: widget.id,
                              );
                            }
                          },
                          itemBuilder: (context) {
                            return <PopupMenuEntry>[
                              PopupMenuItem(
                                child: Text(
                                  "Program Selesai",
                                ),
                                value: "selesai",
                              ),
                              PopupMenuItem(
                                child: Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.green),
                                ),
                                value: "edit",
                              ),
                              PopupMenuItem(
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                                value: "delete",
                              ),
                            ];
                          },
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
