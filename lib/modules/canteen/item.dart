import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/models/item_m.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/modules/canteen/create_canteen.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
class Item_food extends StatefulWidget {
  String name;
  String type;
  int day_id;

  Item_food({required this.name,required this.type,required this.day_id});


  @override
  State<Item_food> createState() => _Item_foodState();
}

class _Item_foodState extends State<Item_food> {
  TextEditingController search = TextEditingController();
  String filter='';
   List<Product> list_item_Search = [];
   bool flg=false;
  List canteen_banned = [];
  onSearchTextChanged(String text) async {
    list_item_Search.clear();

    if(text.isEmpty)
    {
      flg=false;
      setState(() {

      });
      return;
    }
    if(search.text.isNotEmpty){
      AppCubit.product.forEach((element) {
        if(filter.isEmpty){
        if(element.type.toString().contains(text))
        {
          list_item_Search.add(element);
        }}
        else{
          if(element.type.toString().contains(text) && element.type.toString().toLowerCase()==filter.toString().toLowerCase() )
          {
            list_item_Search.add(element);
          }

        }

      });
    }
    else{
      AppCubit.product.forEach((element) {
        if(element.type.toString().toLowerCase()==text.toString().toLowerCase())
        {
          list_item_Search.add(element);
        }
      });

    }
    if(search.text.isEmpty && filter.isEmpty)
    {
      flg=false;
    }
    else
    {
      flg=true;
    }


    setState(() {


    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getItem(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // shwoDialog();
        },
        builder: (context, state) {
          FirebaseMessaging.onMessageOpenedApp.listen((event) {
            setState(() {});
          });

          FirebaseMessaging.onMessage.listen((event) {});
          return WillPopScope(
              onWillPop: () async {
                Navigator.pop(context);
                return false;
              },
              child: Scaffold(

                appBar: AppBar(
                  // primary: false,
                  toolbarHeight: 90,
                  backgroundColor: Colors.white,
                  leadingWidth: MediaQuery.of(context).size.width / 1,
                  bottom: PreferredSize(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: search,
                          onChanged: onSearchTextChanged,
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)
                                  .translate('search'),
                              filled: true,
                              fillColor: Colors.white,
                              // prefixIcon: const Icon(Icons.search,size: 35),
                              suffixIcon: const Icon(Icons.search,
                                  size: 35, color: Color(0xff98aac9)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff98aac9)),
                                  borderRadius: BorderRadius.circular(5)),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff98aac9)),
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                      preferredSize: Size.fromHeight(80)),
                  leading: Container(
                      padding: EdgeInsets.only(left: 18, top: 10),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('add_item'),
                            style: TextStyle(
                                fontSize: 22,
                                color: Color(0xff3c92d0),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Create_Canteen()));
                          },
                          icon: SvgPicture.asset(
                            "images/close.svg",
                            color: Color(0xff98aac9),
                            width: MediaQuery.of(context).size.width / 20,
                          )),
                    )
                  ],
                ),

                backgroundColor: Color(0xfff5f7fb),

                bottomNavigationBar: BottomAppBar(child: Container(
                  height: 130,
                  child: Column(children: [
                    SizedBox(height: 10,),
                    Container(
                  height: 50,
                  // color: Colors.red,
                  child: InkWell(
                    onTap: () async {

                     if(widget.type=='day'){
                       print(canteen_banned);
                       await DioHelper.postData(
                           url: Post_sec_item,
                           data: {
                             "student_id": AppCubit.std,
                             "canteen_banned": canteen_banned,
                             "day_id":widget.day_id
                           },
                           token:
                           CacheHelper.getBoolean(key: 'authorization'))
                           .then(
                             (value) async {
                           AppCubit()
                             ..getCanteen().then((value) {
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => Create_Canteen()));
                             });
                         },
                       ).catchError((onError) {

                       });
                     }
                     else {
                       await DioHelper.postData(
                           url: Post_banned_item,
                           data: {
                             "student_id": AppCubit.std,
                             "canteen_banned": canteen_banned,
                           },
                           token:
                           CacheHelper.getBoolean(key: 'authorization'))
                           .then(
                             (value) async {
                           AppCubit()
                             ..getCanteen().then((value) {
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => Create_Canteen()));
                             });
                         },
                       ).catchError((onError) {

                       });
                     }
                      //Allergies
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff3c92d0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context).translate('Submit'),
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                    SizedBox(height: 10,),
                    Container(
                    height: 50,
                    // color: Colors.red,
                    child: InkWell(
                      onTap: () async {

                        AppCubit()
                          ..getCanteen().then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Create_Canteen()));
                          });
                        //Allergies
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Color(0xff3c92d0))
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context).translate('cancel'),
                          style: GoogleFonts.montserrat(
                            color: Color(0xff3c92d0),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  )


                  ]),)),

                body: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    // width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('categorias'),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        Container(
                            height: 15.w,
                            child: ListView.builder(
                              itemBuilder: (context, index) =>
                                  filter_list(index),
                              itemCount: AppCubit.category.length,
                              scrollDirection: Axis.horizontal,
                            )),
                        Expanded(
                          child:Container(
                            color: Color(0xfff5f7fb),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  list_item(index),
                              itemCount:AppCubit.product.length<0 ?  flg?  AppCubit.product.length<0+2 ?list_item_Search.length+2:list_item_Search.length:AppCubit.product.length+2 :AppCubit.product.length+2,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }


  Widget filter_list(int ind) {
    CircleAvatar test;
    if (AppCubit.category[ind].name == 'all') {

      if (AppCubit.category[ind].sta.toString().toLowerCase()=='false') {
        test = CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            AppLocalizations.of(context).translate('all'),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 4.w),
          ),
        );
      } else {
        test = CircleAvatar(
          backgroundColor: Color(0xff98aac9),
          child: Text(AppLocalizations.of(context).translate('all'),
              style: TextStyle(color: Colors.white, fontSize: 4.w)),
        );
      }
    } else {
      if (AppCubit.category[ind].sta.toString().toLowerCase()=='false') {
        test = CircleAvatar(
          backgroundColor: Colors.white,
          child:

          SvgPicture.network(
            AppCubit.category[ind].icon.toString(),
            color: Color(0xff98aac9),
            width: 6.w,
          ),
        );
      } else {
        test = CircleAvatar(
            backgroundColor: Color(0xff98aac9),
            child: SvgPicture.network(AppCubit.category[ind].icon.toString(),
                color: Colors.white, width: 6.w));
      }
    }

    return InkWell(
      onTap: () {




        for(int i=0;i<AppCubit.category.length;i++)
        {
          if(ind!=i)
          {

            AppCubit.category[i].sta=false;
          }
          else{
            AppCubit.category[i].sta=true;

          }
        }
        filter=AppCubit.category[ind].name.toString() !='all'?AppCubit.category[ind].name.toString():'';
        onSearchTextChanged(AppCubit.category[ind].name.toString());
        setState(() {

        });
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                ? 0
                : 9,
            right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                ? 9
                : 0),
        child: Container(
          width: 15.w,
          height: 15.w,
          // color: Colors.red,
          child: Card(
            shape: const RoundedRectangleBorder(
                side: BorderSide(width: .8, color: Color(0xffd4ddee)),
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            elevation: 0.0,
            child: Container(
// color: Colors.blue,
              // width:60 ,
              child: test,
            ),
          ),
        ),
      ),

    );
  }
  Widget list_item(int ind){
    if (flg){

      if(list_item_Search.length>ind){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
            ),
            child: Container(child: Row(children: [
              SizedBox(width: 20,),
              Image(image: NetworkImage("${list_item_Search[ind].image}"),height: 70,width: 70,),
              SizedBox(width: 20,),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Text(list_item_Search[ind].name.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                    SizedBox(height: 10,),
                    Text(list_item_Search[ind].type.toString()!='all'?list_item_Search[ind].type.toString():AppCubit.product[ind].type.toString(),style:TextStyle(color: Color(0xff98aac9),fontWeight: FontWeight.normal,fontSize: 12) ,),
                    SizedBox(height: 10,),
                    Text(list_item_Search[ind].price.toString(),style:TextStyle(color: Color(0xff3c92d0),fontWeight: FontWeight.normal,fontSize: 15)),
                    SizedBox(height: 20,),


                  ],),
              ),

              Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      
                      print("'''''ldldldlldlddll'''''");
                      ScaffoldMessenger.of(context)
                          .showSnackBar( const SnackBar(content: Text('data'),))     ;
                      canteen_banned.add(list_item_Search[ind].id);
                  //  Item_food
                    },
                    child: SvgPicture.asset(
                      "images/add_icon.svg",
                      height: 20,
                      width: 20,
                      color: Color(0xff3c92d0),
                    ),
                  ))


            ],)),
          ),
        );}
      return SizedBox(height: 250,);
    }
    else{



      if(AppCubit.product.length>ind){
        print(AppCubit.product.length>=ind);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
            ),
            child: Container(child: Row(children: [
              SizedBox(width: 20,),
              Image(image: NetworkImage("${AppCubit.product[ind].image}"),height: 70,width: 70,),
              SizedBox(width: 20,),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Text(AppCubit.product[ind].name.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                    SizedBox(height: 10,),
                    Text(AppCubit.product[ind].type.toString()!='all'?AppCubit.product[ind].type.toString():"",style:TextStyle(color: Color(0xff98aac9),fontWeight: FontWeight.normal,fontSize: 12) ,),
                    SizedBox(height: 10,),
                    Text(AppCubit.product[ind].price.toString(),style:TextStyle(color: Color(0xff3c92d0),fontWeight: FontWeight.normal,fontSize: 15)),
                    SizedBox(height: 20,),


                  ],),
              ),

              Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(  SnackBar(content: SizedBox(child:Container(
                          child: Center(
                              child: Text(AppLocalizations.of(context)
                                  .translate('basket'), style:
                              TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),textAlign: TextAlign.center,))),),



                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                        backgroundColor: Color(0xff7cb13b),

                        behavior: SnackBarBehavior.floating,

                      // width: double.infinity/2,
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      ))     ;
                      canteen_banned.add(AppCubit.product[ind].id);


                      //  Item_food
                    },
                    child: SvgPicture.asset(
                      "images/add_icon.svg",
                      height: 20,
                      width: 20,
                      color: Color(0xff3c92d0),
                    ),
                  ))


            ],)),
          ),
        );}
      print('AppCubit.product.length>=ind');
      return SizedBox(height: 250,);
    }



  }
}
