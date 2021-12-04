import 'dart:math';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final foregroundController = ScrollController();
  var sigma = 0.0;

  @override
  void initState() {
    foregroundController.addListener(() {
      if (mounted) {
        setState(() =>
            sigma = min(max((foregroundController.offset - 150) / 15, 0), 6.0));
      }
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
            elevation: 10,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Image.network(
              'https://s2.ax1x.com/2020/03/03/34hk6I.jpg',
              scale: 1.6,
            ),
          ),
        ),
        AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              'A powerful app for XMUMers',
              textStyle: const TextStyle(fontSize: 25.0, fontFamily: 'Agne'),
            ),
            TyperAnimatedText(
              '为 XMUMers 设计的强大应用',
              textStyle: const TextStyle(fontSize: 25.0, fontFamily: 'Agne'),
            ),
          ],
          pause: const Duration(milliseconds: 3000),
        ),
      ],
    );

    var downloads = Column(
      children: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => launch(
              'https://play.google.com/store/apps/details?id=org.ctbeta.xmux.xmux&pcampaignid=MKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'),
          child: Image.network(
            'https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png',
            scale: 2.0,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () =>
              launch('https://itunes.apple.com/my/app/xmux/id1366324008'),
          child: Image.network(
            'https://developer.apple.com/app-store/marketing/guidelines/images/badge-download-on-the-app-store.svg',
            scale: 0.43,
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFF10052F),
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
            physics: const BouncingScrollPhysics(),
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
              const Divider(height: 60, color: Colors.transparent),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: const [
                  MainPageCard(
                    imageUrl: 'https://s1.ax1x.com/2020/03/31/Gu47ZV.png',
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
              const Divider(height: 60, color: Colors.transparent),
              const Center(
                child: Text(
                  'Copyright © 2017-2021 XMUX Project. All rights reserved.',
                  textAlign: TextAlign.center,
                ),
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

  const MainPageCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.url,
    this.imageFit = BoxFit.contain,
  }) : super(key: key);

  Widget buildCard(BuildContext context) {
    var width = max(350.0, MediaQuery.of(context).size.width / 4);
    var height = width * 10 / 16;

    return Card(
      margin: const EdgeInsets.all(20),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
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
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => launch(url),
        child: Builder(builder: buildCard),
      ),
    );
  }
}
