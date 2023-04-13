import 'package:dynamic_base_url/src/urls.dart';
import 'package:flutter/material.dart';

class CustomSheet extends StatefulWidget {
  final Function changed;
  const CustomSheet({Key? key, required this.changed}) : super(key: key);

  @override
  State<CustomSheet> createState() => _CustomSheetState();
}

class _CustomSheetState extends State<CustomSheet> {
  final TextEditingController _textEditingController = TextEditingController();
  final String _currentURL = BASEURL.URL;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.changed(_currentURL != BASEURL.URL);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Base URL Settings"),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              widget.changed(_currentURL != BASEURL.URL);
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Current URL : $_currentURL",
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 5,
                children: [
                  ActionChip(
                    label: const Text("Debug"),
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    onPressed: () {
                      BASEURL.URL = BASEURL.DEBUG;
                      widget.changed(_currentURL != BASEURL.URL);
                    },
                  ),
                  ActionChip(
                    label: const Text("Dev"),
                    backgroundColor: BASEURL.DEV.isNotEmpty ? Colors.grey.shade200 : Colors.redAccent.shade100,
                    onPressed: () {
                      if (BASEURL.DEV.isEmpty) {
                        _showSnackBar("url is not set");
                        return;
                      }
                      BASEURL.URL = BASEURL.DEV;
                      widget.changed(_currentURL != BASEURL.URL);
                    },
                  ),
                  ActionChip(
                    label: const Text("Prod"),
                    backgroundColor: BASEURL.PROD.isNotEmpty ? Colors.grey.shade200 : Colors.redAccent.shade100,
                    onPressed: () {
                      if (BASEURL.PROD.isEmpty) {
                        _showSnackBar("url is not set");
                        return;
                      }
                      BASEURL.URL = BASEURL.PROD;
                      widget.changed(_currentURL != BASEURL.URL);
                    },
                  ),
                  ActionChip(
                    label: const Text("QA"),
                    backgroundColor: BASEURL.QA.isNotEmpty ? Colors.grey.shade200 : Colors.redAccent.shade100,
                    onPressed: () {
                      if (BASEURL.QA.isEmpty) {
                        _showSnackBar("url is not set");
                        return;
                      }
                      BASEURL.URL = BASEURL.QA;
                      widget.changed(_currentURL != BASEURL.URL);
                    },
                  ),
                  ActionChip(
                    label: const Text("OTHER"),
                    backgroundColor: BASEURL.OTHER.isNotEmpty ? Colors.grey.shade200 : Colors.redAccent.shade100,
                    onPressed: () {
                      if (BASEURL.OTHER.isEmpty) {
                        _showSnackBar("url is not set");
                        return;
                      }
                      BASEURL.URL = BASEURL.OTHER;
                      widget.changed(_currentURL != BASEURL.URL);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Custom URL",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  BASEURL.URL = _textEditingController.text;
                  widget.changed(_currentURL != BASEURL.URL);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showSnackBar(String error) {
    final snackBar = SnackBar(
      content: Text(error),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
