import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState(){
    super.initState();
    Timer(const Duration(milliseconds: 2200),(){
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.cyan,
      child: Center(
        child: Icon(Icons.co_present,color: Colors.black,),
      ),
    );
  }
}
