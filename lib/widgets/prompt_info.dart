import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wine_snob/controller/query_controller.dart';

class PromptInfo extends ConsumerStatefulWidget {
  const PromptInfo({super.key});

  @override
  PromptInfoState createState() => PromptInfoState();
}

class PromptInfoState extends ConsumerState<PromptInfo> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final currentQuery = ref.watch(queryControllerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ExpansionPanelList(
          expansionCallback: (i, isExpanded) {
            setState(() {
              if (i == 0) _isOpen = isExpanded;
            });
          },
          children: <ExpansionPanel>[
            ExpansionPanel(
              isExpanded: _isOpen,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return Container(
                  width: Size.infinite.width,
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                      'This is the background info included with your query'),
                );
              },
              body: Container(
                color: Colors.white,
                width: Size.infinite.width,
                padding: const EdgeInsets.all(16),
                child: Text(currentQuery?.toContent().toJson().toString() ??
                    'No Prompt selected'),
              ),
            )
          ]),
    );
  }
}
