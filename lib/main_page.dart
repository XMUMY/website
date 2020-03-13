import 'dart:math';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final foregroundController = ScrollController();
  var sigma = 0.0;

  @override
  void initState() {
    foregroundController.addListener(() {
      if (mounted)
        setState(() =>
            sigma = min(max((foregroundController.offset - 150) / 15, 0), 6.0));
    });
    super.initState();
  }

  @override
  void dispose() {
    foregroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var logo = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 10,
            child: Image.network(
              'https://s2.ax1x.com/2020/03/03/34hk6I.jpg',
              scale: 1.6,
            ),
          ),
        ),
        TyperAnimatedTextKit(
          text: [
            'A powerful app for XMUMers',
            '为 XMUMers 设计的强大应用',
          ],
          speed: const Duration(milliseconds: 50),
          pause: const Duration(milliseconds: 3000),
          textStyle: TextStyle(fontSize: 30.0, fontFamily: 'Agne'),
          textAlign: TextAlign.left,
          alignment: AlignmentDirectional.topStart,
        ),
      ],
    );

    var downloads = Column(
      children: <Widget>[
        FlatButton(
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () => launch(
              'https://play.google.com/store/apps/details?id=org.ctbeta.xmux.xmux&pcampaignid=MKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'),
          child: Image.network(
            'https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png',
            scale: 2.0,
          ),
        ),
        FlatButton(
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () =>
              launch('https://itunes.apple.com/my/app/xmux/id1366324008'),
          child: Image.network(
            'https://developer.apple.com/app-store/marketing/guidelines/images/badge-download-on-the-app-store.svg',
            scale: 0.45,
          ),
        ),
        Padding(padding: const EdgeInsets.all(10)),
        FlatButton(
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: () => launch(
              'https://www.microsoft.com/zh-cn/p/xmum/9n3mtxt08tv2?cid=storebadge&ocid=badge&rtc=1'),
          child: Image.network(
            'https://assets.windowsphone.com/85864462-9c82-451e-9355-a3d5f874397a/English_get-it-from-MS_InvariantCulture_Default.png',
            scale: 3.3,
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Color(0xFF10052F),
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: LayoutBuilder(
              builder: (context, constraints) => Image.network(
                'https://s2.ax1x.com/2020/03/03/34hutg.jpg',
                fit: constraints.maxWidth / constraints.maxHeight > 16 / 9
                    ? BoxFit.fitWidth
                    : BoxFit.fitHeight,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: Container(),
          ),
          ListView(
            padding: const EdgeInsets.all(10),
            controller: foregroundController,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Divider(
                height: MediaQuery.of(context).size.height / 4.0,
                color: Colors.transparent,
              ),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 30,
                children: <Widget>[
                  logo,
                  downloads,
                ],
              ),
              Divider(height: 60, color: Colors.transparent),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: <Widget>[
                  MainPageCard(
                    imageUrl:
                        'http://www.shejiye.com/uploadfile/icon/2017/0203/shejiyeicontmks240wnx1.png',
                    name: 'XMUX Help Center',
                    url: 'https://docs.xmux.xdea.io',
                  ),
                  MainPageCard(
                    imageUrl: 'https://s1.ax1x.com/2020/03/13/8nLIGn.jpg',
                    name: 'Join Development',
                    url: 'https://docs.xmux.xdea.io/developer/architecture/',
                    imageFit: BoxFit.fitWidth,
                  ),
                ],
              ),
              Divider(height: 60, color: Colors.transparent),
              Center(
                child: Text(
                    'Copyright © 2017-2020 XMUX Project. All rights reserved.'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainPageCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String url;

  final BoxFit imageFit;

  const MainPageCard(
      {Key key,
      this.imageUrl,
      this.name,
      this.url,
      this.imageFit = BoxFit.contain})
      : super(key: key);

  Widget buildCard(BuildContext context) {
    var width = max(350, MediaQuery.of(context).size.width / 4);
    var height = width * 10 / 16;

    return Card(
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: width,
        height: height,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: SizedBox.expand(
                child: Image.network(
                  imageUrl,
                  fit: imageFit,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: OutlineButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () => launch(url),
        child: Builder(builder: buildCard),
      ),
    );
  }
}
