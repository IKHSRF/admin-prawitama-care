import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreServices {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference _programDonation = _firestore.collection('donasi');

  static Future<String> addDonationProgram({
    @required String programDetail,
    @required String programName,
    @required String programImagePath,
    @required String totalFunds,
    String fundRaised = '0',
  }) async {
    try {
      await _programDonation.add({
        'programName': programName,
        'programDetail': programDetail,
        'programImagePath': programImagePath,
        'totalFunds': totalFunds,
        'fundRaised': fundRaised,
      });
      return 'berhasil';
    } catch (error) {
      return error.message;
    }
  }

  static Stream<QuerySnapshot> getDonationProgram() {
    return _programDonation.snapshots();
  }
}
