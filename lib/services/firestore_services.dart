import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prawitama_care_admin/models/donation.dart';

class FirestoreServices {
  CollectionReference donationReference =
      FirebaseFirestore.instance.collection('donation');

  Stream<List<Donation>> getDonationData() =>
      donationReference.snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Donation.fromFirestore(doc)).toList());

  Future<String> addDonation(Donation donation) async {
    try {
      await donationReference.add(donation.toFirestore());
      return 'ok';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  Future<String> removeDonation(String id) async {
    try {
      await donationReference.doc(id).delete();
      return 'ok';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  Future<String> updateDonation(String id, Donation donation) async {
    try {
      await donationReference
          .doc(id)
          .set(donation.toFirestore(), SetOptions(merge: true));
      return 'ok';
    } catch (error) {
      print(error);
      return error.message;
    }
  }
}
