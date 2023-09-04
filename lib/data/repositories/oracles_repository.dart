import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/data/repositories/firebase_auth_repository.dart';
import 'package:wine_snob/domain/models/oracle.dart';

import '../../domain/models/app_user.dart';

part 'oracles_repository.g.dart';

class OraclesRepository {
  const OraclesRepository(this._firestore);

  final FirebaseFirestore _firestore;

  static String oraclePath(String uid, String oracleId) =>
      'users/$uid/oracles/$oracleId';

  static String oraclesPath(String uid) => 'users/$uid/oracles';

  // get an oracle object with id
  Oracle createOracle({
    required UserID uid,
    required String input,
    required String output,
  }) {
    final docref = _firestore.collection(oraclesPath(uid)).doc();
    return Oracle(id: docref.id, uid: uid, input: input, output: output);
  }

  Future<void> setOracle({required UserID uid, required Oracle oracle}) {
    var data = oracle.toMap();
    data['created'] = FieldValue.serverTimestamp();

    return _firestore.doc(oraclePath(uid, oracle.id)).set(data);
  }

  // create
  // NOTE: no comment or rating at this point
  Future<void> xxaddOracle({
    required UserID uid,
    required String input,
    required String output,
  }) =>
      _firestore.collection(oraclesPath(uid)).add({
        'input': input,
        'output': output,
        'created': FieldValue.serverTimestamp(),
      });

// update
  Future<void> updateOracle({required UserID uid, required OracleID oid, required Map<String, dynamic> data}) =>
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
          .orderBy('rating')
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Query<Oracle> queryOracles({required UserID uid}) =>
      _firestore.collection(oraclesPath(uid)).withConverter<Oracle>(
            fromFirestore: (snapshot, _) =>
                Oracle.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (oracle, _) => oracle.toMap(),
          );

// Order doesn't matter
  Future<List<Oracle>> xxfetchOracles({required UserID uid}) async {
    final oracles = await queryOracles(uid: uid).get();
    return oracles.docs.map((doc) => doc.data()).toList();
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
