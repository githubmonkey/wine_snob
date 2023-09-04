import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wine_snob/controller/oracle_card_controller.dart';
import 'package:wine_snob/domain/models/oracle.dart';

class OracleCard extends ConsumerStatefulWidget {
  const OracleCard({
    super.key,
    required this.index,
    required this.oracle,
  });

  final int index;
  final Oracle oracle;

  @override
  OracleCardState createState() => OracleCardState();
}

class OracleCardState extends ConsumerState<OracleCard> {
  late String comment;

  @override
  void initState() {
    super.initState();
    setState(() {
      comment = widget.oracle.comment ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Result ${widget.index}, ${widget.oracle.id}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16.0),
            Text(widget.oracle.output),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Comment',
              ),
              maxLines: 3,
              onChanged: (value) {
                setState(() {
                  comment = value.trim();
                });
              },
            ),
            const SizedBox(height: 16.0),
            FilledButton.tonal(
              // TODO: widget is not updated, so this is not correct
              onPressed: comment != (widget.oracle.comment ?? '')
                  ? () => ref
                      .read(oracleCardControllerProvider.notifier)
                      .updateOracle(
                          oid: widget.oracle.id, data: {'comment': comment})
                  : null,
              child: const Text(
                'Save Comment',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
