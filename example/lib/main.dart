import 'package:dio/dio.dart';
import 'package:dynamic_base_url/dynamic_base_url.dart';
import 'package:flutter/material.dart';

void main() {
  /// Initialize BASE URL
  BASEURL.init(
    debug: 'https://dummyjson.com',
    prod: 'https://jsonplaceholder.typicode.com',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,

      /// Add wrapper
      home: BaseWrapper(
        navigatorKey: navigatorKey,
        child: const BaseURLUseExample(),
        onBaseUrlChange: () {},
      ),
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
