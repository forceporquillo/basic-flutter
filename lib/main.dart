import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(
        child: GradientButton(),
      ),
    ),
  ));
}

class GradientButton extends StatefulWidget {
  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  double _scale = 35.0;
  int _clicked = 0;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
        setState(() {
          _showToast(title: "Button is clicked ");
        });
      });
  }

  void _showToast({String title}) {
    _clicked++;
    Fluttertoast.showToast(
      msg: title + _clicked.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Color(0x0000000),
      textColor: Color(0xFF4B90EB)
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Transform.scale(
        scale: _scale,
        child: _buttonUI(),
      ),
    );
  }

  Widget _buttonUI() {
    return Container(
      width: 300.0,
      height: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        boxShadow: [
          BoxShadow(
              color: Color(0xFF4B90EB).withOpacity(0.35),
              offset: Offset(0.0, 22.0),
              blurRadius: 44.0,
              spreadRadius: -12.0),
        ],
        gradient: LinearGradient(
          colors: const [Color(0xFF4B90EB), Color(0xFFC41494)],
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Henlo fren!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
