import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wine_snob/data/repositories/firebase_auth_repository.dart';
import 'package:wine_snob/data/repositories/oracles_repository.dart';
import 'package:wine_snob/domain/models/query.dart';

class ResultCard extends ConsumerStatefulWidget {
  const ResultCard({
    super.key,
    required this.index,
    required this.query,
    required this.result,
  });

  final int index;
  final BaseQuery query;
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
              maxLines: 2,
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
                      final id = await oraclesRepository.addOracle(
                        uid: user!.uid,
                        output: widget.result,
                        comment: comment,
                        queryData: await widget.query.dataForHistory(),
                      );
                      setState(() {
                        oracleId = id;
                        isDirty = false;
                      });
                    },
                    child: const Text('Save'),
                  )
                : Row(
                    children: [
                      FilledButton(
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
                        child: const Text('Update Comment'),
                      ),
                      const Expanded(child: SizedBox()),
                      OutlinedButton(
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
                            final id = await oraclesRepository.addOracle(
                              uid: user!.uid,
                              output: widget.result,
                              comment: comment,
                              queryData: await widget.query.dataForHistory(),
                            );
                            setState(() {
                              oracleId = id;
                            });
                          }
                        },
                        child: const Text('Forget'),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
