import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';
import 'package:http/http.dart';

class SelectServerPage extends StatefulWidget{
  final PageController controller;
  SelectServerPage({required this.controller});

  @override
  _SelectServerPageState createState() => _SelectServerPageState();
}

class _SelectServerPageState extends State<SelectServerPage> {
  bool _serverValid = false;
  TextEditingController _serverUrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                "assets/images/illustrations/undraw_upload.svg",
                height: size.height * 0.25,
                width: size.height * 0.25,
              ),
              TextFieldContainer(child: Text("Select your server for synchronization",
                textAlign: TextAlign.center,),
                decoration: BoxDecoration()
              ),
              RoundedInputField(
                controller: _serverUrl,
                onChanged: (String serverUrl) async{
                  try{
                    final response = await get(Uri.parse("$serverUrl/api/info"));
                    setState(() {
                      if (response.statusCode == 200) {
                        final jsonResult = json.decode(response.body);
                        _serverValid = jsonResult.containsKey('identifier');
                      } else {
                        _serverValid = false;
                      }
                    });
                  }
                  catch(_){
                    setState(() {
                      _serverValid = false;
                    });
                  }
                },
                hintText: 'https://domain.com',
                icon: Icons.cloud,
              ),
              RoundedButton(disabled: !_serverValid, text: 'Continue',
                press: () {
                return !_serverValid? null: widget.controller.animateToPage(widget.controller.page!.toInt() + 1,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeIn
                  );
                },
              )
            ],
          ),
        )
    ));
  }
}