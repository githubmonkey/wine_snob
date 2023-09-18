import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

typedef PromptID = String;

@immutable
class Prompt extends Equatable {
  const Prompt({
    required this.id,
    required this.handle,
    required this.uri,
    required this.request,
    required this.comment,
    required this.active,
    this.created,
  });

  final PromptID id;
  final String handle;
  final String uri;
  final String request;
  final String comment;
  final bool active;
  final DateTime? created;

  @override
  // NOTE: ignore timestamp
  List<Object> get props => [id, handle, uri, request, comment, active];

  @override
  //bool get stringify => true;

  factory Prompt.fromMap(Map<String, dynamic> data, String id) {
    final handle = data['handle'] as String;
    final uri = data['uri'] as String;
    final request = data['request'] as String;
    final comment = data['comment'] as String;
    final active = data['active'] as bool;
    final timestamp = data['created'] as Timestamp;
    final created = timestamp.toDate();

    return Prompt(
      id: id,
      handle: handle,
      uri: uri,
      request: request,
      comment: comment,
      active: active,
      created: created,
    );
  }
}
