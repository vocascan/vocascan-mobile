import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/constants/versions.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';
import 'package:http/http.dart';
import 'package:vocascan_mobile/services/api_client.dart';
import 'package:vocascan_mobile/services/storage.dart';


class SelectServerPage extends StatefulWidget{
  final PageController controller;
  SelectServerPage({required this.controller});

  @override
  _SelectServerPageState createState() => _SelectServerPageState();
}

class _SelectServerPageState extends State<SelectServerPage> {
  bool _serverValid = false;
  TextEditingController _serverUrlController = new TextEditingController();

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
                controller: _serverUrlController,
                onChanged: (String serverUrl) async{
                  validateServer(serverUrl);
                },
                hintText: 'Server',
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

  void validateServer(String serverUrl) async{
    try {
      ApiClientService.getInstance().setHomeServerUrl("https://$serverUrl");
      final ApiResponse response = await ApiClientService.getInstance().request("info", new Object(), false, HTTPMethod.GET);
      final Map jsonResponse = response.data;

      if(response.response.statusCode == 200 && jsonResponse.containsKey("identifier") && jsonResponse.containsKey("version") && jsonResponse["identifier"] == "vocascan-server" && supportedVersions.contains(jsonResponse["version"])) {
        setState(() {
          _serverValid = true;
          StorageService.getInstance().add('server', _serverUrlController.text);
        });
      } else {
        setState(() {
          _serverValid = false;
        });
      }
    } catch(_) {
      setState(() {
        _serverValid = false;
      });
    }
  }
}