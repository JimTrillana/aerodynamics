import 'package:aerocal/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'dart:math';

bool imperialSelected, metricSelected;
List <String>subType = [];
int currentIndex = 0;
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
                color: Colors.white,
                offset: Offset(-1, 1),
                blurRadius: 2,
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
  String selectedType;

  void changeIndex (int index){
    setState((){
      currentIndex = index;
      print('index= $currentIndex');
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      currentIndex = 0;
      finalAnswer = null;
      subType.clear();
      imperialSelected = false;
      metricSelected = true;

      dropdownValue2 = "--";
      dropdownValue = "Choose Altitude";
      requiredSubType =  "--";
    });
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

                if(newValue == "Choose Altitude"){
                  setState(() {
                    subType.clear();
                    print(subType);
                    dropdownValue2 = "--";
                    required = newValue;
                  });
                }
                else if(newValue == "Pressure Altitude" && currentIndex == 0){
                  setState(() {
                    subType.clear();
                    subType.add("Pascal");
                    subType.add("atm");
                    print(subType);
                    dropdownValue2 = "Pascal";
                    required = newValue;
                    requiredSubType = "Pascal";
                  });
                }
                else if(newValue == "Pressure Altitude" && currentIndex == 1){
                  setState(() {
                    subType.clear();
                    subType.add("psf");
                    subType.add("psi");
                    print(subType);
                    dropdownValue2 = "psf";
                    required = newValue;
                    requiredSubType = "psf";
                  });
                }
                else if(newValue == "Density Altitude"  && currentIndex == 0){
                  setState(() {
                    subType.clear();
                    subType.add("kgm3");
                    dropdownValue2 = "kgm3";
                    print(subType);
                    required = newValue;
                    requiredSubType = "kgm3";
                  });
                }
                else if(newValue == "Density Altitude"  && currentIndex == 1){
                  setState(() {
                    subType.clear();
                    subType.add("slugft3");
                    dropdownValue2 = "slugft3";
                    requiredSubType = "slugft3";
                    print(subType);
                    required = newValue;
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
        height: 60.0,
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
                requiredSubType = "Pascal";
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
                requiredSubType = "psf";
                required = type;
              });
            }
            else if(type == "Density Altitude"  && index == 0){
              setState(() {
                subType.clear();
                subType.add("kgm3");
                dropdownValue2 = "kgm3";
                requiredSubType = "kgm3";
                print(subType);
                required = type;
              });
            }
            else if(type == "Density Altitude"  && index == 1){
              setState(() {
                subType.clear();
                subType.add("slugft3");
                dropdownValue2 = "slugft3";
                requiredSubType = "slugft3";
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
            fontSize: 18

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

  void _metPressurePascalGradientLayer(double temp, double numInput, double pDen, double a, double ho ) {

    print(double.parse(((((temp*(pow((numInput/pDen),((a*287.08)/-9.81))-1))/a))+ho).toStringAsFixed(3)));

    double ans = double.parse(((((temp*(pow((numInput/pDen),((a*287.08)/-9.81))-1))/a))+ho).toStringAsFixed(3));
//    var removeDecimal = ans.toString().split('.')[0];

    setState(() {
//      finalAnswer = '${int.parse(removeDecimal)} m';
      finalAnswer = '${double.parse((ans).toStringAsFixed(3))} m';
    });

  }

  void _metPressurePascalIsothermalLayer(double temp, double numInput, double pDen, double ho ) {

    print('iso layer');
    print(double.parse(((((287.08*temp)*(log(numInput/pDen)))/-9.81)+ho).toStringAsFixed(3)));

    double ans = double.parse(((((287.08*temp)*(log(numInput/pDen)))/-9.81)+ho).toStringAsFixed(3));
//    var removeDecimal = ans.toString().split('.')[0];

    setState(() {
//      finalAnswer = '${int.parse(removeDecimal)} m';
      finalAnswer = '${double.parse((ans).toStringAsFixed(3))} m';
    });

  }

  void _metPressureAtmGradientLayer(double temp, double numInput, double pDen, double a, double ho ) {

    print('pressure atm gradient');

    double ans = double.parse(((((temp*(pow((numInput/pDen),((a*287.08)/-9.81))-1))/a))+ho).toStringAsFixed(3));
//    var removeDecimal = ans.toString().split('.')[0];

    setState(() {
//      finalAnswer = '${int.parse(removeDecimal)/101325} ';
      finalAnswer = '${double.parse((ans/101325).toStringAsFixed(3))} ';
    });

  }

  void _metPressureAtmIsothermalLayer(double temp, double numInput, double pDen, double ho) {

    print('atm iso layer');

    print(double.parse(((((287.08*temp)*(log(numInput/pDen)))/-9.81)+ho).toStringAsFixed(3)));

    double ans = double.parse(((((287.08*temp)*(log(numInput/pDen)))/-9.81)+ho).toStringAsFixed(3));
//    var removeDecimal = ans.toString().split('.')[0];

    setState(() {
//      finalAnswer = '${int.parse(removeDecimal)/101325} m';
      finalAnswer = '${double.parse((ans/101325).toStringAsFixed(3))} m';

    });

  }


  void _metDensityGradientLayer(double temp, double numInput, double pDen, double a, double ho ) {

    print('here at den grad layer');
    print(double.parse(((temp*( pow((numInput/pDen),(1/(-9.81/(a*287.08)-1))) -1)/a)+ho).toStringAsFixed(3)));

    setState(() {
      finalAnswer = '${double.parse(((temp*( pow((numInput/pDen),(1/(-9.81/(a*287.08)-1))) -1)/a)+ho).toStringAsFixed(3))} m';
    });

  }

  void _metDensityIsothermalLayer(double temp, double numInput, double pDen, double ho ) {

    print('here at den iso layer');
    print(double.parse(((((287.08*temp)*(log(numInput/pDen)))/-9.81)+ho).toStringAsFixed(3)));

    setState(() {
      finalAnswer = '${double.parse(((((287.08*temp)*(log(numInput/pDen)))/-9.81)+ho).toStringAsFixed(3))} m';
    });

  }

  void _impPressurePsfGradientLayer(double temp, double numInput, double pDen, double a, double ho ) {

    print(double.parse(((((temp*(pow((numInput/pDen),((a*1716)/-32.174))-1))/a))+ho).toStringAsFixed(3)));

    double ans = double.parse(((((temp*(pow((numInput/pDen),((a*1716)/-32.174))-1))/a))+ho).toStringAsFixed(3));
//    var removeDecimal = ans.toString().split('.')[0];

    setState(() {
//      finalAnswer = '${int.parse(removeDecimal)} ft';
      finalAnswer = '${double.parse((ans).toStringAsFixed(3))} ft';
    });

  }

  void _impPressurePsfIsothermalLayer(double temp, double numInput, double pDen, double ho ) {

    print('iso layer');
    print(double.parse(((((1716*temp)*(log(numInput/pDen)))/-32.174)+ho).toStringAsFixed(3)));

    double ans = double.parse(((((1716*temp)*(log(numInput/pDen)))/-32.174)+ho).toStringAsFixed(3));
//    var removeDecimal = ans.toString().split('.')[0];

    setState(() {
//      finalAnswer = '${int.parse(removeDecimal)} ft';
      finalAnswer = '${double.parse((ans).toStringAsFixed(3))} ft';
    });

  }

  void _impPressurePsiGradientLayer(double temp, double numInput, double pDen, double a, double ho ) {

    print(double.parse(((((temp*(pow((numInput/pDen),((a*1716)/-32.174))-1))/a))+ho).toStringAsFixed(3)));

    double ans = double.parse(((((temp*(pow((numInput/pDen),((a*1716)/-32.174))-1))/a))+ho).toStringAsFixed(3));
//    var removeDecimal = ans.toString().split('.')[0];

    setState(() {
//      finalAnswer = '${int.parse(removeDecimal)/144} ft';
      finalAnswer = '${double.parse((ans/144).toStringAsFixed(3))} ft';
    });

  }

  void _impPressurePsiIsothermalLayer(double temp, double numInput, double pDen, double ho ) {

    print('iso layer');
    print(double.parse(((((1716*temp)*(log(numInput/pDen)))/-32.174)+ho).toStringAsFixed(3)));

    double ans = double.parse(((((1716*temp)*(log(numInput/pDen)))/-32.174)+ho).toStringAsFixed(3));
//    var removeDecimal = ans.toString().split('.')[0];

    setState(() {
//      finalAnswer = '${int.parse(removeDecimal)/144} ft';
      finalAnswer = '${double.parse((ans/144).toStringAsFixed(3))} ft';
    });

  }

  void _impDensityGradientLayer(double temp, double numInput, double pDen, double a, double ho ) {

    print('here at den grad layer');
    print(double.parse(((temp*( pow((numInput/pDen),(1/(-32.174/(a*1716)-1))) -1)/a)+ho).toStringAsFixed(3)));

    setState(() {
      finalAnswer = '${double.parse(((temp*( pow((numInput/pDen),(1/(-32.174/(a*1716)-1))) -1)/a)+ho).toStringAsFixed(3))} slug/ft^3';
    });

  }

  void _impDensityIsothermalLayer(double temp, double numInput, double pDen, double ho ) {

    print('here at den iso layer');
    print(double.parse(((((1716*temp)*(log(numInput/pDen)))/-32.174)+ho).toStringAsFixed(3)));

    setState(() {
      finalAnswer = '${double.parse(((((1716*temp)*(log(numInput/pDen)))/-32.174)+ho).toStringAsFixed(3))} slug/ft^3';
    });

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
            print(requiredSubType);
            print(number.toString());
            // METRIC
            if (currentIndex == 0) {
              if (required == p){
                if (requiredSubType == 'Pascal'){
                  if (number>=22625.0221 && number<=101325){
                    _metPressurePascalGradientLayer(288.16, number, 101325, -0.0065, 0);
                  } else if (number>=2486.742462 && number<22625.0221){
                    _metPressurePascalIsothermalLayer(216.66, number, 22625.0221, 11000);
                  } else if (number>=120.27788 && number<2486.742462){
                    _metPressurePascalGradientLayer(216.66, number, 2486.742462, 0.003, 25000);
                  } else if (number>=58.23262684 && number<120.27788){
                    _metPressurePascalIsothermalLayer(282.66, number, 120.27788, 47000);
                  } else if (number>=1.007100672 && number<58.23262684){
                    _metPressurePascalGradientLayer(282.66, number, 58.23262684, -0.0045, 53000);
                  } else if (number>=0.1041462713 && number<1.007100672){
                    _metPressurePascalIsothermalLayer(165.66, number, 1.007100672, 79000);
                  } else if (number>=0.007427951993 && number<0.1041462713){
                    _metPressurePascalGradientLayer(165.66, number, 0.1041462713, 0.004, 90000);
                  }
                }

                else if (requiredSubType == 'atm'){
                  if (number>=22625.0221 && number<=101325){
                    _metPressureAtmGradientLayer(288.16, number, 101325, -0.0065, 0);
                  } else if (number>=2486.742462 && number<22625.0221){
                    _metPressureAtmIsothermalLayer(216.66, number, 22625.0221, 11000);
                  } else if (number>=120.27788 && number<2486.742462){
                    _metPressureAtmGradientLayer(216.66, number, 2486.742462, 0.003, 25000);
                  } else if (number>=58.23262684 && number<120.27788){
                    _metPressureAtmIsothermalLayer(282.66, number, 120.27788, 47000);
                  } else if (number>=1.007100672 && number<58.23262684){
                    _metPressureAtmGradientLayer(282.66, number, 58.23262684, -0.0045, 53000);
                  } else if (number>=0.1041462713 && number<1.007100672){
                    _metPressureAtmIsothermalLayer(165.66, number, 1.007100672, 79000);
                  } else if (number>=0.007427951993 && number<0.1041462713){
                    _metPressureAtmGradientLayer(165.66, number, 0.1041462713, 0.004, 90000);
                  }
                }
              }
              else if (required == d) {
                if (number>=0.3638006285 && number<=1.225){
                  _metDensityGradientLayer(288.16, number, 1.225,-0.0065 , 0);
                } else if (number>=0.0399857497 && number<0.3638006285){
                  _metDensityIsothermalLayer( 216.66, number, 0.3638006285, 11000 );
                } else if (number>=0.001482431319 && number<0.0399857497){
                  _metDensityGradientLayer(216.66, number, 0.0399857497,0.003 , 25000);
                } else if (number>=0.0007177202478 && number<0.001482431319) {
                  _metDensityIsothermalLayer( 282.66, number, 0.001482431319, 47000 );
                } else if (number>=0.00002117914386 && number<0.0007177202478) {
                  _metDensityGradientLayer(282.66, number, 0.0007177202478, -0.0045 , 53000);
                } else if (number>=0.000002190177134 && number<0.00002117914386) {
                  _metDensityIsothermalLayer( 165.66, number, 0.00002117914386, 79000 );
                } else if (number>=0.0000001146747168 && number<0.000002190177134) {
                  _metDensityGradientLayer(165.66, number, 0.000002190177134, 0.004 , 90000);
                }
              }


              // IMPERIAL
            } else if (currentIndex == 1) {
              if (required == p){
                if (requiredSubType == 'psf'){
                  if (number>=473.3159716 && number<=2116.8){
                    _impPressurePsfGradientLayer(519, number, 2116.8, -0.003566, 0);
                  } else if (number>=52.14640142 && number<473.3159716){
                    _impPressurePsfIsothermalLayer(390.33872, number, 473.3159716, 36080);
                  } else if (number>=2.529589985 && number<52.14640142){
                    _impPressurePsfGradientLayer(390.33872, number, 52.14640142, 0.001646341463, 82000);
                  } else if (number>=1.225472385 && number<2.52958995){
                    _impPressurePsfIsothermalLayer(509.13872, number, 2.52958995, 154160);
                  } else if (number>=0.02128756766 && number<1.225472385){
                    _impPressurePsfGradientLayer(509.13872, number, 1.225472385, -0.002469512195, 173840);
                  } else if (number>=0.002208151928 && number<0.02128756766){
                    _impPressurePsfIsothermalLayer(298.53872, number, 0.02128756766, 259120);
                  } else if (number>=0.0001579851922 && number<0.002208151928){
                    _impPressurePsfGradientLayer(298.53872, number, 0.002208151928, 0.002195121951, 295200);
                  }
                }

                else if (requiredSubType == 'psi'){
                  if (number>=22625.0221 && number<=101325){
                    _impPressurePsiGradientLayer(519, number, 2116.8, -0.003566, 0);
                  } else if (number>=2486.742462 && number<22625.0221){
                    _impPressurePsiIsothermalLayer(390.33872, number, 473.3159716, 36080);
                  } else if (number>=2.529589985 && number<52.14640142){
                    _impPressurePsiGradientLayer(390.33872, number, 52.14640142, 0.001646341463, 82000);
                  } else if (number>=1.225472385 && number<2.52958995){
                    _impPressurePsiIsothermalLayer(509.13872, number, 2.52958995, 154160);
                  } else if (number>=0.02128756766 && number<1.225472385){
                    _impPressurePsiGradientLayer(509.13872, number, 1.225472385, -0.002469512195, 173840);
                  } else if (number>=0.002208151928 && number<0.02128756766){
                    _impPressurePsiIsothermalLayer(298.53872, number, 0.02128756766, 259120);
                  } else if (number>=0.0001579851922 && number<0.002208151928){
                    _impPressurePsiGradientLayer(298.53872, number, 0.002208151928, 0.002195121951, 295200);
                  }
                }

              }

              else if (required == d) {
                if (number>=0.0007066855948 && number<=0.002377){
                  _impDensityGradientLayer(519, number, 0.002377,-0.003566 , 0);
                } else if (number>=0.00007785731502 && number<0.0007066855948){
                  _impDensityIsothermalLayer( 390.33872, number, 0.0007066855948, 36080 );
                } else if (number>=0.000002895547672 && number<0.00007785731502){ // check number condition
                  _impDensityGradientLayer(390.33872, number, 0.00007785731502, 0.001646341463 , 82000);
                } else if (number>=0.000001402762397 && number<0.000002895547672) {
                  _impDensityIsothermalLayer( 509.13872, number, 0.000002895547672, 154160 );
                } else if (number>=0.00000004155679898 && number<0.000001402762397) {
                  _impDensityGradientLayer(509.13872, number, 0.000001402762397, -0.002469512195 , 173840);
                } else if (number>=0.000000004310672185 && number<0.00000004155679898) {
                  _impDensityIsothermalLayer( 298.53872, number, 0.00000004155679898, 259120 );
                } else if (number>=0.0000000002264806903 && number<0.000000004310672185) {
                  _impDensityGradientLayer( 298.53872, number, 0.000000004310672185, 0.002195121951 , 295200);
                }
              }
            }
          }
        },
        child: Text(
          "CALCULATE",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
          child: Form(
            key: _formula1Form,
            child: Column(
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
                  child:  Center(
                    child: Text("Altitude",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white)),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child:  Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          finalAnswer != null ?
                          Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                              padding: EdgeInsets.all(15),
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
                          Row(
                            children: [
                              _requiredTextField(),
                              subTypeDropDown(),
                            ],
                          ),
                          SizedBox(height: 20,),
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
                          SizedBox(height: 10,),
                          _number(),
                          SizedBox(height: 10,),
                          _calculate(),
                          SizedBox(height:15),
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
