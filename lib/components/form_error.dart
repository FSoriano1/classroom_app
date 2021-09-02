import 'package:flutter/material.dart';

import '../size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          List.generate(errors.length, (index) => formErrorText(errors[index])),
    );
  }

  Row formErrorText(String error) {
    return Row(children: [
      SizedBox(width: getProportionalScreenWidth(10)),
      Text(error, style: TextStyle(color: Colors.red))
    ]);
  }
}
