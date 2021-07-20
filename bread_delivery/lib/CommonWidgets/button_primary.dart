import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String function;
  final String textButton;
  final String pathImage;
  final double sizeImage;
  var listPaddingIcon = [];
  var listPaddingText = [];
  final VoidCallback onPressCallback;

  ButtonPrimary(this.function, this.textButton, this.pathImage, this.sizeImage,
      this.listPaddingIcon, this.listPaddingText, this.onPressCallback);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF785841),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(listPaddingIcon[0],
                  listPaddingIcon[1], listPaddingIcon[2], listPaddingIcon[3]),
              child: ImageIcon(
                AssetImage(pathImage),
                size: sizeImage,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(listPaddingText[0],
                  listPaddingText[1], listPaddingText[2], listPaddingText[3]),
              child: Center(
                child: Text(
                  textButton,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        onPressed: () => onPressCallback());
  }
}
