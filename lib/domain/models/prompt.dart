import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

typedef PromptID = String;

@immutable
class Prompt extends Equatable {
  const Prompt({
    required this.id,
    required this.handle,
    required this.context,
    required this.message,
    required this.examples,
    required this.comment,
    required this.active,
    this.created,
  });

  final PromptID id;
  final String handle;
  final String context;
  final String message;
  final Map<String, String> examples;
  final String comment;
  final bool active;
  final DateTime? created;

  @override
  // NOTE: ignore timestamp
  List<Object> get props =>
      [id, handle, context, message, examples, comment, active];

  @override
  //bool get stringify => true;

  factory Prompt.fromMap(Map<String, dynamic> data, String id) {
    final handle = data['handle'] as String;
    final context = data['context'] as String;
    final message = data['message'] as String;

    final rawmap = data['examples'] as Map<String, dynamic>;
    final examples = rawmap
        .map((key, value) => MapEntry<String, String>(key, value.toString()));
    final comment = data['comment'] as String;
    final active = data['active'] as bool;
    final timestamp = data['created'] as Timestamp;
    final created = timestamp.toDate();

    return Prompt(
      id: id,
      handle: handle,
      context: context,
      message: message,
      examples: examples,
      comment: comment,
      active: active,
      created: created,
    );
  }

  String prettyPrint() {
    return ('$id, $handle\n'
    'context: $context\n'
    'message: $message\n'
    'examples:\n'
    '${examples.entries.join("\n")}\n'
    'created: $created, ${active ? "currently" : "not"} active');
  }
}
