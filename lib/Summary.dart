import 'package:demo/CheckboxList.dart';
import 'package:demo/Submitted.dart';
import 'package:flutter/material.dart';
import 'package:demo/home.dart';

class Summary extends StatefulWidget {
  //Data from last page(CheckboxList.dart)
  final CheckboxData checkboxData;
  Summary({Key  key, this.checkboxData}) : super (key: key);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {

  //List of strings which print on the screen
  List review = new List();
  List symList = ['Fever, ', 'Chill, ', 'Sore throat, ','No symptoms'];
  //Symptoms that the user has
  String syms = '';
  //User health status is true as default
  bool isHealth = true;

  Container showReview(){
    Container container = new Container(
      child: Column(
        children: <Widget>[
          Container(//review with colored border
            margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20
            ),
            height: 400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.green)
            ),
            child: Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(review[0],style: new TextStyle(fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(review[1],style: new TextStyle(fontSize: 20),),
                  ),
                  Padding(padding: const EdgeInsets.all(15),),
                  Text('You have following symptoms:',style: new TextStyle(fontSize: 20),),
                  Text(syms),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              top: 40
            ),
              child: Row(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 140,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red[900])),
                    onPressed:(){
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => Home()),
                              (route) => route == null);
                    },
                    color: Colors.red[900],
                    child: Text('Cancel'),
                  ),
                ),

                Padding(padding: EdgeInsets.all(20),),
                ButtonTheme(
                  minWidth: 140,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.green)),
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => Home(isHealth: isHealth,)),
                              (route) => route == null);
                    },
                    color: Colors.green,
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
    return container;
  }

  void addReview(){
    if (widget.checkboxData.eme){
      isHealth = false;
      review.add('You are currently experiencing emergent issues.');
    } else{
      review.add('You are not experiencing emergent issues.');
    }
    if (widget.checkboxData.close){
      isHealth = false;
      review.add('You have been in close physical contact with someone who test positive for COVID-19.');
    } else{
      review.add('You did not contact with someone who test positive for COVID-19.');
    }
    for(var i = 0; i < symList.length;i++) {
      if (widget.checkboxData.symptoms[i]) {
        if(i < syms.length-1) isHealth = false;// user has some symptoms
        syms = syms + symList[i];
      }
    }
    var pos = syms.lastIndexOf(',');
    syms = (pos != -1)? syms.substring(0, pos): syms;
    syms += '.';
  }

  @override
  void initState() {
    // TODO: implement initState
    addReview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Review',),backgroundColor: Colors.green,centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            showReview(),
          ],
        )

      ),
    );
  }
}


