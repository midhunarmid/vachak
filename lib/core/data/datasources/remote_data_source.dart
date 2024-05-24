import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vachak/core/data/datasources/firebase_collections.dart';
import 'package:vachak/core/data/models/auth_user_model.dart';
import 'package:vachak/core/data/models/va_language_model.dart';
import 'package:vachak/core/presentation/utils/global.dart';
import 'package:vachak/core/presentation/utils/message_generator.dart';
import 'package:vachak/core/presentation/utils/my_app_exception.dart';
import 'package:vachak/main.dart';

// TODO
// https://currentmillis.com/time/minutes-since-unix-epoch.php
// Write code to check device time and follow last updated time approach for caching

class RemoteDataSource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<AuthUserModel> authenticateUser(String email, String password) async {
    // Simulated API call or data retrieval logic
    // Replace this with your actual API integration logic

    // Simulating a response from a remote API
    await Future.delayed(
        const Duration(seconds: 2)); // Simulating delay for API call

    // Mock response data (replace with your actual API response parsing)
    final Map<String, dynamic> userJson = {
      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
      "expiresIn": 3600,
      "userId": "123456",
      "email": "user@vachak.com"
    };

    // throw auth exception randomly for testing purpose
    if (Random().nextBool()) {
      throw MyAppException(
          title: MessageGenerator.getMessage("Auth Error"),
          message: MessageGenerator.getMessage("Invalid credentials"));
    }

    // Convert JSON data to UserModel instance
    return AuthUserModel.fromMap(userJson);
  }

  Future<List<VaLanguageModel>> getLanguages({String supports = ""}) async {
    String collection = FireStoreCollection.languages.name;

    Query query = _db.collection(collection);
    query.orderBy("name");

    if (supports.isNotEmpty) {
      query = query.where("supports", arrayContains: supports);
    }

    String lastReceivedDocId =
        await GlobalValues.getLastReceivedDocId(collection: collection);
    MyApp.debugPrint("lastReceivedDocId $lastReceivedDocId");

    if (lastReceivedDocId.isNotEmpty) {
      DocumentSnapshot? lastReceivedDocSnapshot =
          await _db.collection(collection).doc(lastReceivedDocId).get();
      query = query.startAfterDocument(lastReceivedDocSnapshot);
    }

    QuerySnapshot<VaLanguageModel> querySnapshotServer = await query
        .withConverter(
          fromFirestore: VaLanguageModel.fromFirestore,
          toFirestore: (VaLanguageModel data, _) => data.toMap(),
        )
        .get(const GetOptions(source: Source.server));

    List<VaLanguageModel> resultList = [];

    if (querySnapshotServer.docs.isNotEmpty) {
      for (QueryDocumentSnapshot docSnapshot in querySnapshotServer.docs) {
        resultList.add(docSnapshot.data() as VaLanguageModel);
      }
      String lastVisibleDocId =
          querySnapshotServer.docs[querySnapshotServer.size - 1].id;
      await GlobalValues.setLastReceivedDocId(
          collection: collection, docId: lastVisibleDocId);
    }

    MyApp.debugPrint("Server items ${resultList.toString()}");

    return resultList;
  }
}
