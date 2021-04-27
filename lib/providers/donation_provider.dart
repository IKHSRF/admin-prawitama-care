import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prawitama_care_admin/models/donation.dart';
import 'package:prawitama_care_admin/models/report.dart';
import 'package:prawitama_care_admin/pages/home_page.dart';
import 'package:prawitama_care_admin/services/firestore_services.dart';

class DonationProvider with ChangeNotifier {
  final firestore = FirestoreServices();

  String _defaultImage =
      'https://firebasestorage.googleapis.com/v0/b/prawitama-care.appspot.com/o/Motivational-Quotes-ID-17.32817bcc.png?alt=media&token=1f77e79c-2905-44dc-aeb4-62e7bea76fab';
  String _programName;
  String _programDetail;
  String _programImagePath =
      'https://firebasestorage.googleapis.com/v0/b/prawitama-care.appspot.com/o/Motivational-Quotes-ID-17.32817bcc.png?alt=media&token=1f77e79c-2905-44dc-aeb4-62e7bea76fab';
  int _totalFunds;
  int _fundRaised = 0;

  //getter
  String get defaultImage => _defaultImage;
  String get programName => _programName;
  String get programDetail => _programDetail;
  String get programImagePath => _programImagePath;
  int get totalFunds => _totalFunds;
  int get fundRaised => _fundRaised;

  Stream<List<Donation>> get donation => firestore.getDonationData();
  Stream<List<Report>> get report => firestore.getReport();

  //setter
  set changeProgramName(String value) {
    _programName = value;
    notifyListeners();
  }

  set changeProgramDetail(String value) {
    _programDetail = value;
    notifyListeners();
  }

  set changeProgramImagePath(String value) {
    _programImagePath = value;
    notifyListeners();
  }

  set changeTotalFunds(int value) {
    _totalFunds = value;
    notifyListeners();
  }

  set changeFundRaised(int value) {
    _fundRaised = value;
    notifyListeners();
  }

  //function
  addDonation(BuildContext context) async {
    if (_programName == '' ||
        _programDetail == '' ||
        _programImagePath == '' ||
        _totalFunds == null) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ada Data Yang Belum Diisi")),
      );
    } else {
      var donation = Donation(
        programName: _programName,
        programDetail: _programDetail,
        programImagePath: _programImagePath,
        totalFunds: _totalFunds,
        fundRaised: _fundRaised,
      );

      var result = await firestore.addDonation(donation);
      if (result == 'ok') {
        _programImagePath =
            'https://firebasestorage.googleapis.com/v0/b/prawitama-care.appspot.com/o/Motivational-Quotes-ID-17.32817bcc.png?alt=media&token=1f77e79c-2905-44dc-aeb4-62e7bea76fab';
        _programName = '';
        _programDetail = '';
        _totalFunds = 0;
        _fundRaised = 0;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Berhasil Menambahkan Program Donasi")),
        );
        return Navigator.popAndPushNamed(context, HomePage.id);
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
    }
  }

  createReport(
    BuildContext context,
    String name,
    String detail,
    String imagePath,
    int total,
    int raised,
    String id,
  ) async {
    var report = Report(
      programName: name,
      programDetail: detail,
      programImagePath: imagePath,
      totalFunds: total,
      fundRaised: raised,
    );

    var result = await firestore.addReport(report);
    if (result == 'ok') {
      await FirebaseFirestore.instance.collection('donasi').doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Silahkan Lihat Laporan Di Tab Laporan")),
      );

      return Navigator.popAndPushNamed(context, HomePage.id);
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  updateDonation(
    BuildContext context,
    String id,
    DocumentSnapshot snapshot,
  ) async {
    var donation = Donation(
      programName:
          (_programName == '') ? snapshot.data()['programName'] : _programName,
      programDetail: (_programDetail == '')
          ? snapshot.data()['programDetail']
          : _programDetail,
      programImagePath: (_programImagePath == _defaultImage)
          ? snapshot.data()['programImagePath']
          : _programImagePath,
      totalFunds:
          (_totalFunds == 0) ? snapshot.data()['totalFunds'] : _totalFunds,
      fundRaised:
          (_fundRaised == 0) ? snapshot.data()['fundRaised'] : _fundRaised,
    );

    var result = await firestore.updateDonation(id, donation);
    if (result == 'ok') {
      _programImagePath =
          'https://firebasestorage.googleapis.com/v0/b/prawitama-care.appspot.com/o/Motivational-Quotes-ID-17.32817bcc.png?alt=media&token=1f77e79c-2905-44dc-aeb4-62e7bea76fab';
      _programName = '';
      _programDetail = '';
      _totalFunds = 0;
      _fundRaised = 0;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Berhasil Update Program Donasi")),
      );
      return Navigator.popAndPushNamed(context, HomePage.id);
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  deleteDonation(
    BuildContext context,
    String id,
  ) async {
    var result = await firestore.removeDonation(id);

    if (result == 'ok') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Berhasil Menghapus Program Donasi")),
      );
      return Navigator.popAndPushNamed(context, HomePage.id);
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }
}
