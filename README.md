<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) <br><br>
Dynamically change base url of your dio client or http client at runtime.

## 📚 Guide
1. Initialize `dynamic_base_url` using `BASEURL.init` inside `main()` method.
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  /// Initialize BASE URL
  BASEURL.init(
    debug: 'https://dummyjson.com',
    prod: 'https://jsonplaceholder.typicode.com',
  );

  runApp(const MyApp());
}
```
2. Add `BaseWrapper` in `MaterialApp.builder`.
```dart
.....
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
.....
```

3. Use `BASEURL.URL` in dio or http.

- Direct
```dart
_dio.get("${BASEURL.URL}/todos/1")
```
- Dio
```dart
/// User [BASEURL.URL] as a base url
_dio.options.baseUrl = BASEURL.URL;
```
- If you are using service locator `get_it` then change client base url from `BaseWrapper` callback.
```dart
.....
return BaseWrapper(
  builder: (context) => child!,
  onBaseUrlChanged: () {
    /// Change [baseUrl] here
    GetIt.instance<Dio>().options.baseUrl = BASEURL.URL;
  },
);
.....
```
4. Open Base URL settings using floating bubble.

### License
```
MIT License

Copyright (c) 2023 Ashutosh Mulik

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
```
