import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class GalleryPage extends StatefulWidget {
  String keyWord = "";
  GalleryPage({this.keyWord});
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  var imagesDate;

  int currentPage  = 1;
  int size= 5;
  List<dynamic> hits=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(widget.keyWord);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void getData(String city) {

    String url = "https://pixabay.com/api/?"
        "key=16582589-68a2e0e5d7a78080a8fa51cbe"
        "&q=${widget.keyWord}"
        "&page=${currentPage}"
        "&per_page=${size}";
        http.get(url).then((onResp) {
       setState(() {
        // hits=json.decode(onResp.body);
        this.imagesDate=json.decode(onResp.body);
        hits=imagesDate['hits'];
      });
     }).catchError((onError){

    });
  }
}
