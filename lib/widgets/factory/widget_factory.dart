import 'package:almighty_pet/custom/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class WidgetFactory{
  Widget createButton(VoidCallback onPressed, String label);
}

class IOsWidgetFactory implements WidgetFactory{
  @override
  Widget createButton(VoidCallback onPressed,String label) {
    return CupertinoButton(
        child: Text(label),
        onPressed: onPressed);
  }
}

class AndroidWidgetFactory implements WidgetFactory{
  @override
  Widget createButton(VoidCallback onPressed, String label) {
    return CustomButton(onPressed: onPressed, label: label);
  }
}

