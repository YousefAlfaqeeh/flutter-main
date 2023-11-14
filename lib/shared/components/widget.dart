// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/modulesOdoo/absence.dart';
// import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
//
// class RefreshWidget extends StatelessWidget {
//  Widget child;
//  Future Function() onRefresh;
//  final  GlobalKey<RefreshIndicatorState> keyRefresh;
//
//
//  RefreshWidget({required this.child, required this.onRefresh, required this.keyRefresh});
//
//   @override
//   Widget build(BuildContext context) {
//     return Platform.isAndroid? buildAndroidWidget():buildIosWidget();
//   }
//  buildIosWidget()
//  {
//    return CustomScrollView(slivers: [
//      CupertinoSliverRefreshControl(onRefresh: onRefresh,key: key,),
//      SliverToBoxAdapter(child:child ,)
//    ],);
//  }
//  buildAndroidWidget()
//  {
// return RefreshIndicator(child: child, onRefresh: onRefresh,key: key,);
//  }
// }
class Student extends StatefulWidget {
  const Student({Key? key}) : super(key: key);

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget student_list(int ind,Students  listDetail1) {
    List<Features> listFeatures1=[];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(

        onTap: () {
          AppCubit.flag_req=false;
          AppCubit.stutes_notif_odoo='';
          AppCubit.school_image=listDetail1.schoolImage.toString();

          listFeatures1.clear();
          // if(listDetail1.changeLocation=true)
          // {
          //
          //   listFeatures1.add( Features(name:  AppLocalizations.of(context).translate('chang_home_location'), icon: 'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Assignments.svg',nameAr: AppLocalizations.of(context).translate('chang_home_location')));
          //
          // }

          listDetail1.features!.forEach((element) {


            listFeatures1.add(element); });

          AppCubit.get(context).setDetalil(listDetail1.name, listDetail1.studentGrade??"", listDetail1.schoolName, listDetail1.avatar, listDetail1.id.toString(),  listDetail1.schoolLat, listDetail1.schoolId.toString(), listDetail1.schoolLng, listDetail1.pickupRequestDistance.toString(), listFeatures1);

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Absence(std_id: AppCubit.std,std_name: AppCubit.name)));
        },
        child: Row(

            children: [


              CircleAvatar(
                backgroundColor: Colors.transparent ,
                maxRadius: 20,


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

 Widget emptyModules(String image,String text,{String x='d'})
{
  return Container(
    alignment: Alignment.center,

    child:Padding(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Column(children: [
        Expanded(child: Image(image: AssetImage(image) ,width: 400,height: 239,)),

        Text(text,style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Colors.black)),
        SizedBox(height: 10,),
        InkWell(
        // onTap:() {
        //   function;
        // },
            child: Text("Return to profile",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0),decoration: TextDecoration.underline)))
      ]),
    ) ,);
}
// class Padding_16 extends Padding
// {
//    Padding_16( EdgeInsetsGeometry padding = EdgeInsets.symmetric(vertical: 50) ) : super(padding);
//
// //   Padding_16({
// // required this.padding = 16,
// // Widget? child,
// // });
// }