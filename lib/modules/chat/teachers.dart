import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/conversation.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/chat/chatDetail.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
class ChatPage extends StatefulWidget {
  String std_id;
  ChatPage({required this.std_id});
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Widget> student=[];
  TextEditingController search = TextEditingController();
  List<Teachers> list_Teachers_Search=[];
  onSearchTextChanged(String text)async
  {
    list_Teachers_Search.clear();
    if(text.isEmpty)
    {
      setState(() {

      });
      return;
    }
    AppCubit.teachers.forEach((element) {
      if(element.teacherName.toString().contains(text))
      {
        list_Teachers_Search.add(element);
      }
    });

    setState(() {


    });
  }

  @override
  Widget build(BuildContext context) {
    student.clear();
    CacheHelper.saveData(key: 'new_chat'+widget.std_id, value: false);
    for(int i=0;i<AppCubit.list_st.length;i++)
    {
      //
      setState(() {

        student.add(student_list(i, AppCubit.list_st[i]));
      });

    }
    return BlocProvider(create: (context) => AppCubit()..getallConversation(widget.std_id),
      child: BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
        FirebaseMessaging.onMessageOpenedApp.listen((event) {
          setState(() {
            AppCubit()..getallConversation(widget.std_id);

          });

        });

        FirebaseMessaging.onMessage.listen((event) {


          setState(() {
            AppCubit()..getallConversation(widget.std_id);

          });
        });


        return WillPopScope(
          onWillPop: ()async {
            Reset.clear_searhe();
            if(AppCubit.back_home) {
              AppCubit.back_home=false;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Hiome_Kids()),
              );
            }
            else {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => New_Detail()),
              );
            }
            return false;
          },
          child: Scaffold(

            appBar: CustomAppBar(student, AppLocalizations.of(context).translate('Messages')),

            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                    child: TextField(
                      controller: search,
                      onChanged:  onSearchTextChanged,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).translate('search'),
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        // prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                        filled: true,
                        fillColor:Color(0xffeaeef3),
                        contentPadding: EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.grey.shade100
                            )
                        ),
                      ),
                    ),
                  ),
                 search.text.isNotEmpty? ListView.builder(
                   itemCount: list_Teachers_Search.length,
                   shrinkWrap: true,
                   padding: EdgeInsets.only(top: 16),
                   physics: NeverScrollableScrollPhysics(),
                   itemBuilder: (context, index){
                     return ConversationList(
                       name: list_Teachers_Search[index].teacherName.toString(),
                       messageText: list_Teachers_Search[index].text.toString(),
                       imageUrl: list_Teachers_Search[index].image.toString(),
                       time: list_Teachers_Search[index].date.toString(),
                       isMessageRead: list_Teachers_Search[index].isMessageRead!,
                       std: widget.std_id,
                       t_id: list_Teachers_Search[index].teacherId.toString(),
                     );
                   },
                 ): ListView.builder(
                    itemCount: AppCubit.teachers.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return ConversationList(
                        name: AppCubit.teachers[index].teacherName.toString(),
                        messageText: AppCubit.teachers[index].text.toString(),
                        imageUrl: AppCubit.teachers[index].image.toString(),
                        time: AppCubit.teachers[index].date.toString(),
                        isMessageRead: AppCubit.teachers[index].isMessageRead!,
                        std: widget.std_id,
                        t_id: AppCubit.teachers[index].teacherId.toString(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }, listener: (context, state) {

      },),

    );
  }

  Widget student_list(int ind,Students  listDetail1) {



    List<Features> listFeatures1=[];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(

        onTap: () {

          AppCubit.stutes_notif_odoo='';

          listFeatures1.clear();


          listDetail1.features!.forEach((element) {


            listFeatures1.add(element); });

          AppCubit.get(context).setDetalil(listDetail1.name, listDetail1.studentGrade??"", listDetail1.schoolName, listDetail1.avatar, listDetail1.id.toString(),  listDetail1.schoolLat, listDetail1.schoolId.toString(), listDetail1.schoolLng, listDetail1.pickupRequestDistance.toString(), listFeatures1);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatPage( std_id: listDetail1.id.toString(),),),
          );
        },
        child: Row(

            children: [


              CircleAvatar(
                backgroundColor: Colors.transparent ,
                maxRadius: 5.w,


                backgroundImage: NetworkImage('${listDetail1.avatar}', ),

              ),
              SizedBox(height: 10,width: 10,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${listDetail1.fname}",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 9),),
                  Text("${AppCubit.grade}",style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 9),),
                ],
              ),
            ]),
      ),
    );
  }
}





class ConversationList extends StatefulWidget{
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  String t_id;
  String std;

  ConversationList({required this.name,required this.messageText,required this.imageUrl,required this.time,required this.isMessageRead,required this.t_id,required this.std});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ChatDetailPage(teacher_id:widget.t_id ,std:widget.std ,teacher_image: widget.imageUrl,teacher_name: widget.name,);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(widget.messageText,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                SizedBox(height: 10,),
              Visibility(
                visible: widget.isMessageRead,
                child: Row(
                  children: [
                   Container(
                     decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blue),
                     width: 10,
                     height: 10,
                   )
                  ],
                ),
              )


              ],
            ),
          ],
        ),
      ),
    );
  }
}