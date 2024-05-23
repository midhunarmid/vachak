import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:vachak/core/data/datasources/firebase_collections.dart';
import 'package:vachak/core/data/models/va_language_model.dart';

class LocalDataSource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<VaLanguageModel>> getLanguages({String supports = ""}) async {
    String collection = FireStoreCollection.languages.name;

    Query query = _db.collection(collection);
    query.orderBy("name");

    if (supports.isNotEmpty) {
      query = query.where("supports", arrayContains: supports);
    }

    QuerySnapshot<VaLanguageModel> querySnapshotServer = await query
        .withConverter(
          fromFirestore: VaLanguageModel.fromFirestore,
          toFirestore: (VaLanguageModel data, _) => data.toMap(),
        )
        .get(const GetOptions(source: Source.cache));

    List<VaLanguageModel> resultList = [];

    if (querySnapshotServer.docs.isEmpty) {
      debugPrint("No records in cache");
    } else {
      for (QueryDocumentSnapshot docSnapshot in querySnapshotServer.docs) {
        resultList.add(docSnapshot.data() as VaLanguageModel);
      }
    }

    debugPrint("Cached items ${resultList.toString()}");

    return resultList;
  }
}
