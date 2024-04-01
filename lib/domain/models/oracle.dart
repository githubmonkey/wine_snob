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
    required this.content,
    this.input,
    this.images,
    required this.output,
    this.comment,
    this.rating,
    this.created,
  });

  final OracleID id;
  final UserID uid;
  final String content;
  final String? input;
  final List<Uint8List>? images;
  final String output;
  final String? comment;
  final int? rating;
  final DateTime? created;

  @override
  List<Object> get props => [
        id,
        uid,
        // this is the message content, so the prompt
        content,
        input ?? '',
        images ?? '',
        output,
        comment ?? '',
        rating ?? '',
        // NOTE: ignore timestamp
      ];

  @override
  bool get stringify => true;

  factory Oracle.fromMap(Map<String, dynamic> data, String id) {
    final uid = data['uid'] as String;
    final content = data['content'] as String;
    final input = data['input'] as String?;
    final images = data['images'] as List<Uint8List>?;
    final output = data['output'] as String;
    final comment = data['comment'] as String?;
    final rating = data['rating'] as int?;
    final timestamp = data['created'] as Timestamp?;
    final created = timestamp?.toDate();

    return Oracle(
      id: id,
      uid: uid,
      content: content,
      input: input,
      images: images,
      output: output,
      comment: comment,
      rating: rating,
      created: created,
    );
  }

  Oracle copyWith({
    id,
    content,
    input,
    images,
    output,
    comment,
    rating,
    created,
  }) =>
      Oracle(
        id: id ?? this.id,
        uid: uid,
        content: content ?? content,
        input: input ?? input,
        images: images ?? images,
        output: output ?? output,
        comment: comment ?? comment,
        rating: rating ?? rating,
        created: created ?? created,
      );

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'content': content,
      'input': input,
      'images': images,
      'output': output,
      'comment': comment,
      'rating': rating,
      // NOTE: ingore timestamp
      //'created': created,
    };
  }
}
