import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/reports_model.dart';

class DbProvider extends ChangeNotifier {
  static DbProvider instance = DbProvider();
  late FirebaseFirestore _db;
  String wasteIncedentCollection = 'wasteIncedent';

  DbProvider() {
    _db = FirebaseFirestore.instance;
  }

  Future<void> createdWasteIncedent(ReportModel reportModel) async {
    DocumentReference ref = _db.collection(wasteIncedentCollection).doc();
    reportModel.id = ref.id;
    await ref.set(reportModel.toMap());
  }

  Future<List<ReportModel>> getAllReport(String type) async {
    List<ReportModel> list = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot;
    if (type == 'all') {
      querySnapshot = await _db.collection(wasteIncedentCollection).get();
    } else {
      querySnapshot = await _db
          .collection(wasteIncedentCollection)
          .where('type', isEqualTo: type)
          .get();
    }
    list = querySnapshot.docs
        .map((report) => ReportModel.fromMap(report.data()))
        .toList();

    return list;
  }
}
