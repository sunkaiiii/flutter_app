import 'package:flutter/material.dart';
import 'package:flutter_app/heritage/list/heritage_info.dart';
import 'package:flutter/services.dart';

class HeritageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HeritageListPageState();
}

class HeritageListPageState extends State<HeritageList> {
  List<Heritage> heritages = [];
  var host = "http://btbudinner.win:8080";

  @override
  void initState() {
    //进入页面时候请求的接口
    super.initState();
    getHeritageData();
  }

  @override
  Widget build(BuildContext context) {
    //创建list的页面
    var content;
    if (heritages.isEmpty) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      content = new ListView.builder(
        itemBuilder: buildHeritageItem, itemCount: heritages.length,);
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("E迹"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.person), onPressed: () {
            print("onClick");
          })
        ],
      ),
      body: content,
    );
  }

  getHeritageData() async {
    var url = "http://btbudinner.win:8080/GetChannelInformation?divide=%E8%A1%A8%E6%BC%94%E8%89%BA%E6%9C%AF";
    String response = await createHttpClient().read(url);
    setState(() {
      heritages = Heritage.parseFromJson(response);
    });
  }


  //构建每一个item
  buildHeritageItem(BuildContext context, int index) {
    Heritage heritage = heritages[index];
    var heritageImage = new Padding(padding: const EdgeInsets.only(
      top: 10.0,
      left: 10.0,
      right: 10.0,
      bottom: 10.0,
    ),
      child: new Image.network(
          host + heritage.img,
          width: 120.0,
          height: 120.0),
    );
    var heritageTitle = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Text(
          heritage.title,
          textAlign: TextAlign.left,
          style: new TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14.0
          ),
        ),
        new Text("number:" + heritage.number),
        new Text("location:" + heritage.location)
      ],
    );

    var heritageItem = new GestureDetector(
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              heritageImage,
              new Expanded(child: heritageTitle)
            ],
          ),
          new Divider(),
        ],
      ),
    );
    return heritageItem;
  }
}