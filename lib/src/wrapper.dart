import 'package:dynamic_base_url/src/shake.dart';
import 'package:flutter/material.dart';

import 'custom_sheet.dart';

class BaseWrapper extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;
  final VoidCallback onBaseUrlChange;

  const BaseWrapper({
    Key? key,
    required this.navigatorKey,
    required this.child,
    required this.onBaseUrlChange,
  }) : super(key: key);

  @override
  State<BaseWrapper> createState() => _BaseWrapperState();
}

class _BaseWrapperState extends State<BaseWrapper> {
  Key _key = UniqueKey();
  bool _isOpen = false;

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  ShakeDetector detector = ShakeDetector();

  @override
  void initState() {
    super.initState();
    detector.startListening(() {
      if (_isOpen) return;
      openDialog();
    });
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: widget.child,
    );
  }

  openDialog() {
    _isOpen = true;
    bool isChanged = false;
    showModalBottomSheet(
      isScrollControlled: true,
      context: widget.navigatorKey.currentContext!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(widget.navigatorKey.currentContext!).viewInsets.bottom + 20, left: 20, right: 20, top: 20),
          child: CustomSheet(
            changed: () {
              isChanged = true;
              Navigator.pop(widget.navigatorKey.currentContext!);
            },
          ),
        );
      },
    ).whenComplete(() {
      _isOpen = false;
      if (!isChanged) return;
      widget.onBaseUrlChange();
      restartApp();
    });
  }
}
