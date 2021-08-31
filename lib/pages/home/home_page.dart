import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vocascan_mobile/constants/colors.dart';
import 'package:vocascan_mobile/pages/widgets/add_vocabulary.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        leading: Icon(Icons.menu),
      ),
      body: Center(
        child: SizedBox(
          height: size.height * 0.25,
          width: size.height * 0.25,
          child: SvgPicture.asset(
            "assets/images/illustrations/undraw_empty.svg",
          ))
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AddVocabularyPopup(

            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor:  primary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(

              )
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(tr("settings")),
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}