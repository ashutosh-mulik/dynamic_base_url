import 'package:dio/dio.dart';
import 'package:dynamic_base_url/dynamic_base_url.dart';
import 'package:flutter/material.dart';

void main() {
  /// Initialize BASE URL
  BASEURL.init(
    debug: 'https://dummyjson.com',
    prod: 'https://jsonplaceholder.typicode.com',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        /// Set up [BaseWrapper]
        return BaseWrapper(
          builder: (context) => child!,
          onBaseUrlChanged: () {},
        );
      },
      home: const BaseURLUseExample(),
    );
  }
}

/// BASE URL USE
class BaseURLUseExample extends StatefulWidget {
  const BaseURLUseExample({Key? key}) : super(key: key);

  @override
  State<BaseURLUseExample> createState() => _BaseURLUseExampleState();
}

class _BaseURLUseExampleState extends State<BaseURLUseExample> {
  final Dio _dio = Dio();

  @override
  void initState() {
    /// User [BASEURL.URL] as a base url
    _dio.options.baseUrl = BASEURL.URL;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _dio.get("/todos/1"),
          builder: (BuildContext context, AsyncSnapshot<Response<dynamic>> snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.toString());
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
