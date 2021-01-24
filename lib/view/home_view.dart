import 'package:binarys/utils/color_utils.dart';
import 'package:binarys/utils/copy_to_clipboard.dart';
import 'package:binarys/view/widgets/terminal_container.dart';
import 'package:flutter/material.dart';
import 'package:binarys/controller/convert_controller.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController _textController = TextEditingController();
  ConvertController _convertController;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _convertToBinary(String str) {
    // if (str.isEmpty) return;
    List<String> binary = str.codeUnits
        .map((int strInt) => strInt.toRadixString(2).padLeft(8, '0'))
        .toList();
    _convertController.setBinary(binary);
  }

  @override
  Widget build(BuildContext context) {
    _convertController = Provider.of<ConvertController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Text to Binarys'),
        centerTitle: true,
      ),
      body: _body(context),
      bottomNavigationBar: _copyButton(context),
    );
  }

  Widget _body(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _inputForm,
            _convertButton,
            _resultBinary,
          ],
        ),
      );

  Widget get _inputForm => TerminalContainer(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: TextField(
          controller: _textController,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Type your String'),
          maxLines: 7,
        ),
      ),
      closePress: () => _textController.text = '');

  Container get _convertButton => Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        child: RaisedButton(
          color: ColorUtils.terminalBackground,
          child: Text('Convert'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          onPressed: () => _convertToBinary(_textController.text),
        ),
      );

  Widget get _resultBinary => TerminalContainer(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Consumer<ConvertController>(
            builder: (context, convert, child) {
              return GridView.builder(
                shrinkWrap: true,
                itemCount: convert.binary.length,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: 16 / 4),
                itemBuilder: (context, index) {
                  return Text(
                    '${convert.binary[index]}',
                    textAlign: TextAlign.start,
                  );
                },
              );
            },
          ),
        ),
        closePress: () => _convertController.clear(),
      );

  Container _copyButton(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        child: Builder(
          builder: (context) => RaisedButton(
            color: ColorUtils.terminalBackground,
            child: Text('Copy to clipboard'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            onPressed: () {
              if (_convertController.binary.length > 0)
                copyToClipboard(
                  context,
                  data: _convertController.binary
                      .toString()
                      .replaceAll('[', '')
                      .replaceAll(']', '')
                      .replaceAll(',', ''),
                );
            },
          ),
        ),
      );
}
