import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prawitama_care_admin/common/utils.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProgramCard extends StatefulWidget {
  const ProgramCard({
    Key key,
    @required this.programName,
    @required this.programDetail,
    @required this.totalFunds,
    @required this.fundRaised,
    @required this.programImagePath,
  }) : super(key: key);

  final String programName;
  final String programDetail;
  final String totalFunds;
  final String fundRaised;
  final String programImagePath;

  @override
  _ProgramCardState createState() => _ProgramCardState();
}

class _ProgramCardState extends State<ProgramCard> {
  String _formatNumber(String number) =>
      NumberFormat.decimalPattern('id').format(int.parse(number));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: 'id').currencySymbol;
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
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
              ? Theme.of(context).textTheme.bodyText2
              : Theme.of(context).textTheme.bodyText1;
          TextStyle subtitleTextStyle = (sizingInformation.isMobile)
              ? Theme.of(context).textTheme.overline
              : Theme.of(context).textTheme.subtitle2;
          return AnimatedContainer(
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.all(defaultPadding * 2),
            width: 300,
            height: 520,
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
                  widget.programImagePath,
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
                    widget.programName,
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
                    widget.programDetail,
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
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
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
                              width: 500 * 0.2,
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
                          "0% dari Rp ${_formatNumber(widget.totalFunds)}",
                          style: subtitleTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
