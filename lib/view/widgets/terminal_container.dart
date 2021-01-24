import 'package:binarys/utils/color_utils.dart';
import 'package:flutter/material.dart';

class TerminalContainer extends StatelessWidget {
  const TerminalContainer({this.child, this.closePress});
  final Widget child;
  final VoidCallback closePress;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(width: 1.0, color: Colors.blueGrey),
        color: ColorUtils.terminalBackground,
      ),
      child: Column(
        children: <Widget>[
          _terminalThreeButton,
          Divider(thickness: 1, color: Colors.black),
          child ?? SizedBox(height: 250,),
        ],
      ),
    );
  }

  Widget get _terminalThreeButton => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            GestureDetector(
              child: _avatar(Colors.red),
              onTap: closePress,
            ),
            SizedBox(width: 4.0),
            _avatar(Colors.yellow),
            SizedBox(width: 4.0),
            _avatar(Colors.green),
            SizedBox(width: 4.0),
          ],
        ),
      );

  CircleAvatar _avatar(Color color) => CircleAvatar(
        radius: 6.0,
        backgroundColor: color,
      );
}
