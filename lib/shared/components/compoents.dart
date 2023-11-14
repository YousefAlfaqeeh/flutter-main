import 'package:flutter/material.dart';


Widget dialog(
    {
    required String massage,
      required Widget title,
    required Function function}) {
  Function function1 = function;
  return AlertDialog(
    title: Container(
        height: 50,
        width: 50,
        alignment: Alignment.topCenter,
        child: Expanded(child: title)),
    content: Container(
      child: Text(massage),
    ),
    actions: [
      Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: oKButton(function: function),
      )
    ],
  );
}

Widget callButton({required Function function}) {
  return Container(
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(),
    child: Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          // boxShadow: [ BoxShadow(color: Colors.black,blurRadius: 10,spreadRadius: 20)],
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(10)),
      child: MaterialButton(
        child: Row(
          children: [
            SizedBox(
              width: 11,
            ),
            Icon(
              Icons.call,
              size: 30.0,
              color: Colors.green,
            ),
            VerticalDivider(
              color: Colors.green,
              width: 40,
              thickness: 3,
              indent: 7,
              endIndent: 7,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "Trackware School",
                    style: TextStyle(color: Colors.green),
                  ),
                  Text(
                    "Trackware School",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
        onPressed: () {},
      ),
    ),
  );
}

Widget oKButton({required Function function}) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(40)),
    child: MaterialButton(
      child: const Text(
        "OK",
        style: TextStyle(color: Colors.green),
      ),
      onPressed: () {},
    ),
  );
}

Widget cancelButton({required Function function}) {
  return Container(
    child: MaterialButton(
      child: const Text(
        "CANCEL",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {

        function;
      },
    ),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(40)),
  );
}

Widget dialog_sure(
    {required String massage,
    required Function functionCancel,
    required Function functionOK}) {
  return AlertDialog(
    title: Container(
      child: Text(massage),
    ),
    actions: [
      Container(
        width: double.infinity,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          cancelButton(function: functionCancel),
          oKButton(function: functionOK)
        ]),
      )
    ],
  );
}

Widget dialog_call(
    {required Function functionCancel,
    required Function functionCAll,
    required String school_name,
    required String school_number}) {
  return AlertDialog(
    actions: [
      Container(
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          callButton(function: functionCAll),
          cancelButton(function: functionCancel),
        ]),
      )
    ],
  );
}

Widget dialog_feedback(
    {required Function functionCancel, required Function functionOK}) {
  return AlertDialog(
    title: Container(
      alignment: Alignment.center,
      child: Text('Feedback'),
    ),
    actions: [
      Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Material(
                type: MaterialType.transparency,
                child: Ink(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0)),
                  //<-- SEE HERE
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100.0),
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.sentiment_very_satisfied,
                        size: 40.0,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Material(
                type: MaterialType.transparency,
                child: Ink(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0)),
                  //<-- SEE HERE
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100.0),
                    onTap: () {
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.sentiment_neutral,
                        color: Colors.amber,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Material(
                type: MaterialType.transparency,
                child: Ink(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0)),
                  //<-- SEE HERE
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100.0),
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  ),
                ),
              )
            ]),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white10,
                ),
              ),
              child: Center(
                child: TextFormField(
                  maxLines: 60,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: "Enter  feedback",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1))),
                  // controller: feedback,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  oKButton(function: functionOK),
                  cancelButton(function: functionCancel),
                ],
              ),
            ),
          ],
        ),
      )
    ],
  );
}
