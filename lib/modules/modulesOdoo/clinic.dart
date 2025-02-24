import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/models/modelClinic.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';


class Clinic extends StatefulWidget {
   String std_id;
   Clinic({required this.std_id});

  @override
  State<Clinic> createState() => _ClinicState();
}

class _ClinicState extends State<Clinic> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AppCubit()..getClinic(widget.std_id),
    child: BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
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
          body:Container(

            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.blue[700],

                  child:
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50,left: 20),

                        child: Row(children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Container(
                                width: 13.58,
                                height: 22.37,
                                padding: EdgeInsetsDirectional.only(end: 3),
                                child: SvgPicture.asset("images/chevron_left_solid.svg")),
                          ),
                          Container(padding: EdgeInsets.all(3),child: SvgPicture.asset("images/clinic.svg"),),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerLeft, child: Text("Clinic",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 25,color: Colors.white),)),
                        ],),
                      ),

                      Container(
                          padding: EdgeInsets.only(top: 20,bottom: 20),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30),
                          child: TextFormField(

                            decoration: InputDecoration(

                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(Icons.search,size: 35),

                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white),
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white),
                                    borderRadius:
                                    BorderRadius.circular(15))),


                          )),

                    ],
                  ),
                ),
                // ),
                AppCubit.list_clinic.length!=0
               ? Expanded(
                  child:
                  ListView.separated(
                    itemBuilder: (context, index) =>index<AppCubit.list_clinic.length ?clinic(AppCubit.list_clinic[index]):SizedBox(height: 200,),
                    itemCount: AppCubit.list_clinic.length+1,
                    separatorBuilder: (context, index) {
                      return Container(

                          child: Divider(
                            color: Colors.grey,
                          ));
                    },
                  ),
                ):Expanded(child: CustomEmpty("images/no_clinic_visits.png", "No Absence  "),
                // emptyClinic()
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

  Widget clinic(Result result) => InkWell(

    child: Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30),
              padding: EdgeInsets.all(8),
              height: 32,
              width: 32,
              decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(40)),color: Colors.orange
              )
              ,child: SvgPicture.asset("images/clinic_icon.svg"),),

            SizedBox(
              width: 20,
            ),

            Expanded(
              child:Text(result.date.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 20,color: Color(0xff3c92d0))))

          ],
        ),
        Row(
          children: [



             Container( margin: EdgeInsets.only(left: 30),
                    padding: EdgeInsets.all(8), child: Text("Note",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0)))),

             Expanded(
                child:Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),child: Text( result.note.toString(),style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Nunito',fontSize: 16,color: Colors.black)))),


          ],
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.all(8), child: Text("Presciption",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0)))),
  Container(alignment: Alignment.centerLeft, margin: EdgeInsets.only(left: 30),padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),child: Text(result.prescription.toString(),style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Nunito',fontSize: 16,color: Colors.black)))
              ],
    ),
  );
  // Widget emptyClinic()
  // {
  //   return Container(
  //     alignment: Alignment.center,
  //
  //     child:Padding(
  //       padding: EdgeInsets.symmetric(vertical: 50),
  //       child: Column(children: [
  //       Image(image: AssetImage("images/no_clinic_visits.png") ,width: 293,height: 239,),
  //       SizedBox(height: 10,),
  //         Text("No Absence ",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Colors.black)),
  //         SizedBox(height: 10,),
  //         InkWell(onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => New_Detail()),
  //           );
  //         },
  //             child: Text("Return to profile",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0),decoration: TextDecoration.underline)))
  //       // Text("No Absence added",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0)))
  //   ]),
  //     ) ,);
  // }
}
