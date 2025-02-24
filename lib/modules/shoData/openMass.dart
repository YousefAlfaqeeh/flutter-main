
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/models/history.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/shareWid.dart';

class DataMasseg extends StatelessWidget {

  String name,date_notif,text_data,tit;
  List<Attachments> data;
  DataMasseg(this.name,this.text_data,this.date_notif,this.tit,this.data);

  @override
  Widget build(BuildContext context) {
    RichText richText;
    richText=RichText(
        text: TextSpan(
          children:inlineSpanText(text_data,context),));


    return Scaffold(
        bottomNavigationBar: CustomBottomBar(
            "images/icons8_four_squares.svg",
            "images/icons8_home.svg",
            "images/picup_empty.svg",
            "images/icon_feather_search.svg",
            "images/bus.svg",
            Color(0xff98aac9),
            Color(0xff98aac9),
            Color(0xff98aac9),
            Color(0xff98aac9),
            Color(0xff98aac9)),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(width:100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Text(date_notif)]),
            ),
            Text(name),
              SizedBox(height:10,),
            Text(tit),
            SizedBox(height:10,),
            Container(height:50.h,color: Colors.white,width: 100.w
              ,
                child:richText
                // Text(text_data),
            )
              ,
            Expanded(
              child: Container(height: 20.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:data.length ,
                itemBuilder: (context, index) {

                  return InkWell(
                    onTap: () async {

                      openAtta(data[index].datas.toString(), context, name);
                    },
                    child:Container(

                        padding:
                        EdgeInsets.symmetric(horizontal: 10),
                        child:Column(

                          children: [
                            data[index].datas.toString().contains('.png') || data[index].datas.toString().contains('.jpg')  || data[index].datas.toString().contains('.jpeg')?Image.network( data[index].datas.toString(),width: 15.w,height: 7.h,):  data[index].datas.toString().contains('.pdf')?
                            SvgPicture.asset('images/pdf.svg',width: 13.w,): data[index].datas.toString().split('.').last=='mp4'?SvgPicture.asset('images/icons8_video_file.svg',width: 13.w,):data[index].datas.toString().split('.').last=='mp3'|| data[index].datas.toString().split('.').last=='mpeg'?Image.asset('images/speaker.png',width: 13.w ,):SvgPicture.asset('images/icons8_file.svg',width: 13.w,),
                            Container(width: 10.w,
                                child:  Text(data[index].name.toString()
                                ,
                                overflow:  TextOverflow.ellipsis,
                                )
                            )

                          ],
                        )
                    ) ,
                  ) ;

                },
              ) ,
              ),
            )
          ],)
        ),
      ),
);
  }
}



