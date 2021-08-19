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

    return Scaffold(body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SingleChildScrollView(child:
            Flexible(flex: 10, fit: FlexFit.tight,
              child: Flex(direction: Axis.vertical, children: [
                SvgPicture.asset(
                "assets/images/illustrations/undraw_upload.svg",
                height: size.height * 0.25,
                width: size.height * 0.25,),
                TextFieldContainer(child: Text("Select your server for synchronization",
                  textAlign: TextAlign.center,),
                  decoration: BoxDecoration(),)
              ],
          ))),
          Flexible(flex: 5,  child: RoundedInputField(onChanged: (String value) {  },
            hintText: 'Server',
            icon: Icons.cloud,
          )),
          Flexible(flex: 4, child: RoundedButton(text: 'Continue',
            press: () {

            },
          ))
        ],
      ),
    ),);
  }

}