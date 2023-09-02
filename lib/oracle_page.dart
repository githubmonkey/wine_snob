import 'package:flutter/material.dart';
import 'package:wine_snob/controller/blurb_controller.dart';

class OraclePage extends StatefulWidget {
  const OraclePage({super.key, required this.title});

  final String title;

  @override
  State<OraclePage> createState() => OraclePageState();
}

class OraclePageState extends State<OraclePage> {
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
        title: Text(widget.title),
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
          FilledButton(
            onPressed: description.isNotEmpty
                ? () => updateBlurbsData(description)
                : null,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Taste it!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }

  Expanded buildBottomView2() {
    return Expanded(
      child: FutureBuilder(
        future: blurbData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(child: Text("..."));
          }

          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(snapshot.data![index].toString()),
              ));
            },
          );
        },
      ),
    );
  }
}
