import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prawitama_care_admin/common/utils.dart';
import 'package:prawitama_care_admin/providers/donation_provider.dart';
import 'package:prawitama_care_admin/services/firebase_storage.dart';
import 'package:prawitama_care_admin/widgets/custom_appbar_desktop.dart';
import 'package:prawitama_care_admin/widgets/custom_appbar_mobile.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:uuid/uuid.dart';

class EditDonation extends StatefulWidget {
  static const String id = '/donation/edit';

  @override
  _EditDonationState createState() => _EditDonationState();
}

class _EditDonationState extends State<EditDonation> {
  @override
  Widget build(BuildContext context) {
    var uuid = Uuid();
    final donationProvider = Provider.of<DonationProvider>(context);

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          appBar: (sizingInformation.isMobile)
              ? CustomAppBarMobile()
              : CustomAppBarDesktopTablet(),
          body: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('donasi')
                  .doc(ModalRoute.of(context).settings.arguments)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return SizedBox.expand(
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
                              InkWell(
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
                                      donationProvider.changeProgramImagePath =
                                          dowurl;
                                    },
                                  );
                                },
                                child: Image.network(
                                  (donationProvider.programImagePath ==
                                          donationProvider.defaultImage)
                                      ? snapshot.data['programImagePath']
                                      : donationProvider.programImagePath,
                                  width: 500,
                                  height: 500,
                                  fit: BoxFit.fill,
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
                                  margin:
                                      EdgeInsets.only(top: defaultPadding * 2),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      prefixText: 'Rp ',
                                      hintText: snapshot.data['totalFunds']
                                          .toString(),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      donationProvider.changeTotalFunds =
                                          int.parse(value);
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
                                  margin:
                                      EdgeInsets.only(top: defaultPadding * 2),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: snapshot.data['programName'],
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      donationProvider.changeProgramName =
                                          value;
                                    },
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
                                  margin:
                                      EdgeInsets.only(top: defaultPadding * 2),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: snapshot.data['programDetail'],
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      donationProvider.changeProgramDetail =
                                          value;
                                    },
                                  ),
                                ),
                                SizedBox(height: defaultPadding * 6),
                                Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(defaultPadding * 2),
                                      child: Text("Simpan Program"),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.green,
                                      ),
                                    ),
                                    onPressed: () {
                                      donationProvider.updateDonation(
                                        context,
                                        snapshot.data.id,
                                        snapshot.data,
                                      );
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
                );
              }),
        );
      },
    );
  }
}
