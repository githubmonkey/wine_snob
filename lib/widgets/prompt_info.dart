import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wine_snob/controller/query_controller.dart';
import 'package:wine_snob/widgets/expansion_block.dart';

class PromptInfo extends ConsumerWidget {
  const PromptInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentQuery = ref.watch(queryControllerProvider);
    return ExpansionBlock(
        title: 'Full prompt', body: currentQuery?.toContentString() ?? '??');
  }
}
