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
    return Container(
//      decoration: BoxDecoration(
//          image: DecorationImage(
//              image: AssetImage("assets/images/imagegif.gif"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('${widget.keyWord}',
            style: TextStyle(color:Colors.black),
          ),
          centerTitle: true,

        ),



        body: (imagesDate==null?CircularProgressIndicator():
        ListView.builder(
            itemCount: (imagesDate==null?0:hits.length),
            itemBuilder: (context,index){
              return Card(
                child: Container(
                  width: double.infinity,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(hits[index]['tags'],
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                      Container(
                        width: double.infinity,
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Image.network(hits[index]['previewURL'],fit: BoxFit.fitWidth,),
                            ),
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              //   likes
                              Icon(Icons.favorite_border),
                              Text(" ${hits[index]['likes']} ".toString(),),
                              // favorites
                              Icon(Icons.star_border),
                              Text(" ${hits[index]['favorites']} ".toString(),),
                              // comments
                              Icon(Icons.comment),
                              Text(" ${hits[index]['comments']} ".toString(),),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
               );
            })
        ),),
    );
  }

  void getData(String keyWord) {

    String url = "https://pixabay.com/api/?"
        "key=16582589-68a2e0e5d7a78080a8fa51cbe"
        "&q=${keyWord}"
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