import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wine_snob/data/repositories/firebase_auth_repository.dart';
import 'package:wine_snob/data/repositories/oracles_repository.dart';
import 'package:wine_snob/domain/models/oracle.dart';

class HistoryCard extends ConsumerStatefulWidget {
  const HistoryCard({super.key, required this.oracle});

  final Oracle oracle;

  @override
  ResultCardState createState() => ResultCardState();
}

class ResultCardState extends ConsumerState<HistoryCard> {
  late TextEditingController _comment;
  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    _comment = TextEditingController(text: widget.oracle.comment ?? '');
  }

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${widget.oracle.id}; ${widget.oracle.created}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16.0),
            Text(widget.oracle.input),
            const Divider(),
            Text(widget.oracle.output),
            const SizedBox(height: 16.0),
            TextField(
              controller: _comment,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Comment',
              ),
              maxLines: 2,
              onChanged: (value) {
                setState(() {
                  _isDirty = true;
                });
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                FilledButton(
                  onPressed: _isDirty
                      ? () async {
                          final oraclesRepository =
                              ref.read(oraclesRepositoryProvider);
                          final user =
                              ref.read(authRepositoryProvider).currentUser;
                          await oraclesRepository.updateOracle(
                              uid: user!.uid,
                              oid: widget.oracle.id,
                              data: {'comment': _comment.value.text});
                          setState(() {
                            _isDirty = false;
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
                    final user = ref.read(authRepositoryProvider).currentUser;
                    await oraclesRepository.deleteOracle(
                        uid: user!.uid, oracleId: widget.oracle.id);
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
