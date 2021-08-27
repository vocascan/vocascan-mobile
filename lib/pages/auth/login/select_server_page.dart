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
  TextEditingController _serverUrlController = new TextEditingController();
  StorageService _storageService = StorageService.getInstance();
  ApiClientService _apiClientService = ApiClientService.getInstance();

  String _serverVersion = "Loading...";

  @override
  void initState() {
    super.initState();
    String homeServer = _apiClientService.homeServer;
    // Hide the protocol from the user
    homeServer = homeServer.replaceAll(RegExp(httpRegex), "");

    _serverUrlController.text = homeServer;
    this.validateServer(_serverUrlController.text);
   }

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
              Row(
                children: [
                  TextFieldContainer(
                    child: Text(
                        "Server Version: $_serverVersion",
                        textAlign: TextAlign.center
                    ),
                    decoration: BoxDecoration(),
                  ),
                  Icon(
                    _serverValid ? Icons.check : Icons.close,
                    color: _serverValid ? Colors.green : Colors.red,
                  )
                ],
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
    if(!serverUrl.startsWith(RegExp(httpRegex))) {
      serverUrl = "https://$serverUrl";
    }

    if(serverUrl.endsWith("/")) {
      serverUrl = serverUrl.substring(0, serverUrl.length - 2);
    }

    try {
      _apiClientService.setHomeServerUrl(serverUrl);
      final EndpointInfoResponseScheme serverInfo = await _apiClientService.endpointInfo();

      setState(() {
        _serverValid = true;
        _serverVersion = "v${serverInfo.version}";
        _storageService.add('server', serverUrl);
      });

    } on EndpointInfoVersionNotSupported catch(e) {
      setState(() {
        _serverValid = false;
        _serverVersion = e.serverVersion;
      });

    } on EndpointInfoServerNotSupported catch(_) {
      setState(() {
        _serverValid = false;
        _serverVersion = "Unknown";
      });
    } catch(_) {
      setState(() {
        _serverValid = false;
        _serverVersion = "Unknown";
      });
    }
  }
}