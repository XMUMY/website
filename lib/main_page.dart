import 'dart:math';
import 'dart:ui';

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
        Text(
          'A powerful app for XMUMers',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4,
        )
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
              Divider(height: 45, color: Colors.transparent),
            ],
          ),
        ],
      ),
    );
  }
}
