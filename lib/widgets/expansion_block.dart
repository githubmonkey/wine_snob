import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpansionBlock extends ConsumerStatefulWidget {
  const ExpansionBlock({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  ExpansionBlockState createState() => ExpansionBlockState();
}

class ExpansionBlockState extends ConsumerState<ExpansionBlock> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
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
                  child: Text(widget.title),
                );
              },
              body: Container(
                color: Colors.white,
                width: Size.infinite.width,
                padding: const EdgeInsets.all(16),
                child: Text(widget.body),
              ),
            )
          ]),
    );
  }
}
