import 'package:aerocal/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'dart:math';

bool imperialSelected, metricSelected;
Color getColorHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF' + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

class Ratio extends StatefulWidget {
  @override
  _RatioState createState() => _RatioState();
}

class _RatioState extends State<Ratio> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    setState(() {
      imperialSelected = false;
      metricSelected = true;
    });
  }
  var finalAnswer ;
  String required= 'Pressure', units;
  double number;
  String p = 'Pressure', t = 'Temperature', d = 'Density';
  String i = 'imperial', m = 'metric';


  var P_0_psf = 2116.8;
  var P_0_psi = 14.7;
  var P_0_Pa = 101325;
  var P_0_atm = 1;
//  var P_36080_psf = 473.0232826;
  var P_36080_psf = 473.3159716;
  var P_36080_psi = 3.284883907;
  //  var P_82000_psf = 51.90922594;
//  var P_82000_psf = 52.146401420842516; // fromsystem output
  var P_82000_psf = 52.14640142;
  var P_82000_psi = 0.3604807357;
//  var P_154160_psf = 2.5295899846838985; // from system output
  var P_154160_psf = 2.5295899846838985;
//  var P_173840_psf = 1.2254723844870552; // from system output
  var P_173840_psf = 1.225472385;
//  var P_259120_psf = 0.021287567650763197; // from system output
  var P_259120_psf = 0.02128756766;
//  var P_295200_psf = 0.002208151927201491; // from system output
  var P_295200_psf = 0.002208151928;
  var P_344400_psf = 0.00015798519209960692;


  var P_11000_Pa = 22625.0221;
  var P_11000_atm = 0.2231119993;
  var P_25000_Pa = 2486.742462;
  var P_25000_atm = 0.02452249903;
  var P_47000_Pa = 120.27788;
  var P_47000_atm = 0.00118609556;
  var P_53000_Pa = 58.23262684;
  var P_79000_Pa = 1.007100672;
  var P_90000_Pa = 0.1041462713;


  var rho_0_imp = 0.002377;
  var rho_0_met = 1.225;
//  var rho_36080 = 0.0007066855947714348; // from system output
  var rho_36080 = 0.0007066855948;
  var rho_11000 = 0.3638006285;
  var rho_25000 = 0.0399857497;
  var rho_53000 = 0.0007177202478;
  var rho_79000 = 0.00002117914386;
  var rho_90000 = 0.000002190177134;
//  var rho_82000 = 0.00007785731501666081; // from system output
  var rho_82000 = 0.00007785731502;
//  var rho_154160 = 0.0000028955475615772658; // from system output
  var rho_154160 = 0.000002895547672;
//  var rho_173840 = 0.0000014027623969250975; // from system output
  var rho_173840 = 0.000001402762397;
  var rho_259120 = 0.00000004155679898;
//  var rho_295200 = 0.0000000043106721836103495; // from system output
  var rho_295200 = 0.000000004310672185; // from given example

//  var rho_25000 = pow((7.752626555*10),-5);

  var T_0_R = 519;
  var T_0_K = 288.16;
  var T_36080 = 390.33872;
  var T_11000 = 216.66;
  var T_154160 = 509.13871997008005;
  var T_173840 = 509.13872;
//  var T_259120 = 298.53871998048004;
  var T_259120 = 298.53872;
  var T_344400 = 406.5387199696801;


  var LR_1_imp = -0.003566;
  var LR_1_met = -0.0065;
  var LR_2_imp = 0.001645846154;
  var LR_2_met = 0.003;

  var g_imp = -32.174;
  var g_met = -9.81;
  var R_imp = 1716;
  var R_met = 288.16;
  final GlobalKey<FormState> _formula1Form = GlobalKey<FormState>();
  String dropdownValue = 'Pressure';
  int currentIndex = 0;

  Widget _requiredTextField() {
    return Container(
        margin: EdgeInsets.only(top: 15.0),
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0, bottom: 5.0),
        width: MediaQuery.of(context).size.width-30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              offset: Offset(-1, 1),
              blurRadius: 2,
            ),
          ],
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
              setState(() {
                dropdownValue = newValue;
                required = newValue;
              });
            },
            items: <String>['Pressure', 'Density', 'Temperature']
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

  void changeIndex (int index){
    setState((){
      currentIndex = index;
      print('index= $currentIndex');
    });
  }

  Widget _radioButton(String value, Color color, int index){
    return Expanded(
      child: Container(
        height: 60.0,
        child: FlatButton(
          // change color button if its selected or not
          color: currentIndex == index ? color : Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          onPressed: (){
            changeIndex(index);
            changeIndex(index);
            if(index == 0){
              setState(() {
                imperialSelected = false;
                metricSelected = true;
              });
            }
            else if(index == 1){
              setState(() {
                imperialSelected = true;
                metricSelected = false;
              });
            }
          },
          child: Text(value, style: TextStyle(
            color: currentIndex == index ? Colors.white : Colors.blueGrey,
            fontWeight: FontWeight.bold, fontSize: 18

          ),),
        ),
      ),
    );
  }

  Widget _number() {
    return Container(
      width: MediaQuery.of(context).size.width-30,
//      decoration: BoxDecoration(
//          border: Border.all(color:Colors.grey, width: 1),
//          borderRadius: BorderRadius.circular(15)
//      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.black,  width: 1.5)),
          focusedBorder: new OutlineInputBorder(
              borderSide: new BorderSide(color:  getColorHex("#2592b3"), width: 1.5)),
//            enabledBorder: InputBorder.none,
          errorBorder: OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.red,  width: 1.5)),
          disabledBorder: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          labelText: "Enter number",
        ),
        validator: (String val) {
          if (val.isEmpty) {
            return "Number is required";
          }
          return null;
        },
        onChanged: (String val) {
          number = double.parse(val);
        },
        onSaved: (String value) {
          number = double.parse(value);
        },
      ),
    );
  }

  Widget _calculate() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width-30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: getColorHex('#fa7b20'),
      ),
      child: FlatButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (!_formula1Form.currentState.validate()) {
            return;
          } else {

            _formula1Form.currentState.save();

            print(required);
            currentIndex == 1 ? print('macau imperial') :  print('metric');
            print(number.toString());


            // IMPERIAL
            if (currentIndex == 1) {

              if (number <= 36080) {

                print(required);
                if (required == p) {

                  print((P_0_psf * (pow((1 + ((LR_1_imp)*(number) / T_0_R) ), g_imp/(LR_1_imp*(R_imp))))/2116.8) );

                  // CHECK PSI
                  setState(() {
                    finalAnswer = '${(P_0_psf * (pow((1 + ((LR_1_imp)*(number) / T_0_R) ), g_imp/(LR_1_imp*(R_imp))))/2116.8)} or ${((P_0_psf * (pow((1 + ((LR_1_imp)*(number) / T_0_R) ), g_imp/(LR_1_imp*(R_imp)))))/144)/14.7} ';
                  });

                } else if (required == d) {

                  print(rho_0_imp * (pow((1 + ((LR_1_imp)*(number) / T_0_R) ), (g_imp/(LR_1_imp*R_imp))-1 )));

                  setState(() {
                    finalAnswer = '${(rho_0_imp * (pow((1 + ((LR_1_imp)*(number) / T_0_R) ), (g_imp/(LR_1_imp*R_imp))-1 ))/0.002377)}';
                  });

                } else if (required == t) {

                  print('${T_0_R + (LR_1_imp * number)} °R');

                  setState(() {
                    finalAnswer = '${(T_0_R + (LR_1_imp * number))/519}';
                  });

                }
              } else if (number > 36080 && number <= 82000) {

                if (required == p) {

                  print('${P_36080_psf * (pow(e, ((g_imp / (R_imp * T_36080)) * (number - 36080))))} psf');

                  setState(() {
                    finalAnswer = '${(P_36080_psf * (pow(e, ((g_imp / (R_imp * T_36080)) * (number - 36080)))))/2116.8} or ${((P_36080_psf * (pow(e, ((g_imp / (R_imp * T_36080)) * (number - 36080)))))/144)/14.7}';
                  });


                } else if (required == d) {

                  print('${rho_36080 * (pow(e, ((g_imp  * (number - 36080) ) / (R_imp * T_36080))))} slug/ft^3');

                  setState(() {
                    finalAnswer = '${(rho_36080 * (pow(e, ((g_imp  * (number - 36080) ) / (R_imp * T_36080)))))/0.002377} ';
                  });


                } else if (required == t) {

                  print('${T_36080} °R');

                  setState(() {
                    finalAnswer = '${T_36080/519}';
                  });

                }
              } else if (number > 82000 && number <= 154160) {

                if (required == p) {

                  print(P_82000_psf * (pow((1 + ((0.001646341463)*(number-82000) / T_36080) ), g_imp/(0.001646341463*(R_imp)))));

                  setState(() {
                    finalAnswer = '${(P_82000_psf * (pow((1 + ((0.001646341463)*(number-82000) / T_36080) ), g_imp/(0.001646341463*(R_imp)))))/2116.8} or ${((P_82000_psf * (pow((1 + ((0.001646341463)*(number-82000) / T_36080) ), g_imp/(0.001646341463*(R_imp)))))/144)/14.7}';
                  });

                } else if (required == d) {

                  print(rho_82000 * (pow((1 + ((0.001646341463)*(number-82000) / T_36080) ), (g_imp/(0.001646341463*R_imp))-1 )));

                  setState(() {
                    finalAnswer = '${(rho_82000 * (pow((1 + ((0.001646341463)*(number-82000) / T_36080) ), (g_imp/(0.001646341463*R_imp))-1 )))/0.002377}';
                  });

                } else if (required == t) {

                  print('${T_36080 + (0.001646341463 * (number - 82000))} °R');

                  setState(() {
                    finalAnswer = '${(T_36080 + (0.001646341463 * (number - 82000)))/519} ';
                  });
                }

              } else if (number > 154160 && number <= 173840) {

                if (required == p) {

                  //CHECK PSI

                  print('${P_154160_psf * (pow(e, ((g_imp / (R_imp * 509.13872)) * (number - 154160))))} psf ');

                  setState(() {
                    finalAnswer = '${(P_154160_psf * (pow(e, ((g_imp / (R_imp * T_154160)) * (number - 154160)))))/2116.8} or ${((P_154160_psf * (pow(e, ((g_imp / (R_imp * T_154160)) * (number - 154160)))))/144)/14.7}';
                  });

                } else if (required == d) {

                  print('${rho_154160 * (pow(e, ((g_imp  * (number - 154160) ) / (R_imp * 509.13872))))} slug/ft^3');

                  setState(() {
                    finalAnswer = '${(rho_154160 * (pow(e, ((g_imp  * (number - 154160) ) / (R_imp * T_154160)))))/0.002377}';
                  });

                } else if (required == t) {

                  print('${T_154160} °R');

                  setState(() {
                    finalAnswer = '${T_154160/519} ';
                  });
                }

              } else if (number > 173840 && number <= 259120) {


                if (required == p) {

                  print(P_173840_psf * (pow((1 + ((-0.002469512195)*(number-173840) / 509.13872) ), g_imp/(-0.002469512195*(R_imp)))));

                  setState(() {
                    finalAnswer = '${(P_173840_psf * (pow((1 + ((-0.002469512195)*(number-173840) / 509.13872) ), g_imp/(-0.002469512195*(R_imp)))))/2116.8} or ${((P_173840_psf * (pow((1 + ((-0.002469512195)*(number-173840) / 509.13872) ), g_imp/(-0.002469512195*(R_imp)))))/144)/14.7}';
                  });

                } else if (required == d) {

                  print(rho_173840 * (pow((1 + ((-0.002469512195)*(number-173840) / T_173840) ), (g_imp/(-0.002469512195*R_imp))-1 )));

                  setState(() {
                    finalAnswer = '${(rho_173840 * (pow((1 + ((-0.002469512195)*(number-173840) / T_173840) ), (g_imp/(-0.002469512195*R_imp))-1 )))/0.002377}';
                  });

                } else if (required == t) {

                  print('${T_173840 + (-0.002469512195 * (number - 173840))} °R');

                  setState(() {
                    finalAnswer = '${(T_173840 + (-0.002469512195 * (number - 173840)))/519}';
                  });
                }


              } else if (number > 259120 && number <= 295200) {


                if (required == p) {

                  print('${P_259120_psf * (pow(e, ((g_imp / (R_imp * T_259120)) * (number - 259120))))} psf ');

                  setState(() {
                    finalAnswer = '${(P_259120_psf * (pow(e, ((g_imp / (R_imp * T_259120)) * (number - 259120)))))/2116.8} or ${((P_259120_psf * (pow(e, ((g_imp / (R_imp * T_259120)) * (number - 259120)))))/144)/14.7}';
                  });

                } else if (required == d) {

                  print('${rho_259120 * (pow(e, ((g_imp  * (number - 259120) ) / (R_imp * T_259120))))} slug/ft^3');

                  setState(() {
                    finalAnswer = '${(rho_259120 * (pow(e, ((g_imp  * (number - 259120) ) / (R_imp * T_259120)))))/0.002377}';
                  });

                } else if (required == t) {

                  print('${T_259120} °R');

                  setState(() {
                    finalAnswer = '${T_259120/519}';
                  });
                }


              } else if (number > 295200 && number <= 344400) {


                if (required == p) {

                  print(P_295200_psf * (pow((1 + ((0.002195121951)*(number-295200) / T_259120) ), g_imp/(0.002195121951*(R_imp)))));

                  setState(() {
                    finalAnswer = '${(P_295200_psf * (pow((1 + ((0.002195121951)*(number-295200) / T_259120) ), g_imp/(0.002195121951*(R_imp)))))/2116.8} or ${((P_295200_psf * (pow((1 + ((0.002195121951)*(number-295200) / T_259120) ), g_imp/(0.002195121951*(R_imp)))))/144)/14.7}';
                  });

                } else if (required == d) {

                  print(rho_295200 * (pow((1 + ((0.002195121951)*(number-295200) / T_259120) ), (g_imp/(0.002195121951*R_imp))-1 )));

                  setState(() {
                    finalAnswer = '${(rho_295200 * (pow((1 + ((0.002195121951)*(number-295200) / T_259120) ), (g_imp/(0.002195121951*R_imp))-1 )))/0.002377} ';
                  });

                } else if (required == t) {

                  print('${T_259120 + (0.002195121951 * (number - 295200))} °R');

                  setState(() {
                    finalAnswer = '${(T_259120 + (0.002195121951 * (number - 295200)))/519} ';
                  });
                }


              }
            }
            // METRIC

            else if (currentIndex == 0) {

              if (number <= 11) {

                if (required == p) {

                  print('${double.parse((P_0_Pa * (pow((T_0_K + (-6.5 * number)) / T_0_K, -9.81/(-0.0065*287.08)))).toStringAsFixed(2))} Pa or  ${double.parse((P_0_atm * pow(((T_0_K - (LR_1_met * number)) / T_0_K), 5.26)).toStringAsFixed(2))} atm');
                  setState(() {
                    finalAnswer = '${(P_0_Pa * (pow((T_0_K + (-6.5 * number)) / T_0_K, -9.81/(-0.0065*287.08))))/101325} or ${((P_0_Pa * (pow((T_0_K + (-6.5 * number)) / T_0_K, -9.81/(-0.0065*287.08))))/101325)/1}';
                  });

                } else if (required == d) {
                  print (rho_0_met * pow((1+ ((-6.5 * number) / T_0_K)), (-9.81/(-0.0065*287.08))-1));

                  setState(() {
                    finalAnswer = '${(rho_0_met * pow((1+ ((-6.5 * number) / T_0_K)), (-9.81/(-0.0065*287.08))-1))/1.225}';
                  });

                } else if (required == t) {

                  print('${T_0_K + -6.5 * number} K');
                  setState(() {
                    finalAnswer = '${(T_0_K + -6.5 * number)/288.16} ';

                  });

                }

              } else if (number > 11 && number <= 25) {

                if (required == p) {

                  setState(() {
                    number = number * 1000;
                    print(P_11000_Pa * (pow(e, ((g_met*(number-11000))/(287.08 * T_11000)))));

                    finalAnswer = '${(P_11000_Pa * (pow(e, ((g_met*(number-11000))/(287.08 * T_11000)))))/101325} or ${((P_11000_Pa * (pow(e, ((g_met*(number-11000))/(287.08 * T_11000)))))/101325)/1}';
                  });


                } else if (required == d) {

                  setState(() {
                    number = number * 1000;
                    print(rho_11000 *( pow(e,(g_met*(number-11000)/ (287.08 * T_11000)))));

                    finalAnswer = '${(rho_11000 *( pow(e,(g_met*(number-11000)/ (287.08 * T_11000)))))/1.225}';
                  });


                } else if (required == t) {

                  print('${T_11000} K');

                  setState(() {
                    finalAnswer = '${T_11000/288.16} ';
                  });

                }

              } else if (number > 25 && number <= 47) {
                print('25-47');
                if (required == p) {

                  number *= 1000;
                  print(P_25000_Pa * (pow((1 + ((0.003)*(number-25000) / 216.66) ), g_met/(0.003*(287.08)))));

                  setState(() {
                    finalAnswer = '${(P_25000_Pa * (pow((1 + ((0.003)*(number-25000) / 216.66) ), g_met/(0.003*(287.08)))))/101325} or ${((P_25000_Pa * (pow((1 + ((0.003)*(number-25000) / 216.66) ), g_met/(0.003*(287.08)))))/101325)/1}';
                  });


                } else if (required == d) {

                  number *= 1000;
                  print(rho_25000 * (pow((1 + ((0.003)*(number-25000) / 216.66) ), (g_met/(0.003*(287.08)))-1 )));

                  setState(() {
                    finalAnswer = '${(rho_25000 * (pow((1 + ((0.003)*(number-25000) / 216.66) ), (g_met/(0.003*(287.08)))-1 )))/1.225}';
                  });

                } else if (required == t) {

                  print('${T_11000 + 3*(number-25)} K');

                  setState(() {
                    finalAnswer = '${(T_11000 + 3*(number-25))/288.16}';
                  });

                }
              } else if (number > 47 && number <= 53){
                if (required == p) {

                  number *= 1000;
                  print(P_47000_Pa * (pow (e, (g_met / (287.08 * 282.66) * (number - 47000)))));

                  setState(() {
                    finalAnswer = '${(P_47000_Pa * (pow (e, (g_met / (287.08 * 282.66) * (number - 47000)))))/101325} or ${((P_47000_Pa * (pow (e, (g_met / (287.08 * 282.66) * (number - 47000)))))/101325)/1}';
                  });

                } else if (required == d) {

                  number *= 1000;
                  print( 0.001482431319 * (pow (e, (g_met / (287.08 * 282.66) * (number - 47000)))));

                  setState(() {
                    finalAnswer = '${(0.001482431319 * (pow (e, (g_met / (287.08 * 282.66) * (number - 47000)))))/1.225}';
                  });

                } else if (required == t) {

                  setState(() {
                    finalAnswer =  '${282.66/288.16} ';
                  });

                }
              } else if (number > 53 && number <= 79){

                if(required == p){
                  number *= 1000;
                  print(P_53000_Pa * (pow((1 + ((-0.0045)*(number-53000) / 282.66) ),g_met/(-0.0045*(287.08)))));
                  setState(() {
                    finalAnswer =  '${(P_53000_Pa * (pow((1 + ((-0.0045)*(number-53000) / 282.66) ),g_met/(-0.0045*(287.08)))))/101325} or ${((P_53000_Pa * (pow((1 + ((-0.0045)*(number-53000) / 282.66) ),g_met/(-0.0045*(287.08)))))/101325)/1} ';
                  });

                } else if (required == d){

                  number *= 1000;
                  print(rho_53000 * (pow((1 + ((-0.0045)*(number-53000) / 282.66) ), (g_met/(-0.0045*(287.08)))-1 )));

                  setState(() {
                    finalAnswer =  '${(rho_53000 * (pow((1 + ((-0.0045)*(number-53000) / 282.66) ), (g_met/(-0.0045*(287.08)))-1 )))/1.225}';
                  });

                } else if (required == t){
                  number *= 1000;
                  print(282.66 + ((-0.0045)*(number-53000)));

                  setState(() {
                    finalAnswer =  '${(282.66 + ((-0.0045)*(number-53000)))/288.16}';
                  });

                }

              } else if (number > 79 && number <= 90){


                if(required == p){

                  number *= 1000;
                  print('${P_79000_Pa * (pow(e, ((g_met / (287.08 * 165.66)) * (number - 79000))))} Pa or ${P_36080_psi * (pow(e, ((g_imp / (R_imp * T_36080)) * (number - 36080))))} psi');

                  setState(() {
                    finalAnswer =  '${(P_79000_Pa * (pow(e, ((g_met / (287.08 * 165.66)) * (number - 79000)))))/101325} or ${((P_79000_Pa * (pow(e, ((g_met / (287.08 * 165.66)) * (number - 79000)))))/101325)/1} ';
                  });

                } else if (required == d){

                  number *= 1000;
                  print( rho_79000 * (pow (e, (g_met / (287.08 * 165.66) * (number - 79000)))));

                  setState(() {
                    finalAnswer =  '${(rho_79000 * (pow (e, (g_met / (287.08 * 165.66) * (number - 79000)))))/1.225}';
                  });

                } else if (required == t){

                  setState(() {
                    finalAnswer =  '${165.66/288.16}';
                  });
                }

              } else if (number > 90 && number <= 105){

                if(required == p){

                  number *= 1000;

                  print(P_90000_Pa * (pow((1 + ((0.004)*(number-90000) / 165.66) ), g_met/(0.004*(287.08)))));

                  setState(() {
                    finalAnswer =  '${(P_90000_Pa * (pow((1 + ((0.004)*(number-90000) / 165.66) ), g_met/(0.004*(287.08)))))/101325} or ${((P_90000_Pa * (pow((1 + ((0.004)*(number-90000) / 165.66) ), g_met/(0.004*(287.08)))))/101325)/1}';
                  });

                } else if (required == d){

                  number *= 1000;
                  print(rho_90000 * (pow((1 + ((0.004)*(number-90000) / 165.66) ), (g_met/(0.004*(287.08)))-1 )));

                  setState(() {
                    finalAnswer =  '${(rho_90000 * (pow((1 + ((0.004)*(number-90000) / 165.66) ), (g_met/(0.004*(287.08)))-1 )))/1.225}';
                  });

                } else if (required == t){

                  print(165.66 + (4*(number-90)));

                  setState(() {
                    finalAnswer =  '${(165.66 + (4*(number-90)))/288.16}';
                  });

                }

              }
            }


          }
        },
        child: Text(
          "CALCULATE",
          style: TextStyle(
              color: Colors.white, fontSize: 18 , fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: getColorHex('#fa7b20'), width: 3.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor:  getColorHex("#ffffff"),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 3.0,
          backgroundColor: Colors.white,
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
                    size: 30,
                    color: Colors.blue,
                  ),
                );
              },
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(top: 5.0),
              padding: EdgeInsets.all(10),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                    Radius.circular(40.0) //
                ),
              ),
              child: Image.asset(
                'assets/logo16.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/mobile85opac2.png"),
                fit: BoxFit.cover,
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, left: 10.0, right: 10.0, bottom: 10.0),
                height: MediaQuery.of(context).size.height/11,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Text("Ratio",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      finalAnswer != null ?
                      Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                          width: MediaQuery.of(context).size.width-30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(-1, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Answer", style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.bold),
                                  maxLines:5),
                              SizedBox(height: 10.0,),
                              Text(finalAnswer, style: TextStyle(color: Colors.black, fontSize: 18,)),
                            ],
                          )) : Container(),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Form(
                            key: _formula1Form,
                            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                              _requiredTextField(),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width-30,
                                child: Row(
                                  children: [
                                    Expanded(child: _number()),
                                    SizedBox(width: 5.0,),
                                    Visibility(
                                        visible: metricSelected,
                                        child: Text("km", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueGrey))),
                                    Visibility(
                                        visible: imperialSelected,
                                        child: Text("ft", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueGrey))),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width-30,
                                child: Row(
                                  children: [
                                    _radioButton('Metric',  getColorHex('#3dabde'), 0),
                                    SizedBox(width: 10.0,),
                                    _radioButton('Imperial',  getColorHex('#3dabde'), 1),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _calculate(),
                            ]),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: SideBar(),
    );
  }
  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
