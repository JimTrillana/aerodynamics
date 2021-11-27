import 'package:aerocal/ratio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                      height: MediaQuery.of(context).size.height / 3.5,
                      margin: EdgeInsets.only(
                          left: 30, right: 30, bottom: 5, top: 10.0),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(
                            Radius.circular(40.0) //
                        ),
                      ),
                      child: Image.asset(
                        'assets/logo3.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child:  Text("AerodynamicX",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 25, color: Colors.blueGrey))),
                  SizedBox(height:120),
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

