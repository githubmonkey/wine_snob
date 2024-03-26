import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'app_user.dart';

typedef OracleID = String;

@immutable
class Oracle extends Equatable {
  const Oracle({
    required this.id,
    required this.uid,
    required this.input,
    required this.content,
    required this.output,
    this.comment,
    this.rating,
    this.created,
  });

  final OracleID id;
  final UserID uid;
  final String input;
  final String content;
  final String output;
  final String? comment;
  final int? rating;
  final DateTime? created;

  @override
  List<Object> get props => [
        id,
        uid,
        input,
        content,
        output,
        comment ?? '',
        rating ?? '',
        // NOTE: ignore timestamp
      ];

  @override
  bool get stringify => true;

  factory Oracle.fromMap(Map<String, dynamic> data, String id) {
    final uid = data['uid'] as String;
    final input = data['input'] as String;
    final content = data['content'] as String;
    final output = data['output'] as String;
    final comment = data['comment'] as String?;
    final rating = data['rating'] as int?;
    final timestamp = data['created'] as Timestamp?;
    final created = timestamp?.toDate();

    return Oracle(
      id: id,
      uid: uid,
      input: input,
      content: content,
      output: output,
      comment: comment,
      rating: rating,
      created: created,
    );
  }

  Oracle copyWith({id, name, catId, catName}) => Oracle(
        id: id ?? this.id,
        uid: uid,
        input: input,
        content: content,
        output: output,
        comment: comment ?? comment,
        rating: rating ?? rating,
        created: created ?? created,
      );

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'input': input,
      'content': content,
      'output': output,
      'comment': comment,
      'rating': rating,
      // NOTE: ingore timestamp
      //'created': created,
    };
  }
}
