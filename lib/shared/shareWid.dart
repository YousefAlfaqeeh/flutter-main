
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/modulesOdoo/custm_pdf.dart';
import 'package:udemy_flutter/modules/webview/audioplayers.dart';
import 'package:udemy_flutter/modules/webview/webV.dart';
import 'package:udemy_flutter/modules/webview/webview_login.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:url_launcher/url_launcher.dart';

void openAtta(String url,BuildContext context,String name)
{
  if (  url.split('.').last=='pdf') {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          PDF(url: url,
            name: name,)),
    );

  }
  else {
    if( url.contains('.mp4')|| url.split('.').last=='mp4') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VideoApp(
                  url: url.toString(),
                ),
          ));
    }

    else if( (url.contains('.png')|| url.split('.').last=='png') ||( url.contains('.jpg')|| url.split('.').last=='jpg')  || (url.contains('.jpeg')|| url.split('.').last=='jpeg')|| (url.contains('.jfif')|| url.split('.').last=='jfif')||(url.split('.').last.contains('.pjp')|| url.split('.').last=='pjp')||(url.contains('.pjpeg')|| url.split('.').last=='pjpeg')||  url.split('.').last=='heic') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OpenImage(
                  url,
                ),
          ));
    }

    else if (url.split('.').last=='mp3'|| url.split('.').last=='mpeg')
    {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CustomAudioPlayer(url)),
      );

    }
    else{

      Fluttertoast.showToast(
          msg: "This file cannot be opened"+url,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }
  }
}

Future<void> openExamAndAss(String token,String answerToken)
async {

  var url = Uri.parse(CacheHelper.getBoolean(key: 'base_url') +
      'survey/start/' +
      token.toString() +
      '?answer_token=' +
      answerToken.toString());
  print(url);
  await launch(url.toString(), headers: {
    "X-Openerp-Session-Id":
    CacheHelper.getBoolean(key: 'sessionId')
  });
}
Map<String, String> extractUrlAndSurroundingText(String text) {
  // Define the regular expression to match URLs
  RegExp regExp = RegExp(
    r"(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+",
    caseSensitive: false,
    multiLine: false,
  );

  // Find the first match of the URL in the given text
  Iterable<Match> matches = regExp.allMatches(text);

  if (matches.isNotEmpty) {
    // Get the first match
    Match match = matches.first;

    // Extract the URL from the match
    String? url = match.group(0);

    // Extract the text before and after the URL
    String textBeforeUrl = text.substring(0, match.start);
    String textAfterUrl = text.substring(match.end);

    // Combine the text before, the URL, and the text after
    String surroundingText = textBeforeUrl + url! + textAfterUrl;

    // Return a map containing the URL and the surrounding text
    return {'url': url!, 'text': surroundingText};
  } else {
    // Return null values if no match is found
    return {'url': '', 'text': ''};
  }
}
List<InlineSpan> inlineSpanText(String text,BuildContext context)
{

  List<InlineSpan> inlineSpan=[];
   text=text.replaceAll(RegExp(r'\s+'), ' ');
  var splitted = text.split(' ');
  for(int i=0;i<splitted.length;i++)
  {
    Map<String, String> getText=  extractUrlAndSurroundingText(splitted[i]);
    // print(getText);
    if(getText['url'].toString().isEmpty) {
      inlineSpan.add(
        TextSpan(
          text: ' ' + splitted[i],
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      );
    }
    else
    {
      inlineSpan.add(
        TextSpan(
            text: ' ' + splitted[i],
            recognizer:
            new TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebView_Login1(getText['url'].toString()),
                    ));
              },
            style: const TextStyle(
              color: Color(0xff3c92d0),

            )),
      );

    }

  }

  return inlineSpan;
}


List<InlineSpan> inlineSpanTextRes(String text,BuildContext context)
{

  List<InlineSpan> inlineSpan=[];
  text=text.replaceAll(RegExp(r'\s+'), ' ');
  var splitted = text.split(' ');
  for(int i=0;i<splitted.length;i++)
  {
    Map<String, String> getText=  extractUrlAndSurroundingText(splitted[i]);
    if(getText['url'].toString().isEmpty) {
      inlineSpan.add(
        TextSpan(
          text: ' ' + splitted[i]+'\n',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      );
    }
    else
    {
      inlineSpan.add(
        TextSpan(
            text: ' ' + splitted[i]+'\n',
            recognizer:
            new TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebView_Login1(getText['url'].toString()),
                    ));
              },
            style: const TextStyle(
              color: Color(0xff3c92d0),

            )),
      );

    }

  }

  return inlineSpan;
}

Widget student_list(int ind, Students listDetail1,String std_id ,MaterialPageRoute pageRoute,BuildContext context) {
  List<Features> listFeatures1 = [];
  if(std_id==listDetail1.id.toString())
  {
    AppCubit.image=listDetail1.avatar.toString();
  }
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: InkWell(
      onTap: () {
        AppCubit.stutes_notif_odoo = '';
        AppCubit.school_image = listDetail1.schoolImage.toString();
        listFeatures1.clear();

        listDetail1.features!.forEach((element) {
          listFeatures1.add(element);
        });

        AppCubit.get(context).setDetalil(
            listDetail1.name,
            listDetail1.studentGrade ?? "",
            listDetail1.schoolName,
            listDetail1.avatar,
            listDetail1.id.toString(),
            listDetail1.schoolLat,
            listDetail1.schoolId.toString(),
            listDetail1.schoolLng,
            listDetail1.pickupRequestDistance.toString(),
            listFeatures1);

        Navigator.push(
          context,
     pageRoute
        );
      },
      child: Row(children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          maxRadius: 5.w,
          backgroundImage: NetworkImage(
            '${listDetail1.avatar}',
          ),
        ),
        SizedBox(
          height: 10,
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${listDetail1.fname}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                  fontSize: 9),
            ),
            Text(
              "${listDetail1.studentGrade}",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Nunito',
                  fontSize: 9),
            ),
          ],
        ),
      ]),
    ),
  );
}


Widget getBox(String title,String external_link,String subject,String description,BuildContext context,bool show_subject_name)
{
  return   Card(
    // width: double.infinity,
    color: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)),
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Container(
      
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 22,
                  color: Color(0xff3c92d0),
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w500)),
          SizedBox(
            height: 4,
          ),
          Visibility(
            visible: show_subject_name,
            child: Row(
              children: [
                Text(AppLocalizations.of(context).translate('Subject'),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(subject.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w300)),
                ),
              ],
            ),
          ),
          Visibility(
              visible: description.toString().isNotEmpty,
              child: SizedBox(
                height: 10,
              )),
          Visibility(
              visible: description.toString().isNotEmpty,
              child: Html(data: """${description}""")),
          Visibility(
              visible: external_link.toString().isNotEmpty,
              child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        color: Colors.black),
                    children:inlineSpanTextRes(external_link,context),))),
          Visibility(visible: external_link.toString().isNotEmpty,
              child: SizedBox(width: double.infinity,))
        ],
      ),
    ),
  );
}


Widget getBoxTeacher(String teacherName,String teacherPosition,String teacherImage,BuildContext context)
{
  return Card(
    color: Colors.white,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      // margin: EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            // alignment: Alignment.centerLeft,
              child: Text(
                  AppLocalizations.of(context).translate('teacher'),
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xff3c92d0),
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500))),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                maxRadius: 20,
                backgroundImage: NetworkImage(
                  teacherImage,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(teacherName.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                color: Colors.black))),
                    Container(
                      // alignment: Alignment.centerLeft,
                        padding:
                        EdgeInsets.symmetric(horizontal: 10),
                        child: Text(teacherPosition.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Nunito',
                                fontSize: 12,
                                color: Color(0xff98aac9)))),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
  );
}





//InkWell(
//                 child: Card(
//                   color: Colors.white,
//                   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8)),
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 5,
//                         ),
//
//                         Container(
//                             // alignment: Alignment.centerLeft,
//                             child: Text(
//                                 AppLocalizations.of(context)
//                                     .translate('Homework_Attachment'),
//                                 style: TextStyle(
//                                     fontSize: 22,
//                                     color: Color(0xff3c92d0),
//                                     fontFamily: 'Nunito',
//                                     fontWeight: FontWeight.w500))),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         InkWell(
//                           onTap: () {
//
//                             downloadFile(ass.link.toString(),
//                                 ass.homeworkName.toString());
//                           },
//                           child: Container(
//                               // margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(3),
//                                   border: Border.all(color: Color(0xffbbc7db))),
//
//                               // margin: EdgeInsets.all(30),
//
//                               alignment: Alignment.center,
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 5),
//                               child: Row(
//                                 children: [
//                                   Image(image: AssetImage("images/pdf123.png")),
//                                   // SvgPicture.asset("images/pdf.svg"),
//                                   // Icon(Icons.cloud_download,),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Expanded(
//                                     child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(ass.homeworkName.toString(),
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: 'Nunito',
//                                                   fontSize: 16,
//                                                   color: Colors.black))
//                                         ]),
//                                   ),
//                                   SvgPicture.asset(
//                                       "images/icons8_download_from_cloud.svg",
//                                       color: Color(0xffbbc7db)),
//                                 ],
//                               )),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )