import 'package:aerocal/altitude.dart';
import 'package:aerocal/homePage.dart';
import 'package:aerocal/layerParam.dart';
import 'package:aerocal/ratio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
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
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 10.0,
                ),
                child: Image.asset(
                  'assets/logo2.png',
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 30.0),
                  child:  Text("AerodynamicX",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueGrey))),

              Container(
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
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
                margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
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
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
