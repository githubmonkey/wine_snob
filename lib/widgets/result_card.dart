import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wine_snob/controller/prompt_controller.dart';
import 'package:wine_snob/controller/query_controller.dart';
import 'package:wine_snob/data/repositories/firebase_auth_repository.dart';
import 'package:wine_snob/data/repositories/oracles_repository.dart';

class ResultCard extends ConsumerStatefulWidget {
  const ResultCard({
    super.key,
    required this.index,
    required this.result,
  });

  final int index;
  final String result;

  @override
  ResultCardState createState() => ResultCardState();
}

class ResultCardState extends ConsumerState<ResultCard> {
  String? oracleId;
  String comment = '';
  bool isDirty = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Result ${widget.index}, ${oracleId ?? '<not saved>'}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16.0),
            Text(widget.result),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Comment',
              ),
              maxLines: 3,
              onChanged: (value) {
                if (value.trim() != comment) {
                  setState(() {
                    comment = value.trim();
                    isDirty = true;
                  });
                }
              },
            ),
            const SizedBox(height: 16.0),
            (oracleId == null)
                ? OutlinedButton(
                    onPressed: () async {
                      final oraclesRepository =
                          ref.read(oraclesRepositoryProvider);
                      final user = ref.read(authRepositoryProvider).currentUser;
                      final prompt = ref.read(promptControllerProvider);
                      final query = ref.watch(queryControllerProvider);
                      final id = await oraclesRepository.addOracle(
                          uid: user!.uid,
                          promptId: prompt!.id,
                          promptHandle: prompt.handle,
                          input: query ?? '??',
                          output: widget.result,
                          comment: comment);
                      setState(() {
                        oracleId = id;
                        isDirty = false;
                      });
                    },
                    child: Text('Save'),
                  )
                : Row(
                    children: [
                      FilledButton(
                        onPressed: () async {
                          final oraclesRepository =
                              ref.read(oraclesRepositoryProvider);
                          final user =
                              ref.read(authRepositoryProvider).currentUser;
                          if (oracleId != null) {
                            await oraclesRepository.deleteOracle(
                                uid: user!.uid, oracleId: oracleId!);
                            setState(() {
                              oracleId = null;
                            });
                          } else {
                            final prompt = ref.read(promptControllerProvider);
                            final query = ref.watch(queryControllerProvider);
                            final id = await oraclesRepository.addOracle(
                                uid: user!.uid,
                                promptId: prompt!.id,
                                promptHandle: prompt.handle,
                                input: query ?? '??',
                                output: widget.result,
                                comment: comment);
                            setState(() {
                              oracleId = id;
                            });
                          }
                        },
                        child: Text('Forget'),
                      ),
                      OutlinedButton(
                        onPressed: isDirty
                            ? () async {
                                final oraclesRepository =
                                    ref.read(oraclesRepositoryProvider);
                                final user = ref
                                    .read(authRepositoryProvider)
                                    .currentUser;
                                await oraclesRepository.updateOracle(
                                    uid: user!.uid,
                                    oid: oracleId!,
                                    data: {'comment': comment});
                                setState(() {
                                  isDirty = false;
                                });
                              }
                            : null,
                        child: Text('Update Comment'),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
