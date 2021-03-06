import 'package:aerocal/ratio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'altitude.dart';
import 'layerParam.dart';

Color getColorHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF' + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorHex("#ceecf5"),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/bg_opac67.jpg"),
            fit: BoxFit.cover,
            )),
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4.8,
                      margin: EdgeInsets.only(left: 30, right: 30,),
                      child: Image.asset(
                        'assets/logo16.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom:70),
                      width: MediaQuery.of(context).size.width,
                      child:  Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Aerodynamic",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: "Poppins", fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 26, color: getColorHex("#1d4a78"))),
                          Text("X",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: "Poppins", fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 26, color:  getColorHex("#ff7e3d"))),
                        ],
                      )),
                  SizedBox(height:140),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    width: MediaQuery.of(context).size.width-20,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15.0),
                          margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: layerParam()));
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Layer Parameters", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                              maxLines:5),
                                          Container(
                                            child: Text("Pressure, Temperature, Density", style: TextStyle(color: Colors.black, fontSize: 13),
                                              maxLines:2,),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Container(
                                    child: Icon(Icons.arrow_forward_ios),
                                  ),
                                ]),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(15.0),
                          margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: Altitude()));
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Altitude", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                              maxLines:5),
                                          Container(
                                            width: MediaQuery.of(context).size.width/2,
                                            child: Text("Pressure Altitude, Temperature Altitude, Density Altitude", style: TextStyle(color: Colors.black, fontSize: 13),
                                              maxLines:2,),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Container(
                                    child: Icon(Icons.arrow_forward_ios),
                                  ),
                                ]),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(15.0),
                          margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: Ratio()));
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Ratio", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                              maxLines:5),
                                          Container(
                                            width: MediaQuery.of(context).size.width/2,
                                            child: Text("Pressure Ratio, Density Ratio", style: TextStyle(color: Colors.black, fontSize: 13),
                                              maxLines:2,),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Container(
                                    child: Icon(Icons.arrow_forward_ios),
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(height:10),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }


}

