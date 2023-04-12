import 'package:dynamic_base_url/src/urls.dart';
import 'package:flutter/material.dart';

class CustomSheet extends StatefulWidget {
  final VoidCallback changed;
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
    return SizedBox(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "BASEURL URL Settings",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionChip(
                label: const Text("Debug"),
                backgroundColor: Colors.grey.withOpacity(0.2),
                onPressed: () {
                  BASEURL.URL = BASEURL.DEBUG;
                  widget.changed();
                },
              ),
              ActionChip(
                label: const Text("Dev"),
                backgroundColor: Colors.grey.withOpacity(0.2),
                onPressed: () {
                  BASEURL.URL = BASEURL.DEV;
                  widget.changed();
                },
              ),
              ActionChip(
                label: const Text("Prod"),
                backgroundColor: Colors.grey.withOpacity(0.2),
                onPressed: () {
                  BASEURL.URL = BASEURL.PROD;
                  widget.changed();
                },
              ),
              ActionChip(
                label: const Text("QA"),
                backgroundColor: Colors.grey.withOpacity(0.2),
                onPressed: () {
                  BASEURL.URL = BASEURL.QA;
                  widget.changed();
                },
              ),
              ActionChip(
                label: const Text("OTHER"),
                backgroundColor: Colors.grey.withOpacity(0.2),
                onPressed: () {
                  BASEURL.URL = BASEURL.OTHER;
                  widget.changed();
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
          const TextField(
            decoration: InputDecoration(
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
              widget.changed();
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
    );
  }
}
