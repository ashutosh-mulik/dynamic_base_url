import 'package:flutter/material.dart';

import 'custom_sheet.dart';

class BaseWrapper extends StatefulWidget {
  /// Builder
  final Function(BuildContext) builder;

  /// Base Url change callback
  final VoidCallback onBaseUrlChanged;

  /// [BaseWrapper] to restart app when base url changes.
  /// [builder]
  /// [onBaseUrlChanged] Base Url change callback.
  const BaseWrapper({
    Key? key,
    required this.builder,
    required this.onBaseUrlChanged,
  }) : super(key: key);

  @override
  State<BaseWrapper> createState() => BaseWrapperState();
}

class BaseWrapperState extends State<BaseWrapper> {
  bool _reset = false;
  bool _showSettings = false;

  /// Bubble location
  Offset _offset = const Offset(20, 100);

  /// Restarts the builder widget
  restart() async {
    setState(() => _reset = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _reset = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _reset
            ? const Scaffold(
                body: Center(
                  child: Text("Restarting..."),
                ),
              )
            : widget.builder(context),
        Positioned(
          left: _offset.dx,
          top: _offset.dy,
          child: GestureDetector(
            onPanUpdate: (d) =>
                setState(() => _offset += Offset(d.delta.dx, d.delta.dy)),
            child: FloatingActionButton(
              elevation: 0,
              onPressed: () {
                setState(() {
                  _showSettings = true;
                });
              },
              child: const Icon(Icons.change_circle_outlined),
            ),
          ),
        ),
        if (_showSettings) ...[
          Positioned.fill(
            child: MaterialApp(
              home: CustomSheet(
                changed: (isUrlChanged) {
                  setState(() {
                    _showSettings = false;
                  });
                  if (isUrlChanged) {
                    restart();
                    widget.onBaseUrlChanged();
                  }
                },
              ),
            ),
          ),
        ]
      ],
    );
  }
}
