import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:country_info/country_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'country_detail_widge.dart';
import 'country_response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Country Infomation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dio = Dio();
  List<CountryResponse> listCountry = [];
  List<CountryResponse> listSearchCountry = [];

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  void getHttp() async {
    var response = await dio.get('https://restcountries.com/v3.1/all');
    listCountry = List<CountryResponse>.from(response.data.map((model)=> CountryResponse.fromJson(model)));
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Tìm kiếm",
                prefixIcon: Icon(Icons.search,)
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                listSearchCountry = listCountry.where((element) {
                  return element.name?.common?.toLowerCase().contains(value) ?? false;
                }).toList();
              } else {
                listSearchCountry = [];
              }

              setState(() {

              });
            },
          ),
          Expanded(
            child: listSearchCountry.isNotEmpty ?
            _list(listSearchCountry) : _list(listCountry),
          ),
        ],
      ),
    );
  }

  _list(List<CountryResponse> list) {
    return ListView.separated(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return OpenContainer(
          closedShape: const RoundedRectangleBorder(),
          closedElevation: 0.0,
          transitionDuration: const Duration(milliseconds: 700),
          transitionType: ContainerTransitionType.fadeThrough,
          closedBuilder: (BuildContext context, void Function() action) {
            return CountryItem(model: list[index]);
          },
          openBuilder: (BuildContext context, void Function() action) {
            return CountryDetailWidget(model: list[index]);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Colors.grey[300],);
      },
    );
  }
}
