import 'package:flutter/material.dart';
import 'package:escape_life/screens/add_escaperoom/components/body.dart';

class AddEscaperoom extends StatelessWidget {
  const AddEscaperoom({
    this.empresa,
  });

  final String empresa;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        empresa: empresa,
      ),
    );
  }
}
