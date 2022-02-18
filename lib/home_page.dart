import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bar_chart/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _changingFactor = 0.2;
  String todayDate = DateFormat('MMMd yyyy, E').format(DateTime.now());
  // String todayDate = DateFormat.yMMMEd().format(DateTime.now());
  double _changewine() {
    return _changingFactor;
  }

  void _addWine() {
    if (_changingFactor <= 0.9) {
      _changingFactor += 0.1;
      _changewine();
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Can't add more"),
        duration: Duration(milliseconds: 300),
      ));
    }
  }

  void _removeWine() {
    if (_changingFactor >= 0.1) {
      _changingFactor -= 0.1;
      _changewine();
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No wine left."),
        duration: Duration(milliseconds: 300),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double glassHeight = deviceHeight * 0.35;
    double factor = _changewine();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Icon(
          CupertinoIcons.drop_fill,
          color: primaryTextColor,
        ),
        title: const Text(
          "Add Wine.",
          style: TextStyle(
            color: primaryTextColor,
            fontSize: 22,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 17.0, right: 15),
            child: Text(
              todayDate,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor),
            ),
          )
        ],
        elevation: 1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Glass(glassHeight: glassHeight, factor: factor),
            const SizedBox(height: 20),
            Button(function: _addWine, text: "Add Wine"),
            const SizedBox(height: 5),
            Button(function: _removeWine, text: "Remove wine"),
          ],
        ),
      ),
    );
  }
}

class Glass extends StatelessWidget {
  final double glassHeight;
  final double factor;
  const Glass({
    Key? key,
    required this.glassHeight,
    required this.factor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: glassHeight,
          width: 230,
          decoration: BoxDecoration(
              color: blurColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
        ),
        Positioned(
          bottom: 0,
          left: 1,
          right: 1,
          child: Container(
            height: glassHeight * factor,
            // width: deviceWidth * 0.2,
            color: wineColor,
          ),
        )
      ],
    );
  }
}

class Button extends StatelessWidget {
  final Function function;
  final String text;
  const Button({
    Key? key,
    required this.function,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(wineColor),
        foregroundColor: MaterialStateProperty.all(primaryTextColor),
      ),
      onPressed: () {
        function();
      },
      child: Text(text),
    );
  }
}
