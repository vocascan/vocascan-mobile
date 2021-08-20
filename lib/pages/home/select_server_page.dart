import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';

class SelectServerPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController server_url = new TextEditingController();


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
                controller: server_url,
                onChanged: (String value) {  },
                hintText: 'Server',
                icon: Icons.cloud,
              ),
              RoundedButton(text: 'Continue',
                press: () {

                },
              )
            ],
          ),
        )
    ));
  }
}