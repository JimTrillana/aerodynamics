import 'package:aerocal/altitude.dart';
import 'package:aerocal/homePage.dart';
import 'package:aerocal/layerParam.dart';
import 'package:aerocal/ratio.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

Color getColorHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF' + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/sidebarbg.png"),
              fit: BoxFit.fill,
            )),
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 5.5,
                margin: const EdgeInsets.only(
                  top: 30.0,
                  left: 40,
                  right: 30
                ),
                child: Image.asset(
                  'assets/logo16.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom:15),
                  width: MediaQuery.of(context).size.width,
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Aerodynamic",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: "Poppins", fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20, color: getColorHex("#1d4a78"))),
                      Text("X",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: "Poppins", fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20, color:  getColorHex("#ff7e3d"))),
                    ],
                  )),
              SizedBox(height:35),
              Container(
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: homePage()));
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
                                Text("Home", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                    maxLines:5),
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
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
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
                                AutoSizeText("Layer Parameters", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                    maxLines:5),
                                Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: AutoSizeText("Pressure, Temperature, Density", style: TextStyle(color: Colors.black, fontSize: 13),
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
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
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
                                AutoSizeText("Altitude", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
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
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
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
                                AutoSizeText("Ratio", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
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
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
