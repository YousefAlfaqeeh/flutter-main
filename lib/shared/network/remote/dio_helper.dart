import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: MAIN_URL,
        receiveDataWhenStatusError: true,headers: {'Content-Type':'application/json'}));
  }

  static Future<Response> getData({required String url,String? token}) async {
    dio.options.headers= {
      'Authorization':token??'',
      'Content-Type':'application/json',


    };
    return await dio.get(url);
  }

  static  Future<Response> postData(
      {required String url, required Map<String, dynamic> data,String? token}) async {
    dio.options.headers= {
      'Authorization':token??'',
      'Content-Type':'application/json',


    };
    return await dio.post(url,data:data );
  }
  static  Future<Response> uplodeData(
      {required String url, required Map data,String? token}) async {
    dio.options.headers= {
      'Authorization':token??'',
      'Content-Type':'application/json',

    };
    return await dio.post(url,data:data );
  }

}

class DioHelperChat {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: '',
        receiveDataWhenStatusError: true,headers: {'Content-Type':'application/json'}));
  }

  static Future<Response> getData({required String url,String? token}) async {
    dio.options.headers= {
      'Authorization':AppCubit.sessionId??'',
      'Content-Type':'application/json',
      // "X-Openerp-Session-Id":AppCubit.sessionId

    };
    return await dio.get(url);
  }

  static  Future<Response> postData(
      {required String url, required Map<String, dynamic> data,String? token}) async {
    dio.options.headers= {
      'Authorization':token??'',
      'Content-Type':'application/json',
      "Cookie":"session_id="+AppCubit.sessionId.toString()

    };
    return await dio.post(url,data:data );
  }
  static  Future<Response> uplodeData(
      {required String url, required Map data,String? token}) async {
    // print("jjjjjjjjjjjj"+url.toString());
    dio.options.headers= {
      'Authorization':token??'',
      'Content-Type':'application/json',

      "Cookie":"session_id="+AppCubit.sessionId.toString()

    };
    return await dio.post(url,data:data );
  }

}

class DioHelper1 {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: SCHOOLS_LIST,
        receiveDataWhenStatusError: true,headers: {'Content-Type':'application/json'}));
  }

  static Future<Response> getData({required String url}) async {

    return await dio.get(url);
  }
  static  Future<Response> postData(
      {required String url, required Map<String, dynamic> data,String? token}) async {
    dio.options.headers= {
      'Authorization':token??'',
      'Content-Type':'application/json',

    };
    return await dio.post(url,data:data );
  }
}

class DioHelper2 {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        // baseUrl: 'https://iks.staging.trackware.com/web/session/authenticate',
      baseUrl: 'https://iks.staging.trackware.com/web/login?db=iks&login=9731020092',
        receiveDataWhenStatusError: true,headers: {
        'Content-Length':'<calculated when request is sent>',
      'Host':'<calculated when request is sent>',
      'Content-Type':'multipart/form-data; boundary=<calculated when request is sent>',
      'Content-Type':'application/x-www-form-urlencoded',

    }));
  }

  static Future<Response> getData({required String url}) async {
    return await dio.get(url);
  }
  static  Future<Response> postData(
      {required String url, required Map<String, dynamic> data}) async {
    dio.options.headers= {
    'User-Agent':'PostmanRuntime/7.28.4',
    'Accept':'*/*',
    'Host':'<calculated when request is sent>',
    'Accept-Encoding':'gzip, deflate, br',
    'Connection':'keep-alive'
    //
    };
    return await dio.post(url,data:{
      "password": "9731020092"
    });
  }
}
