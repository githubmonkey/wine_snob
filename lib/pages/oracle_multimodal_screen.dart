import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wine_snob/controller/oracle_multimedia_controller.dart';
import 'package:wine_snob/controller/query_multimodal_controller.dart';
import 'package:wine_snob/domain/models/query.dart';
import 'package:wine_snob/widgets/expansion_block.dart';
import 'package:wine_snob/widgets/image_picker_block.dart';
import 'package:wine_snob/widgets/result_card.dart';

class OracleMultimodalScreen extends ConsumerStatefulWidget {
  const OracleMultimodalScreen({super.key});

  @override
  OracleMultimodalScreenState createState() => OracleMultimodalScreenState();
}

class OracleMultimodalScreenState
    extends ConsumerState<OracleMultimodalScreen> {
  final _formKey = GlobalKey<FormState>();

  String instructionTitle = 'Upload some photos and adjust the text as needed.';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuery = ref.watch(queryMultimodalControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generative AI Demo - Multimodal Prompt'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: <Widget>[
                buildTopView(),
                const SizedBox(height: 10.0),
                buildBottomView(),
                const SizedBox(height: 10.0),
                ExpansionBlock(
                    title: 'Full prompt',
                    child: Text(currentQuery.toPrettyPrintedContent())),
              ])),
        ),
      ),
    );
  }

  Form buildTopView() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(instructionTitle, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Full Text Prompt",
            ),
            initialValue: MULTIMODAL_TEXT,
            minLines: 3,
            maxLines: 10,
            onChanged: (value) {
              ref
                  .read(queryMultimodalControllerProvider.notifier)
                  .updateText(text: value);
              ref
                  .read(oracleMultimediaControllerProvider.notifier)
                  .resetResults();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This can't be empty";
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          const ImagePickerBlock(),
          const SizedBox(height: 16.0),
          SizedBox(
            width: 140.0,
            child: FilledButton(
              onPressed: (() {
                if (_formKey.currentState!.validate()) {
                  ref
                      .read(oracleMultimediaControllerProvider.notifier)
                      .queryModel();
                }
              }),
              child: const Text('Taste it!'),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBottomView() {
    final oraclesController = ref.watch(oracleMultimediaControllerProvider);
    final query = ref.watch(queryMultimodalControllerProvider);

    return switch (oraclesController) {
      AsyncData(:final value) => ListView(
          shrinkWrap: true,
          children: [
            for (final (index, result) in value.indexed)
              ResultCard(index: index, query: query, result: result),
          ],
        ),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
