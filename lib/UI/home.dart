import 'dart:ffi';

import 'package:flutter/material.dart';

import '../util/hexcolor.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0;

  Color _purple = HexColor("#6908D6");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: _purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Total Per Person',
                        style: TextStyle(
                          fontSize: 20,
                          color: _purple,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          '\$ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}',
                          style: TextStyle(
                            fontSize: 20,
                            color: _purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade100,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                      fontSize: 20,
                      color: _purple,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Bill Amount',
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: _purple,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade400,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Split',
                        style: TextStyle(
                          fontSize: 20,
                          color: _purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState((){
                                if(_personCounter > 1){
                                  _personCounter--;
                                }else{
                                  //do nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.1)
                              ),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: _purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19.0
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text("$_personCounter",
                            style: TextStyle(
                                color: _purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 19
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState((){
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.1)
                              ),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: _purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19.0
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],

                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tip",
                        style: TextStyle(
                          fontSize: 20,
                          color: _purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "\$ ${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}",
                          style: TextStyle(
                              color: _purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 19.0
                          ),
                        ),
                      ),



                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$_tipPercentage%",
                        style: TextStyle(
                          color: _purple,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: _purple,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newValue){
                            setState((){
                              _tipPercentage = newValue.round();

                            });
                          }
                      )

                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage){
    var totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount)/splitBy;
    return totalPerPerson.toStringAsFixed(2);

  }
  calculateTotalTip(double billAmount, int splitBy, int tipPercentage){
    double totalTip = 0.0;
    if(billAmount<0 || billAmount.toString().isEmpty || billAmount == null){

    }else{
      totalTip = (billAmount * tipPercentage)/100;
    }
    return totalTip;
  }
}