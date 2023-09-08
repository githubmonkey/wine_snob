import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wine_snob/data/repositories/firebase_auth_repository.dart';
import 'package:wine_snob/data/repositories/oracles_repository.dart';
import 'package:wine_snob/domain/models/oracle.dart';
import 'package:wine_snob/widgets/history_card.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oracleRepository = ref.watch(oraclesRepositoryProvider);
    final user = ref.watch(authRepositoryProvider).currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Your History')),
      body: FirestoreListView<Oracle>(
          query: oracleRepository.queryOracles(uid: user!.uid),
          itemBuilder: (context, doc) {
            final oracle = doc.data();
            return Dismissible(
              key: Key('result-${oracle.id}'),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => ref
                  .read(oraclesRepositoryProvider)
                  .deleteOracle(uid: user.uid, oracleId: oracle.id),
              child: HistoryCard(oracle: oracle),
            );
          },
          emptyBuilder: (_) =>
              const Center(child: Text('You haven\'t saved any results yet.'))),
    );
  }
}
