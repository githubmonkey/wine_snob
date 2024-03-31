import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wine_snob/controller/oracle_text_controller.dart';
import 'package:wine_snob/controller/query_text_controller.dart';
import 'package:wine_snob/domain/models/query.dart';
import 'package:wine_snob/widgets/expansion_block.dart';
import 'package:wine_snob/widgets/result_card.dart';

class OracleTextScreen extends ConsumerStatefulWidget {
  const OracleTextScreen({super.key});

  @override
  OracleTextScreenState createState() => OracleTextScreenState();
}

class OracleTextScreenState extends ConsumerState<OracleTextScreen> {
  final _formKey = GlobalKey<FormState>();

  String instructionTitle = 'Provide details of a wine including winery, '
      'vineyard, cultivar, vintage, style, region, name, etc.';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuery = ref.watch(queryTextControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generative AI Demo - Text Prompt'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                buildTopView(),
                const SizedBox(height: 10.0),
                buildBottomView2(),
                const SizedBox(height: 10.0),
                ExpansionBlock(
                  title: 'Full prompt',
                  child: Text(currentQuery.toPrettyPrintedContent()),
                ),
              ],
            )),
      ),
    );
  }

  Form buildTopView() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(instructionTitle, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'About your wine',
            ),
            maxLines: 1,
            onChanged: (value) {
              ref
                  .read(queryTextControllerProvider.notifier)
                  .updateInput(input: value);
              ref.read(oracleTextControllerProvider.notifier).resetResults();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description here';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Full Text Prompt (with pattern '$INPUT_PLACEHOLDER')",
            ),
            initialValue: TEXT_TEMPLATE,
            maxLines: 3,
            onChanged: (value) {
              ref
                  .read(queryTextControllerProvider.notifier)
                  .updateScaffold(scaffold: value);
              ref.read(oracleTextControllerProvider.notifier).resetResults();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This can't be empty";
              }
              if (!value.contains(INPUT_PLACEHOLDER)) {
                return "The string must contain the placeholder $INPUT_PLACEHOLDER";
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          FilledButton(
            onPressed: (() {
              if (_formKey.currentState!.validate()) {
                ref.read(oracleTextControllerProvider.notifier).queryModel();
              }
            }),
            child: const Text('Taste it!'),
          )
        ],
      ),
    );
  }

  Expanded buildBottomView2() {
    final oraclesController = ref.watch(oracleTextControllerProvider);
    final query = ref.watch(queryTextControllerProvider);

    return Expanded(
      child: switch (oraclesController) {
        AsyncData(:final value) => ListView(
            children: [
              for (final (index, result) in value.indexed)
                ResultCard(index: index, query: query, result: result),
            ],
          ),
        AsyncError(:final error) => Text('Error: $error'),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
