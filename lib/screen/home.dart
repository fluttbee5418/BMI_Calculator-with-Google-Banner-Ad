import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../const/app_const.dart';
import '../widget/left_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  static final AdRequest request = const AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  @override
  void initState() {
    super.initState();
    myBanner.load();
  }

  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  double bmiresult = 0;
  String _textResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: TextStyle(
              color: mainHexColor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: mainaccentColor,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: mainHexColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: myBanner.size.width.toDouble(),
              height: myBanner.size.height.toDouble(),
              child: AdWidget(ad: myBanner),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 130,
                  child: SizedBox(
                    height: 70,
                    width: 90,
                    child: Card(
                      color: mainaccentColor,
                      elevation: 10,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _heightController,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Height ",
                            hintStyle: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 130,
                  child: SizedBox(
                    height: 70,
                    width: 90,
                    child: Card(
                      color: mainaccentColor,
                      elevation: 20,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _weightController,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Weight ",
                            hintStyle: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                double h = double.parse(_heightController.text);
                double w = double.parse(_weightController.text);
                setState(() {
                  bmiresult = w / (h * h);
                  if (bmiresult > 25) {
                    _textResult = "You are overweight";
                  } else if (bmiresult >= 18.5 && bmiresult <= 25) {
                    _textResult = "You are normal weight";
                  } else {
                    _textResult = "You are underweight";
                  }
                });
              },
              child: Container(
                child: Text(
                  "Calculate",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: mainaccentColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Card(
              elevation: 20,
              color: mainaccentColor,
              child: Container(
                child: Text(
                  bmiresult.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 90,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Visibility(
              visible: _textResult.isNotEmpty,
              child: SizedBox(
                height: 50,
                width: 290,
                child: Container(
                  child: Text(
                    _textResult,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: mainaccentColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const LeftBar(barWidth: 50),
            const SizedBox(
              height: 30,
            ),
            const LeftBar(barWidth: 90),
            const SizedBox(
              height: 30,
            ),
            const LeftBar(barWidth: 70),
          ],
        ),
      ),
    );
  }
}
