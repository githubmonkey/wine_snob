import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/domain/models/prompt.dart';

part 'prompts_repository.g.dart';

class PromptsRepository {
  const PromptsRepository(this._firestore);

  final FirebaseFirestore _firestore;

  static String promptsPath() => 'prompts';

  static String promptPath(String promptId) => 'prompts/$promptId';

  // read
  Stream<Prompt> watchPrompt({required PromptID promptId}) => _firestore
      .doc(promptPath(promptId))
      .withConverter<Prompt>(
        fromFirestore: (snapshot, _) =>
            Prompt.fromMap(snapshot.data()!, snapshot.id),
        toFirestore: (prompt, _) => {},
      )
      .snapshots()
      .map((snapshot) => snapshot.data()!);

  Stream<List<Prompt>> watchPrompts() => queryPrompts()
      .where('active', isEqualTo: true)
      .orderBy('created', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Query<Prompt> queryPrompts() =>
      _firestore.collection(promptsPath()).withConverter<Prompt>(
            fromFirestore: (snapshot, _) =>
                Prompt.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (prompt, _) => {},
          );

  // Order doesn't matter
  Future<List<Prompt>> fetchPrompts() async {
    final prompts = await queryPrompts().get();
    return prompts.docs.map((doc) => doc.data()).toList();
  }
}

@Riverpod(keepAlive: true)
PromptsRepository promptsRepository(PromptsRepositoryRef ref) {
  return PromptsRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Prompt> promptsQuery(PromptsQueryRef ref) {
  final repository = ref.watch(promptsRepositoryProvider);
  return repository.queryPrompts();
}

@riverpod
Stream<Prompt> promptStream(PromptStreamRef ref, PromptID promptId) {
  final repository = ref.watch(promptsRepositoryProvider);
  return repository.watchPrompt(promptId: promptId);
}

@riverpod
Stream<List<Prompt>> promptsStream(PromptsStreamRef ref) {
  final repository = ref.watch(promptsRepositoryProvider);
  return repository.watchPrompts();
}
