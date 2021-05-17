import 'package:flutter/material.dart';
import 'package:innosoft/ui/widgets/custom_appbar.dart';

class SoonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Center(
        child: Text("Soon"),
      ),
    );
  }
}
