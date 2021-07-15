import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  final String id;
  final String programName;
  final String programDetail;
  final String programImagePath;
  final int totalFunds;
  final int fundRaised;

  Donation({
    this.id,
    this.programName,
    this.programDetail,
    this.programImagePath,
    this.totalFunds,
    this.fundRaised,
  });

  factory Donation.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data();

    return Donation(
      id: snapshot.id,
      programName: data['programName'],
      programDetail: data['programDetail'],
      programImagePath: data['programImagePath'],
      totalFunds: data['totalFunds'],
      fundRaised: data['fundRaised'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'programName': programName,
      'programDetail': programDetail,
      'programImagePath': programImagePath,
      'totalFunds': totalFunds,
      'fundRaised': fundRaised,
    };
  }
}
