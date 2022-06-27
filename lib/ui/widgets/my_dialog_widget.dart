import 'package:firstproject/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class MyDialogWidget extends StatelessWidget {
  const MyDialogWidget({Key? key, required this.child}) : super(key: key);
 final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      child:child,
    );
  }
}
