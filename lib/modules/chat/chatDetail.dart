import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/chat.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/chat/teachers.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/modulesOdoo/custm_pdf.dart';
import 'package:udemy_flutter/modules/webview/audioplayers.dart';
import 'package:udemy_flutter/modules/webview/webV.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatDetailPage extends StatefulWidget{
  String teacher_id;
  String std;
  String teacher_image;
  String teacher_name;
  ChatDetailPage({required this.std,required this.teacher_id,required this.teacher_image,required this.teacher_name});
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController myMessage = TextEditingController();
  ScrollController controller1 = new ScrollController();
   List<Messages> messages = [];
  List file = [];
  final list_uplode = GlobalKey();
  bool flg = false;
  ChatTeacher? chatTeacher;
  StreamSubscription? _onMessageSubscription;
  getLastChat( String std,String teacher_id) async {
    String? token;
    if (AppCubit.login_info?.authorization != null) {
      token = AppCubit.login_info?.authorization.toString();
    } else {
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    await DioHelperChat.postData(url: CacheHelper.getBoolean(key: 'base_url')+"get_last_chat_student", data: {
      "jsonrpc":"2:0",
      "params":{
        "student_id":std,
        "teacher_id":teacher_id
      }

    }, token: token).then(
          (value) async {
        chatTeacher = ChatTeacher.fromJson(value.data);
        if(chatTeacher!.result!.messages![0].message_id!=messages[0].message_id) {
          messages.insert(0, chatTeacher!.result!.messages![0]);
          setState(() {
          });
        }

      },
    ).catchError((onError) {
      print(onError);
    });
  }
  @override
  void initState() {
    super.initState();

    _onMessageSubscription = FirebaseMessaging.onMessage.listen((event) {

        getLastChat(widget.std, widget.teacher_id);
        _onMessageSubscription?.cancel();  // Stop listening after the first message

    });
  }
  @override
  void dispose() {
    _onMessageSubscription?.cancel();  // Ensure cleanup if not triggered
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AppCubit()..getChat(widget.std,widget.teacher_id),
      child: BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
        messages=AppCubit.messages;
        _onMessageSubscription = FirebaseMessaging.onMessage.listen((event) {
          getLastChat(widget.std, widget.teacher_id);
          _onMessageSubscription?.cancel();  // Stop listening after the first message
        });



        return WillPopScope(
          onWillPop: ()async {
            Reset.clear_searhe();
            AppCubit.messages=[];
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
                MaterialPageRoute(builder: (context) => ChatPage(std_id: widget.std)),
              );
            }
            return false;
          },
          child: Scaffold(


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
                            AppCubit.messages=[];
                            if(AppCubit.back_home) {
                              AppCubit.back_home=false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChatPage(std_id: widget.std)),
                              );
                            }
                            else {
                              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChatPage(std_id: widget.std)),
                              );
                            }
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
            body: Stack(
              children: <Widget>[
                // test(),
                CupertinoScrollbar(child: ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              // controller: controller,
              reverse: true,

              padding: EdgeInsets.only(top: 10.h,bottom: 13.h),
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return   Column(
                  children: [

                    Visibility(
                      visible:messages[index].messageContent.toString().isNotEmpty,
                      child: Container(
                        padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                        child: Align(
                          alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].messageType == "receiver"?Color(0xffeaeef3):Color(0xff3b91ce)),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(messages[index].messageContent.toString(), style: TextStyle(fontSize: 15,color:messages[index].messageType == "receiver"?Colors.black:Colors.white ) ,),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:messages[index].attachmentFiles!.length>0,
                      child: ListView.builder(
                        itemCount: messages[index].attachmentFiles!.length+1,
                        shrinkWrap: true,
                        controller: controller1,
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, x){

                          if(x<messages[index].attachmentFiles!.length){
                            return InkWell(
                              onTap:() {

                                AppCubit().getUrlAtt(messages[index].attachmentFiles![x].attachmentType! .toString()
                                    , messages[index].attachmentFiles![x].attachmentId! .toString(), messages[index].attachmentFiles![x].attachmentData!).then((v) async {
                                  String generatedPdfFilePath;
                                  Directory appDocDir = await getApplicationDocumentsDirectory();
                                  final targetPath = appDocDir.path;
                                  final targetFileName = "example-pdf";
                                  await launch(AppCubit.resultUrl!.url.toString());
                                  AppCubit().deleteUrlAtt(messages[index].attachmentFiles![x].attachmentName! .toString());
                                });
                                // goPage(AppCubit.messages[index].attachmentFiles![x].attachmentType! .toString().split('.').last, AppCubit.messages[index].attachmentFiles![x].attachmentUrl! , AppCubit.messages[index].attachmentFiles![x].attachmentName!);
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                                child: Align(
                                  alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                                  child: Container(
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: (messages[index].messageType == "receiver"?Color(0xffeaeef3):Color(0xff3b91ce)),
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        messages[index].attachmentFiles![x].attachmentType! .toString().split('.').last=='pdf'  ?SvgPicture.asset('images/pdf.svg',width: 13.w,): messages[index].attachmentFiles![x].toString().split('.').last=='mp4'?SvgPicture.asset('images/icons8_video_file.svg',width: 13.w,):messages[index].attachmentFiles![x].toString().split('.').last=='mp3'|| messages[index].attachmentFiles![x].toString().split('.').last=='mpeg'?Image.asset('images/speaker.png',width: 13.w ,):SvgPicture.asset('images/imageFile.svg',width: 13.w,),

                                        SizedBox(width: 10.w,),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(messages[index].attachmentFiles![x].attachmentName.toString(), style: TextStyle(fontSize: 15,color:messages[index].messageType == "receiver"?Colors.black:Colors.white ) ,),
                                              Text(messages[index].attachmentFiles![x].attachmentSize.toString(), style: TextStyle(fontSize: 15,color:messages[index].messageType == "receiver"?Colors.black:Colors.white ) ,),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );

                          }
                          else
                          {
                            return  SizedBox(height: 5.h,);
                          }
                        },
                      ),
                    ),

                  ],
                );
              },
            ) )
               ,


                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[

                        SizedBox(width: 15,),
                        Expanded(
                          child: TextField(
                            controller: myMessage,
                            maxLines: 100,
                            decoration: InputDecoration(
                                hintText:  AppLocalizations.of(context).translate('typeـaـmessage'),
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        FloatingActionButton(
                          onPressed: ()  async {

                            if(myMessage.text.isNotEmpty)
                            {

                              // setState(() {
                            //   List<AttachmentFiles> attachmentFiles=[];
                              await  AppCubit().postChat(widget.std,widget.teacher_id, myMessage.text.toString(),file);
                              // messages.add(Messages(messageContent: myMessage.text.toString(), messageType: "sender",attachmentFiles:[],attachmentName:''));
                              //   setState(() {
                              //     Navigator.push(context, MaterialPageRoute(builder: (context){
                              //       return ChatDetailPage(teacher_id:widget.teacher_id ,std:widget.std ,teacher_image: widget.teacher_image,teacher_name: widget.teacher_name,);
                              //     }));
                              //
                              //   });
                              getLastChat(widget.std,widget.teacher_id);
                            //   // controller.jumpTo(controller.position.maxScrollExtent);
                            // });
                            //


                            }
                            myMessage.clear();
                          },
                          child: Icon(Icons.send_outlined,color:Color(0xff3b91ce),size: 30,),
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if(!Platform.isAndroid)
                            {
                              FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
                              if (result == null) return;
                              Map<String, dynamic> data = {};

                              for (int i = 0; i < result.count; i++) {
                                if (result.files[i].extension != '.pdf' || result.files[i].extension != '.mp3' || result.files[i].extension != '.mp4' ||result.files[i].extension != '.png'
                                || result.files[i].extension != '.jpg' || result.files[i].extension != '.pjp'|| result.files[i].extension != '.jfif' || result.files[i].extension != '.pjpeg'
                                    || result.files[i].extension != '.jpeg')
                                  {

                                    data['name'] = result.files[i].name;
                                    data['size'] = result.files[i].size;
                                    data['file'] = base64Encode(
                                        File(result.files[i].path!)
                                            .readAsBytesSync());
                                    data['base_url'] =
                                        CacheHelper.getBoolean(key: 'base_url');
                                    // setStateBu((){
                                    setState(() {
                                      file.add(data);

                                      if (file.length > 0)
                                        flg = true;
                                      else
                                        flg = false;
                                    });
                                  }else{
                                  Fluttertoast.showToast(
                                      msg: result.files[i].name+" This file cannot be upload",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.black,
                                      fontSize: 16.0
                                  );
                            // });
                            }}
                            }
                            else
                              {
                                final deviceInfo = await DeviceInfoPlugin().androidInfo;
                                if (deviceInfo.version.sdkInt! > 32) {
                                  FilePickerResult? result = await FilePicker
                                      .platform.pickFiles(
                                      allowMultiple: true);
                                  if (result == null) return;
                                  Map<String, dynamic> data = {};

                                  for (int i = 0; i < result.count; i++) {
                                    if (result.files[i].extension != '.pdf' ||
                                        result.files[i].extension != '.mp3' ||
                                        result.files[i].extension != '.mp4' ||
                                        result.files[i].extension != '.png'
                                        ||
                                        result.files[i].extension != '.jpg' ||
                                        result.files[i].extension != '.pjp' ||
                                        result.files[i].extension != '.jfif' ||
                                        result.files[i].extension != '.pjpeg'
                                        ||
                                        result.files[i].extension != '.jpeg') {

                                      data['name'] = result.files[i].name;
                                      data['size'] = result.files[i].size;
                                      data['file'] = base64Encode(
                                          File(result.files[i].path!)
                                              .readAsBytesSync());
                                      data['base_url'] =
                                          CacheHelper.getBoolean(
                                              key: 'base_url');
                                      // setStateBu((){
                                      setState(() {
                                        file.add(data);

                                        if (file.length > 0)
                                          flg = true;
                                        else
                                          flg = false;
                                      });
                                      // });
                                    }
                                    else {
                                      Fluttertoast.showToast(
                                          msg: result.files[i].name +
                                              " This file cannot be upload",
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
                                else
                                  {
                                    var status =await Permission.storage.request();
                                    if (status.isGranted) {
                                      final result = await FilePicker.platform
                                          .pickFiles(allowMultiple: true);
                                      if (result == null) return;
                                      Map<String, dynamic> data = {};

                                      for (int i = 0; i < result.count; i++) {
                                        if (result.files[i].extension != '.pdf' || result.files[i].extension != '.mp3' || result.files[i].extension != '.mp4' ||result.files[i].extension != '.png'
                                            || result.files[i].extension != '.jpg' || result.files[i].extension != '.pjp'|| result.files[i].extension != '.jfif' || result.files[i].extension != '.pjpeg'
                                            || result.files[i].extension != '.jpeg')
                                        {
                                          data['name'] = result.files[i].name;
                                          data['size'] = result.files[i].size;
                                          data['file'] = base64Encode(
                                              File(result.files[i].path!)
                                                  .readAsBytesSync());
                                          data['base_url'] =
                                              CacheHelper.getBoolean(
                                                  key: 'base_url');

                                          setState(() {
                                            file.add(data);

                                            if (file.length > 0) {
                                              flg = true;
                                            }

                                            else
                                              flg = false;
                                          });

                                        }else {
                                          Fluttertoast.showToast(
                                              msg: result.files[i].name+" This file cannot be upload",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.grey,
                                              textColor: Colors.black,
                                              fontSize: 16.0
                                          );

                                        }

                                      }
                                      if (file.length > 0){
                                        flg = true;



                                        setState(() {
                                          // isAbs = true;
                                          // isstudent = false;
                                        });
                                      }
                                    }

                                  }
                              }
                            if(file.length>0)
                              {
                                cuShowModalBottomSheet();
                              }
                          },
                          child: Container(
                            height: 30,
                            width: 30,

                            child: Icon(Icons.attach_file, color: Color(0xffcbd5e0), size: 30, ),
                          ),
                        ),
                        SizedBox(width: 15,),
                      ],

                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      }, listener: (context, state) {
        if(state.toString()=="Instance of 'AppChat'") {
          messages = [];
          messages = AppCubit.messages;
          setState(() {
          });
        }

      },),

    );
  }

  void goPage(String type, String url ,String name)
  {
    if (  type.toString().split('.').last=='pdf') {

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            PDF(url: url,
              name: name,)),
      );

    }
    else {
      if( type.toString().contains('.mp4')|| type.toString().split('.').last=='mp4') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VideoApp(
                    url: url,
                  ),
            ));
      }
      else if( (type.toString().contains('.png')|| type.toString().split('.').last=='png') ||( type.toString().contains('.jpg')|| type.toString().split('.').last=='jpg')  || (type.toString().contains('.jpeg')|| type.toString().split('.').last=='jpeg')|| (type.toString().contains('.jfif')|| type.toString().split('.').last=='jfif')||(type.toString().split('.').last.contains('.pjp')|| type.toString().split('.').last=='pjp')||(type.toString().contains('.pjpeg')|| type.toString().split('.').last=='pjpeg')||  type.toString().split('.').last=='heic') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OpenImage(
                    url,
                  ),
            ));
      }
      else if (type.toString().split('.').last=='mp3'|| type.toString().split('.').last=='mpeg')
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CustomAudioPlayer( url)),
        );

      }
      else{
        Fluttertoast.showToast(
            msg: "This file cannot be opened",
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
  
  Future cuShowModalBottomSheet()
  {
    return   showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) => DraggableScrollableSheet(
        initialChildSize: .5,
        minChildSize: .4,
        maxChildSize: .97,
        expand: false,
        builder: (context, scrollController) => Scaffold(
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 20,
            child: Container(
              height: 10.h,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[

                          SizedBox(width: 15,),
                          Expanded(
                            child: TextField(
                              controller: myMessage,
                              maxLines: 100,
                              decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context).translate('typeـaـmessage'),
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          FloatingActionButton(
                            onPressed: (){

                              setState(() {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const Center(
                                      child: const CircularProgressIndicator(),
                                    );
                                  },
                                );
                                AppCubit().postChat(widget.std,widget.teacher_id, myMessage.text.isNotEmpty?myMessage.text.toString():'',file).then((value)
                                {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context){
                                  //   return ChatDetailPage(teacher_id:widget.teacher_id ,std:widget.std ,teacher_image: widget.teacher_image,teacher_name: widget.teacher_name,);
                                  // }));
                                  getLastChat(widget.std,widget.teacher_id);
                                  file=[];
                                  myMessage.clear();
                                }
                                ).catchError((onError) {
                                  print(onError);
                                });

                              });

                            },
                            child: Icon(Icons.send_outlined,color:Color(0xff3b91ce),size: 30,),
                            backgroundColor: Colors.white,
                            elevation: 0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if(!Platform.isAndroid)
                              {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
                                if (result == null) return;
                                Map<String, dynamic> data = {};

                                for (int i = 0; i < result.count; i++) {
                                  if (result.files[i].extension != '.pdf' || result.files[i].extension != '.mp3' || result.files[i].extension != '.mp4' ||result.files[i].extension != '.png'
                                      || result.files[i].extension != '.jpg' || result.files[i].extension != '.pjp'|| result.files[i].extension != '.jfif' || result.files[i].extension != '.pjpeg'
                                      || result.files[i].extension != '.jpeg')
                                  {
                                    data['name'] = result.files[i].name;
                                    data['size'] = result.files[i].size;
                                    data['file'] = base64Encode(
                                        File(result.files[i].path!)
                                            .readAsBytesSync());
                                    data['base_url'] =
                                        CacheHelper.getBoolean(key: 'base_url');

                                    setState(() {
                                      file.add(data);

                                      if (file.length > 0)
                                        flg = true;
                                      else
                                        flg = false;
                                    });

                                  }
                                  else
                                    {
                                      Fluttertoast.showToast(
                                          msg: result.files[i].name+" This file cannot be upload",
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
                              else
                              {
                                final deviceInfo = await DeviceInfoPlugin().androidInfo;
                                if (deviceInfo.version.sdkInt! > 32) {

                                  FilePickerResult? result = await FilePicker
                                      .platform.pickFiles(
                                      allowMultiple: true);
                                  if (result == null) return;
                                  Map<String, dynamic> data = {};

                                  for (int i = 0; i < result.count; i++) {
                                    if (result.files[i].extension != '.pdf' || result.files[i].extension != '.mp3' || result.files[i].extension != '.mp4' ||result.files[i].extension != '.png'
                                        || result.files[i].extension != '.jpg' || result.files[i].extension != '.pjp'|| result.files[i].extension != '.jfif' || result.files[i].extension != '.pjpeg'
                                        || result.files[i].extension != '.jpeg')
                                    {
                                      data['name'] = result.files[i].name;
                                      data['size'] = result.files[i].size;
                                      data['file'] = base64Encode(
                                          File(result.files[i].path!)
                                              .readAsBytesSync());
                                      data['base_url'] =
                                          CacheHelper.getBoolean(
                                              key: 'base_url');

                                      setState(() {
                                        file.add(data);

                                        if (file.length > 0)
                                          flg = true;
                                        else
                                          flg = false;
                                      });

                                    }
                                    else
                                      {
                                        Fluttertoast.showToast(
                                            msg: result.files[i].name+" This file cannot be upload",
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
                                else
                                {
                                  var status =await Permission.storage.request();
                                  if (status.isGranted) {
                                    final result = await FilePicker.platform
                                        .pickFiles(allowMultiple: true);
                                    if (result == null) return;
                                    Map<String, dynamic> data = {};

                                    for (int i = 0; i < result.count; i++) {

                                      if (result.files[i].extension != '.pdf' || result.files[i].extension != '.mp3' || result.files[i].extension != '.mp4' ||result.files[i].extension != '.png'
                                          || result.files[i].extension != '.jpg' || result.files[i].extension != '.pjp'|| result.files[i].extension != '.jfif' || result.files[i].extension != '.pjpeg'
                                          || result.files[i].extension != '.jpeg')
                                      {

                                        data['name'] = result.files[i].name;
                                        data['size'] = result.files[i].size;
                                        data['file'] = base64Encode(
                                            File(result.files[i].path!)
                                                .readAsBytesSync());
                                        data['base_url'] =
                                            CacheHelper.getBoolean(
                                                key: 'base_url');

                                        setState(() {
                                          file.add(data);

                                          if (file.length > 0){
                                            flg = true;
                                          }

                                          else
                                            flg = false;
                                        });
                                      }
                                      else{
                                        Fluttertoast.showToast(
                                            msg: result.files[i].name+" This file cannot be upload",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.black,
                                            fontSize: 16.0
                                        );
                                      }


                                    }
                                    if (file.length > 0){
                                      flg = true;



                                      setState(() {
                                        // isAbs = true;
                                        // isstudent = false;
                                      });
                                    }
                                  }

                                }
                              }

                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              // decoration: BoxDecoration(
                              //   // color: Colors.lightBlue,
                              //   // borderRadius: BorderRadius.circular(30),
                              // ),
                              child: Icon(Icons.attach_file, color: Color(0xffcbd5e0), size: 30, ),
                            ),
                          ),
                          SizedBox(width: 15,),
                        ],

                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                      color: Color(0xffeaeaea),
                      elevation: 0,
                      child: Container(
                        height: 6,
                        width: 50,
                      )),

                  ListView.builder(

                      shrinkWrap: true,
                      padding: EdgeInsets.only(left: 10, right: 15),
                      itemCount: file.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          //Display car block

                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border:
                                Border.all(color: Color(0xffbbc7db))),
                            child: Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(15),
                                    child: Image(
                                        image:
                                        AssetImage("images/pdf123.png"))
                                  // SvgPicture.asset("images/pdf.svg")
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Text(file[index]['name'],
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.normal,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 16,
                                                  color: Colors.black))),
                                      Container(
                                        // alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Text(
                                              file[index]['size']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.normal,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 13,
                                                  color:
                                                  Color(0xff8e8c8c)))),
                                    ],
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.all(15),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (file.length > 0) {
                                              file.removeAt(index);

                                              if (file.length > 0) {
                                                flg = true;
                                              } else {
                                                flg = false;
                                              }
                                            } else {
                                              flg = false;
                                            }

                                            if(file.length==0)
                                            {
                                              Navigator.pop(context);
                                            }
                                          });
                                        },
                                        icon: SvgPicture.asset(
                                            "images/icons8_delete12.svg",
                                            color: Color(0xffbbc7db)))),
                              ],
                            ),
                          ),
                        );
                      }),

                ],
              )),
        ),
      ),),
    );
  }



}

