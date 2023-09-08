import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/data/repositories/firebase_auth_repository.dart';
import 'package:wine_snob/domain/models/oracle.dart';
import 'package:wine_snob/domain/models/prompt.dart';

import '../../domain/models/app_user.dart';

part 'oracles_repository.g.dart';

class OraclesRepository {
  const OraclesRepository(this._firestore);

  final FirebaseFirestore _firestore;

  static String oraclePath(String uid, String oracleId) =>
      'users/$uid/oracles/$oracleId';

  static String oraclesPath(String uid) => 'users/$uid/oracles';

// create
  Future<String> addOracle({
    required UserID uid,
    required PromptID promptId,
    required String promptHandle,
    required String input,
    required String output,
    required String comment,
  }) async {
    final doc = _firestore.collection(oraclesPath(uid)).doc();
    await doc.set({
      'id': doc.id,
      'uid': uid,
      'promptId': promptId,
      'promptHandle': promptHandle,
      'input': input,
      'output': output,
      'comment': comment,
      'created': FieldValue.serverTimestamp()
    });
    return doc.id;
  }

  // update
  Future<void> updateOracle(
          {required UserID uid,
          required OracleID oid,
          required Map<String, dynamic> data}) =>
      _firestore.doc(oraclePath(uid, oid)).update(data);

  // read
  Stream<Oracle> watchOracle(
          {required UserID uid, required OracleID oracleId}) =>
      _firestore
          .doc(oraclePath(uid, oracleId))
          .withConverter<Oracle>(
            fromFirestore: (snapshot, _) =>
                Oracle.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (oracle, _) => oracle.toMap(),
          )
          .snapshots()
          .map((snapshot) => snapshot.data()!);

  Stream<List<Oracle>> watchOracles({required UserID uid}) =>
      queryOracles(uid: uid)
          .orderBy('created', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Query<Oracle> queryOracles({required UserID uid}) => _firestore
      .collection(oraclesPath(uid))
      .orderBy('created', descending: true)
      .withConverter<Oracle>(
        fromFirestore: (snapshot, _) =>
            Oracle.fromMap(snapshot.data()!, snapshot.id),
        toFirestore: (oracle, _) => oracle.toMap(),
      );

  Future<void> deleteOracle(
      {required UserID uid, required OracleID oracleId}) async {
    final ref = _firestore.doc(oraclePath(uid, oracleId));
    await ref.delete();
  }
}

@Riverpod(keepAlive: true)
OraclesRepository oraclesRepository(OraclesRepositoryRef ref) {
  return OraclesRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Oracle> oraclesQuery(OraclesQueryRef ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(oraclesRepositoryProvider);
  return repository.queryOracles(uid: user.uid);
}

@riverpod
Stream<Oracle> oracleStream(OracleStreamRef ref, OracleID oracleId) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(oraclesRepositoryProvider);
  return repository.watchOracle(uid: user.uid, oracleId: oracleId);
}

@riverpod
Stream<List<Oracle>> oraclesStream(OraclesStreamRef ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(oraclesRepositoryProvider);
  return repository.watchOracles(uid: user.uid);
}
