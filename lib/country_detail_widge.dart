import 'package:flutter/material.dart';

import 'country_response.dart';

class CountryDetailWidget extends StatelessWidget {
  CountryResponse model;

  CountryDetailWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Country Detail: ${model.name?.common ?? ""}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () => Navigator.pop(context, true),
            tooltip: 'Mark as done',
          )
        ],
      ),
    );
  }
}
