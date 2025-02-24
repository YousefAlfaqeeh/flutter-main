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
                      preferredSize: const Size.fromHeight(80)),
                  leading: Container(
                      padding: const EdgeInsets.only(left: 18, top: 10),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('add_item'),
                            style: const TextStyle(
                                fontSize: 22,
                                color: Color(0xff3c92d0),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Create_Canteen()));
                          },
                          icon: SvgPicture.asset(
                            "images/close.svg",
                            color: const Color(0xff98aac9),
                            width: MediaQuery.of(context).size.width / 20,
                          )),
                    )
                  ],
                ),
                backgroundColor: const Color(0xfff5f7fb),
                bottomNavigationBar: BottomAppBar(child: Container(
                  height: 130,
                  child: Column(children: [
                    const SizedBox(height: 10,),
                    Container(
                  height: 50,
                  // color: Colors.red,
                  child: InkWell(
                    onTap: () async {

                     if(widget.type=='day'){

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
                                       builder: (context) => const Create_Canteen()));
                             });
                         },
                       ).catchError((onError) {
print("--f--f-f-f-f-f");
print(onError);
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
                                       builder: (context) => const Create_Canteen()));
                             });
                         },
                       ).catchError((onError) {

                       });
                     }
                      //Allergies
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff3c92d0),
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
                    const SizedBox(height: 10,),
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
                                    builder: (context) => const Create_Canteen()));
                          });
                        //Allergies
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: const Color(0xff3c92d0))
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context).translate('cancel'),
                          style: GoogleFonts.montserrat(
                            color: const Color(0xff3c92d0),
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
                            style: const TextStyle(
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
                            color: const Color(0xfff5f7fb),
                            child: ListView.builder(
                              padding: EdgeInsets.only(bottom: 100.h),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  list_item(index),
                              itemCount: flg ? list_item_Search.length :AppCubit.product.length,
                              // itemCount:AppCubit.product.length<0 ?  flg?  AppCubit.product.length<0 ?list_item_Search.length:list_item_Search.length:AppCubit.product.length :AppCubit.product.length,
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
          backgroundColor: const Color(0xff98aac9),
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
            color: const Color(0xff98aac9),
            width: 6.w,
          ),
        );
      } else {
        test = CircleAvatar(
            backgroundColor: const Color(0xff98aac9),
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
          // width: 15.w,
          height: 15.w,
          child: Card(
            shape: const RoundedRectangleBorder(
                side: BorderSide(width: .8, color: Color(0xffd4ddee)),
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            elevation: 0.0,
            child: Container(

              child:AppCubit.category[ind].name == 'all' ?test:Row(children: [
                test,
                Text(AppCubit.category[ind].name.toString())
              ]),
            ),
          ),
        ),
      ),

    );
  }


   checkItem(int ind ,String price)
  {

    double sum = 0.0;

    for (int x = 0; x < AppCubit.dateItem.length; x++) {

      sum += double.parse(AppCubit.dateItem[x].price.toString().replaceAll(
          "JOD", "").trim());
    }
    try {
      sum += double.parse(price.replaceAll("JOD", "").trim());
    } catch (e) {
      print("Error parsing price: $e");
    }

    for (int i = 0; i < canteen_banned.length; i++) {
      var product;
      if (filter.isEmpty) {
        product = AppCubit.product.firstWhere(
              (product) => product.id == canteen_banned[i],
        );
      }
      else {
        product = list_item_Search.firstWhere(
              (product) => product.id == canteen_banned[i],
        );
      }
      if (product != null) {
        var price = product.price;
        if (price != null) {
          sum += double.parse(price.toString().replaceAll("JOD", "").trim());
        }
      }
    }
    try {
      if (double.parse(AppCubit.spending[0].canteenSpending
          .toString()) >= sum) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
          content: SizedBox(child: Container(
              child: Center(
                  child: Text(AppLocalizations.of(context)
                      .translate('basket'), style:
                  const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                    textAlign: TextAlign.center,))),),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(4))),
          backgroundColor: const Color(0xff7cb13b),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 10),
        ));
        canteen_banned.add(AppCubit.product[ind].id);
      }
      else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
          content: SizedBox(child: Container(
              child: Center(
                  child: Text(AppLocalizations.of(context)
                      .translate('product_exceeded') +
                      AppCubit.spending[0].canteenSpending
                          .toString() +
                      AppLocalizations.of(context)
                          .translate('products_total_amount') +
                      sum.toString(), style:
                  const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                    textAlign: TextAlign.center,))),),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(4))),
          backgroundColor: const Color(0xffb13b4d),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 10),
        ));
      }
    }
    catch (e) {
      print("Error parsing price: $e");
    }


  }

  Widget list_item(int ind){
    // if ( widget.type !='day'){
    //
    //   // if(list_item_Search.length>ind){
    //   //  print(list_item_Search[ind].image.toString());
    //
    //     return Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
    //       child: Card(
    //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
    //         ),
    //         child: Row(children: [
    //           const SizedBox(width: 20,),
    //           Image(image: NetworkImage("${list_item_Search[ind].image}"),height: 70,width: 70,),
    //           const SizedBox(width: 20,),
    //           Expanded(
    //             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 const SizedBox(height: 20,),
    //                 Text(list_item_Search[ind].name.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
    //                 const SizedBox(height: 10,),
    //                 Text(list_item_Search[ind].type.toString()!='all'?list_item_Search[ind].type.toString():AppCubit.product[ind].type.toString(),style:const TextStyle(color: Color(0xff98aac9),fontWeight: FontWeight.normal,fontSize: 12) ,),
    //                 const SizedBox(height: 10,),
    //                 Text(list_item_Search[ind].price.toString(),style:const TextStyle(color: Color(0xff3c92d0),fontWeight: FontWeight.normal,fontSize: 15)),
    //                 const SizedBox(height: 20,),
    //
    //
    //               ],),
    //           ),
    //
    //           Padding(
    //               padding: const EdgeInsets.all(10),
    //               child: InkWell(
    //                 onTap: () {
    //
    //                   // ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('data'),))     ;
    //                   canteen_banned.add(list_item_Search[ind].id);
    //               //  Item_food
    //                 },
    //                 child: SvgPicture.asset(
    //                   "images/add_icon.svg",
    //                   height: 20,
    //                   width: 20,
    //                   color: const Color(0xff3c92d0),
    //                 ),
    //               ))
    //
    //
    //         ],),
    //       ),
    //     );
    //   // return SizedBox(height: 250,);
    // }
    // else{    // if ( widget.type !='day'){
    //
    //   // if(list_item_Search.length>ind){
    //   //  print(list_item_Search[ind].image.toString());
    //
    //     return Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
    //       child: Card(
    //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
    //         ),
    //         child: Row(children: [
    //           const SizedBox(width: 20,),
    //           Image(image: NetworkImage("${list_item_Search[ind].image}"),height: 70,width: 70,),
    //           const SizedBox(width: 20,),
    //           Expanded(
    //             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 const SizedBox(height: 20,),
    //                 Text(list_item_Search[ind].name.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
    //                 const SizedBox(height: 10,),
    //                 Text(list_item_Search[ind].type.toString()!='all'?list_item_Search[ind].type.toString():AppCubit.product[ind].type.toString(),style:const TextStyle(color: Color(0xff98aac9),fontWeight: FontWeight.normal,fontSize: 12) ,),
    //                 const SizedBox(height: 10,),
    //                 Text(list_item_Search[ind].price.toString(),style:const TextStyle(color: Color(0xff3c92d0),fontWeight: FontWeight.normal,fontSize: 15)),
    //                 const SizedBox(height: 20,),
    //
    //
    //               ],),
    //           ),
    //
    //           Padding(
    //               padding: const EdgeInsets.all(10),
    //               child: InkWell(
    //                 onTap: () {
    //
    //                   // ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('data'),))     ;
    //                   canteen_banned.add(list_item_Search[ind].id);
    //               //  Item_food
    //                 },
    //                 child: SvgPicture.asset(
    //                   "images/add_icon.svg",
    //                   height: 20,
    //                   width: 20,
    //                   color: const Color(0xff3c92d0),
    //                 ),
    //               ))
    //
    //
    //         ],),
    //       ),
    //     );
    //   // return SizedBox(height: 250,);
    // }
    // else{

       bool show_add=true;




      if(AppCubit.product.length>ind){

        String name='' ,price='',image='',type='' ;
        int id=0;
        if (filter.isEmpty)
          {
            name =AppCubit.product[ind].name.toString();
            price =AppCubit.product[ind].price.toString();
            image =AppCubit.product[ind].image.toString();
            type =AppCubit.product[ind].type.toString();
            id =AppCubit.product[ind].id!;
          }
        else
          {
            name =list_item_Search[ind].name.toString();
            price =list_item_Search[ind].price.toString();
            image =list_item_Search[ind].image.toString();
            type =list_item_Search[ind].type.toString();
            id =list_item_Search[ind].id!;
          }
        if (widget.type != 'day') {

          for (int x = 0; x < AppCubit.dateIte.length; x++) {
            if(filter.isEmpty) {
              if (AppCubit.dateIte[x].product_id == AppCubit.product[ind].id) {
                show_add = false;
                break; // إنهاء الحلقة بعد العثور على أول تطابق
              }
            }
            else
              {
                if (AppCubit.dateIte[x].product_id == list_item_Search[ind].id) {
                  show_add = false;
                  break; // إنهاء الحلقة بعد العثور على أول تطابق
                }
              //   list_item_Search
              }
          }

        }

        // AppCubit.dateIte.length
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
          child: Card(

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
            ),
            child: Row(children: [
              const SizedBox(width: 20,),
              Image(image: NetworkImage("${image}"),height: 70,width: 70,),
              const SizedBox(width: 20,),
              Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Text(name,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                const SizedBox(height: 10,),
                Text(type!='all'?type:"",style:const TextStyle(color: Color(0xff98aac9),fontWeight: FontWeight.normal,fontSize: 12) ,),
                const SizedBox(height: 10,),
                Text(price,style:const TextStyle(color: Color(0xff3c92d0),fontWeight: FontWeight.normal,fontSize: 15)),
                const SizedBox(height: 20,),


              ],),
              ),

              Visibility(
                visible: show_add,
                child: Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    // AppCubit.spending[0].canteenSpending.toString()
                    if(widget.type !='day'){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(
                        content: SizedBox(child: Container(
                            child: Center(
                                child: Text(AppLocalizations.of(context)
                                    .translate('basket'), style:
                                const TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                  textAlign: TextAlign.center,))),),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(4))),
                        backgroundColor: const Color(0xff7cb13b),
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ));
                      canteen_banned.add(AppCubit.product[ind].id);
                    }
                    else {
                      checkItem( ind , price);
                      print(price);
                    }

                    //  Item_food
                  },
                  child: SvgPicture.asset(
                    "images/add_icon.svg",
                    height: 20,
                    width: 20,
                    color: const Color(0xff3c92d0),
                  ),
                )),
              )


            ],),
          ),
        );}

      return const SizedBox(height: 250,);
    // }



  }
}
