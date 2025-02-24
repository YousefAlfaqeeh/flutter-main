import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/chat/chatDetail.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageBinry extends StatelessWidget {
  late Uint8List url;
  String teacher_id;
  String std;
  String teacher_image;
  String teacher_name;
  ImageBinry({required this.url,required this.teacher_id, required this.std,required this.
  teacher_name,required this.teacher_image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // flexibleSpace: ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 0,sigmaY: 0 ))),
        toolbarHeight: 80,
        backgroundColor:Colors.white,
        leadingWidth: double.infinity/4,
        leading: Padding(
          padding:EdgeInsets.only(left: 10,top: 20,bottom: 10,right: 0),
          // padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
          child: Container(

            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(angle:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?9.5:0 ,
                  child:  IconButton(
                    onPressed: () {
                      Reset.clear_searhe();


                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ChatDetailPage(teacher_id:teacher_id ,std:std ,teacher_image: teacher_image,teacher_name: teacher_name,);
                      }));


                    },
                    icon:SvgPicture.asset("images/chevron_left_solid.svg",color:Color(0xff98aac9) ),
                  ),),

                Container(


                  child: Text(AppLocalizations.of(context).translate('Messages'),style: TextStyle(color:Color(0xff3c92d0),fontSize: 28,fontWeight: FontWeight.bold, fontFamily: 'Nunito'   )),

                ),

              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding:EdgeInsets.only(left: 10,top: 20,bottom: 10,right: 20),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent ,
                  maxRadius: 6.w,
                  backgroundImage: NetworkImage('${AppCubit.image}', ),
                ),

              ],
            ),
          ),
        ],








      ),
      body: Image.memory(
        url,
      ),
    );
  }
}
