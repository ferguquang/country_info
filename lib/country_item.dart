import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'country_response.dart';

@immutable
class CountryItem extends StatelessWidget {
  CountryResponse model;

  CountryItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 50,
          width: 100,
          child: CachedNetworkImage(
            imageUrl: model.flags?.png ?? "",
            fit: BoxFit.fill,
          )
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.name?.common ?? ""),
            Text(model.name?.official ?? ""),
            Text("Captital: ${_capital()}"),
          ],
        )
      ],
    );
  }

  _capital() {
    return model.capital?.toList().join(", ");
  }
}
