import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allWeekPlans.dart';

class Reset{
  static void clear_searhe()
  {
    AppCubit.flag_req=false;
    AppCubit.stutes_notif_odoo='';
    AppCubit.stutes_notif_da_odoo='';
    AppCubit. fromDate_odoo=DateTime.parse("2016-01-01 00:00:00");
    AppCubit. fromTo_odoo=DateTime.parse("2035-01-01 00:00:00");
    AppCubit.filter_subject=[];
    AppCubit.subject_odoo=[];
    AppCubit.show_st=true;
    AppCubit.filter=false;


  }

  // static Widget student_list(int ind,Students  listDetail1,Context context) {
  //
  //
  //
  //   List<Features> listFeatures1=[];
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 8.0),
  //     child: InkWell(
  //
  //       onTap: () {
  //         Reset.clear_searhe();
  //         // AppCubit.stutes_notif_odoo='';
  //         AppCubit.school_image=listDetail1.schoolImage.toString();
  //         listFeatures1.clear();
  //         if(listDetail1.changeLocation=true)
  //         {
  //
  //           listFeatures1.add( Features(name:  AppLocalizations.of(context as BuildContext).translate('chang_home_location'), icon: 'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Assignments.svg',nameAr: AppLocalizations.of(context as BuildContext).translate('chang_home_location')));
  //
  //         }
  //
  //         listDetail1.features!.forEach((element) {
  //
  //
  //           listFeatures1.add(element); });
  //
  //         AppCubit.get(context).setDetalil(listDetail1.name, listDetail1.studentGrade??"", listDetail1.schoolName, listDetail1.avatar, listDetail1.id.toString(),  listDetail1.schoolLat, listDetail1.schoolId.toString(), listDetail1.schoolLng, listDetail1.pickupRequestDistance.toString(), listFeatures1);
  //
  //         Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => AllWeeklyPlans( std_id: listDetail1.id.toString(),),),
  //         );
  //       },
  //       child: Row(
  //
  //           children: [
  //
  //
  //             CircleAvatar(
  //               backgroundColor: Colors.transparent ,
  //               maxRadius: 5.w,
  //
  //
  //               backgroundImage: NetworkImage('${listDetail1.avatar}', ),
  //
  //             ),
  //             SizedBox(height: 10,width: 10,),
  //
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text("${listDetail1.fname}",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 9),),
  //                 Text("${listDetail1.studentGrade}",style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 9),),
  //               ],
  //             ),
  //           ]),
  //     ),
  //   );
  // }


}