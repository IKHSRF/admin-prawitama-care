import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prawitama_care_admin/common/utils.dart';
import 'package:prawitama_care_admin/services/firebase_storage.dart';
import 'package:prawitama_care_admin/services/firestore_services.dart';
import 'package:prawitama_care_admin/services/program_image_provider.dart';
import 'package:prawitama_care_admin/widgets/custom_appbar_desktop.dart';
import 'package:prawitama_care_admin/widgets/custom_appbar_mobile.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class Donation extends StatefulWidget {
  static const String id = '/donation';

  @override
  _DonationState createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  String _formatNumber(String number) =>
      NumberFormat.decimalPattern('id').format(int.parse(number));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: 'id').currencySymbol;

  TextEditingController _totalfunds = TextEditingController();
  TextEditingController _programName = TextEditingController();
  TextEditingController _programDetail = TextEditingController();

  String totalFunds;

  @override
  Widget build(BuildContext context) {
    var uuid = Uuid();
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
                        Consumer<ImagePathUrl>(
                          builder: (context, imagePathUrl, _) => InkWell(
                            onTap: () {
                              StorageServices.uploadImage(
                                  onSelected: (file) async {
                                Reference ref = FirebaseStorage.instance
                                    .refFromURL(
                                        'gs://prawitama-care.appspot.com/')
                                    .child(uuid.v4());

                                UploadTask uploadTask = ref.putBlob(file);
                                var dowurl = await (await uploadTask)
                                    .ref
                                    .getDownloadURL();
                                imagePathUrl.imagePath = dowurl;
                              });
                            },
                            child: Image.network(
                              imagePathUrl.imagePath,
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
                              controller: _totalfunds,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              decoration: InputDecoration(
                                prefixText: 'Rp ',
                                hintText: 'IDR',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                totalFunds = value;
                                value =
                                    '${_formatNumber(value.replaceAll(',', ''))}';
                                _totalfunds.value = TextEditingValue(
                                  text: value,
                                  selection: TextSelection.collapsed(
                                      offset: value.length),
                                );
                              },
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
                              controller: _programName,
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
                              controller: _programDetail,
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
                              onPressed: () async {
                                if (_programName.text.isEmpty ||
                                    _programDetail.text.isEmpty ||
                                    totalFunds.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Harap isi semua field"),
                                    ),
                                  );
                                } else {
                                  String result = await FirestoreServices
                                      .addDonationProgram(
                                    programDetail: _programDetail.text.trim(),
                                    programName: _programName.text.trim(),
                                    programImagePath: ImagePathUrl().imagePath,
                                    totalFunds: totalFunds,
                                  );
                                  if (result != 'berhasil') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text("Ada kesalahan dalam sistem"),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Berhasil"),
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.green,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(defaultPadding * 2),
                                child: Text("Simpan Program"),
                              ),
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
