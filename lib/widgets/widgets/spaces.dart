import 'package:flutter/material.dart';


///Creates a divider, can use where is required
class DividerSpace extends StatelessWidget {
  const DividerSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  const [
        SizedBox(
          height: 15,
        ),
        Divider(
          height: 10,
          thickness: 2,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class DividerSpace2 extends StatelessWidget {
  const DividerSpace2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  const [
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 10,
          thickness: 2,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
