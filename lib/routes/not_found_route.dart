import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/widgets/drawer.dart';

class NotFound extends StatefulWidget {
  NotFound({Key? key}) : super(key: key); //
  @override
  _NotFoundState createState() => _NotFoundState();
}

class _NotFoundState extends State<NotFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer().sharedDrawer(context),
      appBar: AppBar(
        title: Text("AppLocalizations.of(context)!.not_found_page_title"),
        centerTitle: true,
      ),
    );
  }
}
