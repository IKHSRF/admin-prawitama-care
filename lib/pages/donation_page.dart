import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:prawitama_care_admin/common/utils.dart';
import 'package:prawitama_care_admin/providers/donation_provider.dart';
import 'package:prawitama_care_admin/services/firebase_storage.dart';
import 'package:prawitama_care_admin/widgets/custom_appbar_desktop.dart';
import 'package:prawitama_care_admin/widgets/custom_appbar_mobile.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:uuid/uuid.dart';

class Donation extends StatefulWidget {
  static const String id = '/donation';

  @override
  _DonationState createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  @override
  Widget build(BuildContext context) {
    final MoneyMaskedTextController totalFund = MoneyMaskedTextController(
      thousandSeparator: ',',
      precision: 3,
      initialValue: 0,
    );
    final TextEditingController programName = TextEditingController();
    final TextEditingController programDetail = TextEditingController();

    var uuid = Uuid();
    final donationProvider =
        Provider.of<DonationProvider>(context, listen: false);

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          appBar: (sizingInformation.isMobile)
              ? CustomAppBarMobile()
              : CustomAppBarDesktopTablet(),
          body: SizedBox.expand(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding * 2,
                vertical: defaultPadding * 2,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Consumer<DonationProvider>(
                          builder: (context, donation, _) => InkWell(
                            onTap: () {
                              StorageServices.uploadImage(
                                onSelected: (file) async {
                                  Reference ref = FirebaseStorage.instance
                                      .refFromURL(
                                          'gs://prawitama-care.appspot.com/')
                                      .child(
                                        uuid.v4(),
                                      );

                                  UploadTask uploadTask = ref.putBlob(file);
                                  var dowurl = await (await uploadTask)
                                      .ref
                                      .getDownloadURL();
                                  donation.changeProgramImagePath = dowurl;
                                },
                              );
                            },
                            child: Image.network(
                              donation.programImagePath,
                              width: 500,
                              height: 500,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 500,
                      color: Colors.white,
                      padding: EdgeInsets.all(defaultPadding * 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Masukan jumlah donasi yang diperlukan",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Colors.black),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: greenBackgroundColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: double.infinity,
                            height: 50,
                            padding: EdgeInsets.symmetric(
                              vertical: defaultPadding,
                              horizontal: defaultPadding * 2,
                            ),
                            margin: EdgeInsets.only(top: defaultPadding * 2),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              controller: totalFund,
                              decoration: InputDecoration(
                                prefixText: 'Rp ',
                                hintText: 'IDR',
                                border: InputBorder.none,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: defaultPadding * 4,
                            ),
                            height: 1,
                            width: double.infinity,
                            color: Colors.black,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: greyBackgroundColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: double.infinity,
                            height: 50,
                            padding: EdgeInsets.symmetric(
                              vertical: defaultPadding,
                              horizontal: defaultPadding * 2,
                            ),
                            margin: EdgeInsets.only(top: defaultPadding * 2),
                            child: TextField(
                              controller: programName,
                              decoration: InputDecoration(
                                hintText: 'Nama Program',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: greyBackgroundColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: double.infinity,
                            height: 50,
                            padding: EdgeInsets.symmetric(
                              vertical: defaultPadding,
                              horizontal: defaultPadding * 2,
                            ),
                            margin: EdgeInsets.only(top: defaultPadding * 2),
                            child: TextField(
                              controller: programDetail,
                              decoration: InputDecoration(
                                hintText: 'Detail Program',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(height: defaultPadding * 6),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              child: Padding(
                                padding: EdgeInsets.all(defaultPadding * 2),
                                child: Text("Simpan Program"),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.green,
                                ),
                              ),
                              onPressed: () {
                                donationProvider.changeTotalFunds = int.parse(
                                    totalFund.text.replaceAll(
                                        new RegExp(r'[^\w\s]+'), ''));
                                donationProvider.changeProgramName =
                                    programName.text;
                                donationProvider.changeProgramDetail =
                                    programDetail.text;

                                donationProvider.addDonation(context);
                              },
                            ),
                          ),
                        ],
                      ),
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
