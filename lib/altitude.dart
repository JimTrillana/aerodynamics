import 'package:aerocal/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';


Color getColorHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF' + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

bool visiblePresAlt, visibleDensityAlt, visibleTempAlt;
class Altitude extends StatefulWidget {
  @override
  _AltitudeState createState() => _AltitudeState();
}

class _AltitudeState extends State<Altitude> {
  final _advancedDrawerController = AdvancedDrawerController();

  var finalAnswer ;
  String required= 'Pressure', units;
  int number;
  String p = 'Pressure', t = 'Temperature', d = 'Density';
  String i = 'imperial', m = 'metric';

  var P_0_psf = 2116.8;
  var P_0_psi = 14.7;
  var P_0_Pa = 101325;
  var P_0_atm = 1;
  var P_36080_psf = 473.0232826;
  var P_36080_psi = 3.284883907;
  var P_11000_Pa = 22606.82333;
  var P_11000_atm = 0.2231119993;
  var P_82000_psf = 51.90922594;
  var P_82000_psi = 0.3604807357;
  var P_25000_Pa = 2484.742214;
  var P_25000_atm = 0.02452249903;
  var P_47000_Pa = 120.18113266237886;
  var P_47000_atm = 0.00118609556;
  var P_53000_Pa = 58.18578656007172;
  var P_79000_Pa = 1.0062905951147092;
  var P_90000_Pa = 0.10406249974039408;

  var rho_0_imp = 0.002377;
  var rho_0_met = 1.225;
  var rho_36080 = 0.0007062485947;
  var rho_11000 = 0.3635080001;
  var rho_25000 = 0.03995358657;
  var rho_53000 = 0.0007171429391894748;
  var rho_79000 = 0.000021162108106425154;
  var rho_90000 = 0.0000021884154338936533;

//  var rho_25000 = pow((7.752626555*10),-5);

  var T_0_R = 519;
  var T_0_K = 288.16;
  var T_36080 = 390.33872;
  var T_11000 = 216.66;

  var LR_1_imp = -0.003566;
  var LR_1_met = -0.0065;
  var LR_2_imp = 0.001645846154;
  var LR_2_met = 0.003;

  var g_imp = -32.174;
  var g_met = -9.81;
  var R_imp = 1716;
  var R_met = 288.16;

  @override
  void initState() {
    super.initState();

    visiblePresAlt = false;
    visibleDensityAlt = false;
    visibleTempAlt = false;
  }

  final GlobalKey<FormState> _formula1Form = GlobalKey<FormState>();
  String dropdownValue = 'Choose Altitude';
  int currentIndex = 0;

  Widget _requiredTextField() {
    return Container(
        margin: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0, bottom: 5.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.0, style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: dropdownValue,
//              hint: Text(dropdownValue),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            isExpanded: true,
            elevation: 16,
//          style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (String newValue) {
              if(newValue == "Choose Altitude"){
                setState(() {
                  visiblePresAlt = false;
                  visibleDensityAlt = false;
                  visibleTempAlt = false;
                  dropdownValue = newValue;
                  required = newValue;
                });
              }
                if(newValue == "Pressure Altitude"){
                  setState(() {
                    visiblePresAlt = true;
                    visibleDensityAlt = false;
                    visibleTempAlt = false;
                    dropdownValue = newValue;
                    required = newValue;
                  });
                }
                if(newValue == "Temperature Altitude"){
                  setState(() {
                    visiblePresAlt = false;
                    visibleDensityAlt = true;
                    visibleTempAlt = false;
                    dropdownValue = newValue;
                    required = newValue;
                  });
                }
                if(newValue == "Density Altitude"){
                  setState(() {
                    visiblePresAlt = false;
                    visibleDensityAlt = false;
                    visibleTempAlt = true;
                    dropdownValue = newValue;
                    required = newValue;
                  });
                }
            },
            items: <String>['Choose Altitude', 'Pressure Altitude', 'Temperature Altitude', 'Density Altitude']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
//          onChanged: (val) {
//            required = val;
//          }),
          ),
        ));
  }

  Widget pressureAlt(){
    return Visibility(
      visible: visiblePresAlt,
        child: Container(
          margin: EdgeInsets.only(top: 15.0, bottom: 10.0, left: 10.0),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    // change color button if its selected or not
                    color: getColorHex('#3dabde'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: (){

                    },
                    child: Text("Pascal", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,

                    ),),
                  ),
                ),
                Container(
                  height: 50.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    // change color button if its selected or not
                    color:getColorHex('#3dabde'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: (){

                    },
                    child: Text("atm", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,

                    ),),
                  ),
                ),
                Container(
                  height: 50.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    // change color button if its selected or not
                    color: getColorHex('#3dabde'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: (){

                    },
                    child: Text("psf", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,

                    ),),
                  ),
                ),
                Container(
                  height: 50.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    // change color button if its selected or not
                    color: getColorHex('#3dabde'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: (){

                    },
                    child: Text("psi", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,

                    ),),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget densityAlt(){
    return Visibility(
        visible: visibleDensityAlt,
        child: Container(
          margin: EdgeInsets.only(top: 15.0, bottom: 10.0, left: 10.0),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    // change color button if its selected or not
                    color:getColorHex('#3dabde'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: (){

                    },
                    child: Text("kgm3", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,

                    ),),
                  ),
                ),
                Container(
                  height: 50.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    // change color button if its selected or not
                    color: getColorHex('#3dabde'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: (){

                    },
                    child: Text("slugft3", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,

                    ),),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget tempAlt(){
    return Visibility(
        visible: visibleTempAlt,
        child: Container(
          margin: EdgeInsets.only(top: 15.0, bottom: 10.0, left: 10.0),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    // change color button if its selected or not
                    color: getColorHex('#3dabde'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: (){

                    },
                    child: Text("kelvin", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,

                    ),),
                  ),
                ),
                Container(
                  height: 50.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: FlatButton(
                    // change color button if its selected or not
                    color: getColorHex('#3dabde'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: (){

                    },
                    child: Text("rankine", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,

                    ),),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void changeIndex (int index){
    setState((){
      currentIndex = index;
      print('index= $currentIndex');
    });
  }

  Widget _radioButton(String value, Color color, int index){
    return Expanded(
      child: Container(
        height: 50.0,
        child: FlatButton(
          // change color button if its selected or not
          color: currentIndex == index ? color : Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          onPressed: (){
            changeIndex(index);
          },
          child: Text(value, style: TextStyle(
            color: currentIndex == index ? Colors.white : Colors.blueGrey,
            fontWeight: FontWeight.bold,

          ),),
        ),
      ),
    );
  }

  Widget _number() {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
//      decoration: BoxDecoration(
//          border: Border.all(color:Colors.grey, width: 1),
//          borderRadius: BorderRadius.circular(15)
//      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.black)),
          focusedBorder: InputBorder.none,
//            enabledBorder: InputBorder.none,
          errorBorder: OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.red)),
          disabledBorder: InputBorder.none,
//            contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//            border: InputBorder.none,
//            border: Border.all(color:Colors.grey, width: 1),
//            prefixIcon: Icon(Icons.lock),
          fillColor: Colors.white,
          filled: true,
          labelText: "Enter number in km",
        ),
        validator: (String val) {
          if (val.isEmpty) {
            return "Number is required";
          } else if (int.parse(val) > 105){
            return "Exceeded maximum number of km (105km)";
          }
          return null;
        },
        onChanged: (String val) {
          number = int.parse(val);
        },
        onSaved: (String value) {
          number = int.parse(value);
        },
      ),
    );
  }

  Widget _calculate() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width-30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: getColorHex('#3dabde'),
      ),
      child: FlatButton(
        onPressed: () {
          if (!_formula1Form.currentState.validate()) {
            return;
          } else {

            _formula1Form.currentState.save();

            print(required);
            currentIndex == 1 ? print('macau imperial') :  print('metric');
            print(number.toString());


            // IMPERIAL
//            if (units == i.toLowerCase()) {
            if (currentIndex == 1) {

              if (number < 36080) {

                print(required);
                if (required == p) {

                  print('${pow(P_0_psf * ((T_0_R - (LR_1_imp * number)) / T_0_R), 5.26)} psf or ${pow(P_0_psi * ((T_0_R - (LR_1_imp * number)) / T_0_R), 5.26)} psi');

                  setState(() {
                    finalAnswer = '${double.parse((pow(P_0_psf * ((T_0_R - (LR_1_imp * number)) / T_0_R), 5.26)).toStringAsFixed(2))} psf or  ${double.parse((pow(P_0_psi * ((T_0_R - (LR_1_imp * number)) / T_0_R), 5.26)).toStringAsFixed(2))} psi';
                  });

                } else if (required == d) {

                  print('${pow(rho_0_imp * ((T_0_R - (LR_1_imp * number)) / T_0_R), 4.26)} slug/ft^3');

                  setState(() {
                    finalAnswer = '${double.parse((pow(rho_0_imp * ((T_0_R - (LR_1_imp * number)) / T_0_R), 4.26)).toStringAsFixed(2))} slug/ft^3';
                  });

                } else if (required == t) {
                  print('${T_0_R - LR_1_imp * number} °R');

                  setState(() {
                    finalAnswer = '${double.parse((T_0_R - LR_1_imp * number).toStringAsFixed(2))} °R';
                  });

                }
              } else if (number > 36080 && number < 82000) {

                if (required == p) {

                  print('${P_36080_psf * (pow(e, ((g_imp / (R_imp * T_36080)) * (number - 36080))))} psf or ${P_36080_psi * (pow(e, ((g_imp / (R_imp * T_36080)) * (number - 36080))))} psi');

                  setState(() {
                    finalAnswer = '${double.parse((P_36080_psf * (pow(e, ((g_imp / (R_imp * T_36080)) * (number - 36080))))).toStringAsFixed(2))} psf or  ${double.parse((P_36080_psi * (pow(e, ((g_imp / (R_imp * T_36080)) * (number - 36080))))).toStringAsFixed(2))} psi';
                  });


                } else if (required == d) {

                  print('${rho_36080 * (pow(e, ((g_imp / (R_imp * T_36080)) * (number - 36080))))} slug/ft^3');

                  setState(() {
                    finalAnswer = '${double.parse((rho_36080 * (pow(e, ((g_imp / (R_imp * T_36080)) * (number - 36080))))).toStringAsFixed(2))} slug/ft^3 ';
                  });


                } else if (required == t) {

                  print('${T_36080} °R');

                  setState(() {
                    finalAnswer = '${double.parse((T_36080).toStringAsFixed(2))} °R ';
                  });

                }
              } else if (number > 82000 && number < 154160) {

                if (required == p) {

                  print('${P_82000_psf * pow(((T_36080 + (LR_2_imp * (number - 82000))) / T_36080), 5.26)} psf or ${P_82000_psi * pow(((T_36080 + (LR_2_imp * (number - 82000))) / T_36080), 5.26)} psi');

                  setState(() {
                    finalAnswer = '${double.parse((P_82000_psf * pow(((T_36080 + (LR_2_imp * (number - 82000))) / T_36080), 5.26)).toStringAsFixed(2))} psf or  ${double.parse((P_82000_psi * pow(((T_36080 + (LR_2_imp * (number - 82000))) / T_36080), 5.26)).toStringAsFixed(2))} psi';
                  });

                } else if (required == d) {

                  print('${0.002377 * pow(((T_36080 - (LR_2_imp * number)) / T_36080), 4.26)} slug/ft^3');

                  setState(() {
                    finalAnswer = '${0.002377 * pow(((T_36080 - (LR_2_imp * number)) / T_36080), 4.26)} slug/ft^3 ';
                  });

                } else if (required == t) {

                  print('${T_36080 - LR_2_imp * number} °R');

                  setState(() {
                    finalAnswer = '${T_36080 - LR_2_imp * number} °R ';
                  });

                }
              }
            }

            // METRIC
//            else if (units == m.toLowerCase()) {
            else if (currentIndex == 0) {

              if (number <= 11) {

                if (required == p) {

                  print('${double.parse((P_0_Pa * (pow((T_0_K + (-6.5 * number)) / T_0_K, 5.26))).toStringAsFixed(2))} Pa or  ${double.parse((P_0_atm * pow(((T_0_K - (LR_1_met * number)) / T_0_K), 5.26)).toStringAsFixed(2))} atm');
                  setState(() {
                    finalAnswer = '${P_0_Pa * (pow((T_0_K + (-6.5 * number)) / T_0_K, 5.26))} Pa';
                  });

//                  var a = P_0_Pa * (pow((T_0_K + (-6.5 * number)) / T_0_K, 5.26));
//                  a = double.parse((a).toStringAsFixed(2));
//                  print(a);

                } else if (required == d) {
                  print (rho_0_met * pow((1+ ((-6.5 * number) / T_0_K)), 4.26));

                  setState(() {
                    finalAnswer = '${rho_0_met * pow((1+ ((-6.5 * number) / T_0_K)), 4.26)} kg/m^3';
                  });

                } else if (required == t) {

                  print('${T_0_K + -6.5 * number} K');
                  setState(() {
                    finalAnswer = '${T_0_K + -6.5 * number} K';

                  });

                }

              } else if (number > 11 && number <= 25) {

                if (required == p) {


                  // CHECK ATM
                  setState(() {
                    number = number * 1000;
                    print(P_11000_Pa * (pow(e, ((g_met*(number-11000))/(287.08 * T_11000)))));

                    finalAnswer = '${P_11000_Pa * (pow(e, ((g_met*(number-11000))/(287.08 * T_11000))))} Pa or  ${double.parse((P_11000_atm * (pow(e, ((g_met / (R_met * T_11000)) * (number - 36080))))).toStringAsFixed(2))} atm';
                  });


                } else if (required == d) {

                  setState(() {
                    number = number * 1000;
                    print(rho_11000 *( pow(e,(g_met*(number-11000)/ (287.08 * T_11000)))));

                    finalAnswer = '${rho_11000 *( pow(e,(g_met*(number-11000)/ (287.08 * T_11000))))} kg/m^3';
                  });


                } else if (required == t) {

                  print('${T_11000} K');

                  setState(() {
                    finalAnswer = '${T_11000} K';
                  });

                }

              } else if (number > 25 && number <= 47) {
                print('25-47');
                if (required == p) {

                  number *= 1000;
                  print(P_25000_Pa * (pow((1 + ((0.003)*(number-25000) / 216.66) ), g_met/(0.003*(287.08)))));

                  setState(() {
                    finalAnswer = '${P_25000_Pa * (pow((1 + ((0.003)*(number-25000) / 216.66) ), g_met/(0.003*(287.08))))} Pa or  ${double.parse((P_25000_atm * pow(((T_11000 + (LR_2_imp * (number - 25000))) / T_11000), 5.26)).toStringAsFixed(2))} atm';
                  });


                } else if (required == d) {

                  number *= 1000;
                  print(rho_25000 * (pow((1 + ((0.003)*(number-25000) / 216.66) ), (g_met/(0.003*(287.08)))-1 )));

                  setState(() {
                    finalAnswer = '${rho_25000 * (pow((1 + ((0.003)*(number-25000) / 216.66) ), (g_met/(0.003*(287.08)))-1 ))} kg/m^3';
                  });

                } else if (required == t) {

                  print('${T_11000 + 3*(number-25)} K');

                  setState(() {
                    finalAnswer = '${T_11000 + 3*(number-25)} K';
                  });

                }
              } else if (number > 47 && number <= 53){
                if (required == p) {

                  number *= 1000;
                  print(120.18113266237886 * (pow (e, (g_met / (287.08 * 282.66) * (number - 47000)))));

                  setState(() {
                    finalAnswer = '${120.18113266237886 * (pow (e, (g_met / (287.08 * 282.66) * (number - 47000))))} Pa';
                  });

                } else if (required == d) {

                  number *= 1000;
                  print( 0.001481238904 * (pow (e, (g_met / (287.08 * 282.66) * (number - 47000)))));

                  setState(() {
                    finalAnswer =  0.001481238904 * (pow (e, (g_met / (287.08 * 282.66) * (number - 47000))));
                  });

                } else if (required == t) {

                  setState(() {
                    finalAnswer =  '282.66 K';
                  });

                }
              } else if (number > 53 && number <= 79){

                if(required == p){
                  number *= 1000;
                  print(P_53000_Pa * (pow((1 + ((-0.0045)*(number-53000) / 282.66) ),g_met/(-0.0045*(287.08)))));
                  setState(() {
                    finalAnswer =  '${P_53000_Pa * (pow((1 + ((-0.0045)*(number-53000) / 282.66) ),g_met/(-0.0045*(287.08))))} Pa';
                  });

                } else if (required == d){

                  number *= 1000;
                  print(rho_53000 * (pow((1 + ((-0.0045)*(number-53000) / 282.66) ), (g_met/(-0.0045*(287.08)))-1 )));

                  setState(() {
                    finalAnswer =  '${rho_53000 * (pow((1 + ((-0.0045)*(number-53000) / 282.66) ), (g_met/(-0.0045*(287.08)))-1 ))} kg/m^3';
                  });

                } else if (required == t){
                  number *= 1000;
                  print(282.66 + ((-0.0045)*(number-53000)));

                  setState(() {
                    finalAnswer =  '${282.66 + ((-0.0045)*(number-53000))} K';
                  });

                }

              } else if (number > 79 && number <= 90){


                if(required == p){

                  number *= 1000;
                  print('${P_79000_Pa * (pow(e, ((g_met / (287.08 * 165.66)) * (number - 79000))))} Pa or ${P_36080_psi * (pow(e, ((g_imp / (R_imp * T_36080)) * (number - 36080))))} psi');

                  setState(() {
                    finalAnswer =  '${P_79000_Pa * (pow(e, ((g_met / (287.08 * 165.66)) * (number - 79000))))} Pa ';
                  });

                } else if (required == d){

                  number *= 1000;
                  print( rho_79000 * (pow (e, (g_met / (287.08 * 165.66) * (number - 79000)))));

                  setState(() {
                    finalAnswer =  '${rho_79000 * (pow (e, (g_met / (287.08 * 165.66) * (number - 79000))))} kg/m^3';
                  });

                } else if (required == t){

                  setState(() {
                    finalAnswer =  '165.66  K';
                  });
                }

              } else if (number > 90 && number <= 105){

                if(required == p){

                  number *= 1000;

                  print(P_90000_Pa * (pow((1 + ((0.004)*(number-90000) / 165.66) ), g_met/(0.004*(287.08)))));

                  setState(() {
                    finalAnswer =  '${P_90000_Pa * (pow((1 + ((0.004)*(number-90000) / 165.66) ), g_met/(0.004*(287.08))))} Pa ';
                  });

                } else if (required == d){

                  number *= 1000;
                  print(rho_90000 * (pow((1 + ((0.004)*(number-90000) / 165.66) ), (g_met/(0.004*(287.08)))-1 )));

                  setState(() {
                    finalAnswer =  '${rho_90000 * (pow((1 + ((0.004)*(number-90000) / 165.66) ), (g_met/(0.004*(287.08)))-1 ))} kg/m^3';
                  });

                } else if (required == t){

                  print(165.66 + (4*(number-90)));

                  setState(() {
                    finalAnswer =  '${165.66 + (4*(number-90))} K';
                  });

                }

              }
            }
          }
        },
        child: Text(
          "CALCULATE",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: getColorHex('#3dabde'), width: 3.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor:  getColorHex("#2592b3"),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0.0,
          backgroundColor: getColorHex("#31a9dd"),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/10,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: getColorHex("#31a9dd"),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                ),
              ),
              child:   Text("Altitude",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins( fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white)),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _requiredTextField(),
                      pressureAlt(),
                      densityAlt(),
                      tempAlt(),
                      _number(),
                      _calculate(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: SideBar(),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
