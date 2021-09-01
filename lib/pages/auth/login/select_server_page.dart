import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/api/schemas/endpoint_info.dart';
import 'package:vocascan_mobile/constants/values.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_button.dart';
import 'package:vocascan_mobile/pages/widgets/rounded_input_field.dart';
import 'package:vocascan_mobile/pages/widgets/text_field_container.dart';
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
  TextEditingController _serverUrlController = TextEditingController();
  StorageService _storageService = StorageService.getInstance();
  ApiClientService _apiClientService = ApiClientService.getInstance();

  @override
  void initState() {
    super.initState();
    String homeServer = _apiClientService.homeServer;
    homeServer = homeServer.replaceAll(RegExp(httpRegex), "");

    _serverUrlController.text = homeServer;
    this.validateServer(_serverUrlController.text);
   }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height * 0.25,
                width: size.height * 0.25,
                child: SvgPicture.asset(
                  "assets/images/illustrations/undraw_upload.svg",
                )
              ),

              TextFieldContainer(child: Text(tr("select_server"),
                textAlign: TextAlign.center,),
              ),
              RoundedInputField(
                controller: _serverUrlController,
                onChanged: (String serverUrl) async{
                  validateServer(serverUrl);
                },
                hintText: tr("server"),
                icon: Icons.cloud,
              ),
              RoundedButton(disabled: !_serverValid, text: tr("continue"),
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
    if(!serverUrl.startsWith(RegExp(httpRegex))) {
      serverUrl = "https://$serverUrl";
    }

    if(serverUrl.endsWith("/")) {
      serverUrl = serverUrl.substring(0, serverUrl.length - 1);
    }

    try {
      _apiClientService.setHomeServerUrl(serverUrl);
      await _apiClientService.endpointGet<EndpointInfo>("info");

      setState(() {
        _serverValid = true;
        _storageService.add('server', serverUrl);
      });
    } catch(_) {
      setState(() {
        _serverValid = false;
      });
    }
  }
}