import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wine_snob/controller/blurb_controller.dart';
import 'package:wine_snob/controller/oracle_controller.dart';
import 'package:wine_snob/widgets/oracle_card.dart';

class OracleScreen extends ConsumerStatefulWidget {
  const OracleScreen({super.key});

  @override
  OracleScreenState createState() => OracleScreenState();
}

class OracleScreenState extends ConsumerState<OracleScreen> {
  final _formKey = GlobalKey<FormState>();

  final BlurbController blurbController = BlurbController();

  String description = '';
  late Future<List<String>>? blurbData = blurbController.getBlurbs(description);

  String instructionTitle =
      'Include winery, vinyard, cultivar, vintage, style, region, name, and anything else you might have...';

  void updateBlurbsData(String description) async {
    setState(() {
      blurbData = description.isNotEmpty
          ? blurbController.getBlurbs(description)
          : null;
    });
  }

  @override
  void initState() {
    super.initState();
    updateBlurbsData(description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaLM API Demo'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                buildTopView(),
                const SizedBox(
                  height: 10.0,
                ),
                buildBottomView2()
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
              labelText: 'About the wine',
            ),
            maxLines: 3,
            onChanged: (value) {
              setState(() {
                if (value.isNotEmpty) {
                  description = value;
                } else {
                  description = '';
                }
                blurbData = null;
              });
            },
            validator: (value) {
              // For now this validator is not used
              if (value == null || value.isEmpty) {
                return 'Please enter a description here';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          FilledButton(
            onPressed: description.isEmpty
                ? null
                : () => ref
                    .read(oracleControllerProvider.notifier)
                    .updateOracles(description),
            child: const Text('Taste it!'),
          )
        ],
      ),
    );
  }

  Expanded buildBottomView2() {
    final oraclesController = ref.watch(oracleControllerProvider);

    return Expanded(
      child: switch (oraclesController) {
        AsyncData(:final value) => ListView(
            children: [
              for (final (index, oracle) in value.indexed)
                OracleCard(index: index, oracle: oracle),
            ],
          ),
        AsyncError(:final error) => Text('Error: $error'),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
