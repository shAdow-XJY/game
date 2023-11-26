import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/grid_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var obj = [
    {'gameName': 'tic tac toe', 'imageUrl': 'assets/images/tic_tac_toe.png', 'linkUrl': 'https://shadowplusing.website/tic_tac_toe/'},
    {'gameName': 'snake game', 'imageUrl': 'assets/images/snake_game.png', 'linkUrl': 'https://shadowplusing.website/snake_game/'},
    {'gameName': 'rock paper scissors', 'imageUrl': 'assets/images/rock_paper_scissors.png', 'linkUrl': 'https://shadowplusing.website/rock_paper_scissors/'},
    {'gameName': 'parkour game', 'imageUrl': 'assets/images/parkour_game.png', 'linkUrl': 'https://shadowplusing.website/parkour_game/'},
  ];

  int crossAxisCount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF3E3E61).withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: const Color(0xFF3E3E61),
          elevation: 0,
          centerTitle: false,
          title: const Text(
            'Shadow\'s Game Center',
          ),
          actions: <Widget>[
            IconButton(
              icon: const ImageIcon(AssetImage('assets/icons/GitHub.png')),
              onPressed: () {
                launchUrl(Uri.parse('https://github.com/shAdow-XJY/game'));
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF2E2E48),
            boxShadow: const [BoxShadow()],
          ),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          padding: const EdgeInsets.all(5.0),
          child: ResponsiveBuilder(
              builder: (context, sizingInformation){
                if (sizingInformation.deviceScreenType == DeviceScreenType.mobile){
                  crossAxisCount = 1;
                }else if(sizingInformation.deviceScreenType == DeviceScreenType.tablet){
                  crossAxisCount = 3;
                }
                return GridView.builder(
                    itemCount: obj.length,
                    //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //横轴元素个数
                        crossAxisCount: crossAxisCount,
                        //纵轴间距
                        mainAxisSpacing: 5.0,
                        //横轴间距
                        crossAxisSpacing: 10.0,
                        //子组件宽高长度比例
                        childAspectRatio: 0.9),
                    itemBuilder: (BuildContext context, int index) {
                      //Widget Function(BuildContext context, int index)
                      return GridCard(
                        gameName: obj[index]['gameName']??'',
                        imageUrl: obj[index]['imageUrl']??'', 
                        linkUrl: obj[index]['linkUrl']??'',
                      );

                    });
              }),

        )
    );
  }
}
