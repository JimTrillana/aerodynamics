import 'package:aerocal/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

bool imperialSelected, metricSelected;
List <String>subType = [];
final GlobalKey<FormState> _formula1Form = GlobalKey<FormState>();
String dropdownValue = 'Choose Altitude';
String dropdownValue2 = 'Choose';

var finalAnswer ;
String required= 'Pressure', units, requiredSubType;
double number;
String p = 'Pressure Altitude', t = 'Temperature Altitude', d = 'Density Altitude';
String i = 'imperial', m = 'metric';


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

class subTypeDropDown extends StatefulWidget {
  @override
  _subTypeDropDownState createState() => _subTypeDropDownState();
}

class _subTypeDropDownState extends State<subTypeDropDown> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: EdgeInsets.only(top: 15.0, left: 5.0, right: 10.0),
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(-1, 2),
                blurRadius: 1,
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValue2,
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
                  dropdownValue2 = newValue;
                  requiredSubType = newValue;
                });
              },
              items: subType.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )),
    );
  }
}


class _AltitudeState extends State<Altitude> {
  final _advancedDrawerController = AdvancedDrawerController();
  int currentIndex = 0;
  String selectedType;

  void changeIndex (int index){
    setState((){
      currentIndex = index;
      print('index= $currentIndex');
    });
  }

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
  var P_154160_psf = 2.510727083;
  var P_154160_psi = 0.01743560474;
  var P_47000_Pa = 120.1811327;
  var P_47000_atm = 0.00186095561;

  var rho_0_imp = 0.002377;
  var rho_0_met = 1.225;
  var rho_36080 = 0.0007066855948;
  var rho_11000 = 0.3635080001;
  var rho_82000 = 0.00007785731502;
  var rho_25000 = 0.03995358658;
  var rho_154160 = 0.000002895429787;
  var rho_47000 = 0.001481238904;

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
    subType.clear();
    imperialSelected = false;
    metricSelected = true;
  }

  Widget _requiredTextField() {
    return Expanded(
      child: Container(
          margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0),
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(-1, 2),
                blurRadius: 1,
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
                if(newValue == "Choose Altitude"){
                  setState(() {
                    dropdownValue = newValue;
                    required = newValue;
                    subType.clear();
                    print(subType);
                    dropdownValue2 = "--";
                    selectedType = "Choose Altitude";
                  });
                }
                  if(newValue == "Pressure Altitude"){
                    setState(() {
                      dropdownValue = newValue;
                      required = newValue;
                      subType.clear();
                      print(subType);
                      dropdownValue2 = "--";
                      selectedType = "Pressure Altitude";
                    });
                  }
                  if(newValue == "Density Altitude"){
                    setState(() {
                      dropdownValue = newValue;
                      required = newValue;
                      subType.clear();
                      print(subType);
                      dropdownValue2 = "--";
                      selectedType = "Density Altitude";
                    });
                  }
              },
              items: <String>['Choose Altitude', 'Pressure Altitude', 'Density Altitude']
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
          )),
    );
  }

  Widget _radioButton(String value, Color color, int index, String type){

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
            if(type == "Choose Altitude"){
              setState(() {
                subType.clear();
                print(subType);
                dropdownValue2 = "--";
                required = type;
              });
            }
            else if(type == "Pressure Altitude" && index == 0){
              setState(() {
                subType.clear();
                subType.add("Pascal");
                subType.add("atm");
                print(subType);
                dropdownValue2 = "Pascal";
                required = type;
              });
            }
            else if(type == "Pressure Altitude" && index == 1){
              setState(() {
                subType.clear();
                subType.add("psf");
                subType.add("psi");
                print(subType);
                dropdownValue2 = "psf";
                required = type;
              });
            }
            else if(type == "Density Altitude"  && index == 0){
              setState(() {
                subType.clear();
                subType.add("kgm3");
                dropdownValue2 = "kgm3";
                print(subType);
                required = type;
              });
            }
            else if(type == "Density Altitude"  && index == 1){
              setState(() {
                subType.clear();
                subType.add("slugft3");
                dropdownValue2 = "slugft3";
                print(subType);
                required = type;
              });
            }
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
            fontWeight: FontWeight.bold,

          ),),
        ),
      ),
    );
  }

  Widget _number() {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width-30,
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

  void _pressurePascal(int score) {


//    _totalScore += score;
//
//      setState(() {
//        _questionIndex = _questionIndex + 1;
//      });
//
//      print(_questionIndex);

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
            print(requiredSubType);
            print(number.toString());

            if (required == p){

              if (requiredSubType == 'Pascal'){

                if (number>=22625.0221 && number<=101325){


                  print(((288.16*((pow((number/101325),((-0.0065)*(287.08)/-9.81))))-1)/LR_1_met)+0);

                  var a = (pow((22625.0220962355/101325),((-0.0065*287.08)/-9.81)))-1;
                  a = ((288.16 * a ) / -0.0065 ) + 0;
                  print (a);

                  // ROUND OFF DECEMAL 2
//                  print(double.parse(a).toStringAsFixed(2));


                  //print(((288.16 * ((pow((22625.0220962355/101325),((-0.0065*287.08)/-9.81)))-1) ) / -0.0065 ) + 0);

//                  print(double.parse(a).toStringAsFixed(2));

//                  print(T_0_K * (pow((1 + ((0.001646341463)*(number-82000) / T_36080) ), g_imp/(0.001646341463*(R_imp)))));

//                  print (((((number/P_0_Pa)^(1/5.26))-1)*T_0_K)/LR_1_met + "meters");


                } else if (number>=2486.742462 && number<22625.0221){

                  print((((287.08*216.66)*(log(number/22625.0221)))/-9.81)+11000);

                } else if (number>=120.27788 && number<2486.742462){

                  print((((216.66*(pow((number/2486.742462),((0.003*287.08)/-9.81))-1))/0.003))+25000);

                } else if (number>=58.23262684 && number<120.27788){

                  print((((287.08*282.66)*(log(number/120.27788)))/-9.81)+47000);

                } else if (number>=1.007100672 && number<58.23262684){

                  print((((282.66*(pow((number/58.23262684),((-0.0045*287.08)/-9.81))-1))/-0.0045))+53000);

                } else if (number>=0.1041462713 && number<1.007100672){

                  print((((287.08*165.66)*(log(number/1.007100672)))/-9.81)+79000);

                } else if (number>=0.007427951993 && number<0.1041462713){

                  print((((165.66*(pow((number/0.1041462713),((0.004*287.08)/-9.81))-1))/0.004))+90000);

                }



              } else if (requiredSubType == 'atm'){


              }


            } else if (required == d) {

              if (number>=0.3638006285 && number<=1.225){

                print((288.16*( pow((number/1.225),(1/(-9.81/(-0.0065*287.08)-1))) -1)/-0.0065));

              } else if (number>=0.0399857497 && number<0.3638006285){

                print((((287.08*216.66)*(log(number/0.3638006285)))/-9.81)+11000);

              } else if (number>=0.001482431319 && number<0.0399857497){

                print((216.66*( pow((number/0.0399857497),(1/(-9.81/(0.003*287.08)-1))) -1)/0.003)+25000);

              }


            } else if (required == t){

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
      backdropColor:  getColorHex("#ffffff"),
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
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/mobile52opac.png"),
                fit: BoxFit.cover,
              )),
          child: Form(
            key: _formula1Form,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/10,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: getColorHex("#31a9dd"),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
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
                          Row(
                            children: [
                              _requiredTextField(),
                              subTypeDropDown(),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width-30,
                            child: Row(
                              children: [
                                _radioButton('Metric',  getColorHex('#3dabde'), 0, selectedType),
                                SizedBox(width: 10.0,),
                                _radioButton('Imperial',  getColorHex('#3dabde'), 1, selectedType),
                              ],
                            ),
                          ),
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
        ),
      ),
      drawer: SideBar(),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
