class Kids_list {
  String? message;
  List<Students>? students;
  int? parentId;

  Kids_list({this.message, this.students, this.parentId});

  Kids_list.fromJson(Map<String, dynamic> json) {

    message = json['message'];
    if (json['students'] != null) {
      students = <Students>[];
      json['students'].forEach((v) {
        students!.add(new Students.fromJson(v));
      });
    }
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    data['parent_id'] = parentId;
    return data;
  }
}

class Students {
  String? name;
  String?fname;
  int? id;
  int? userId;
  String? avatar;
  int? schoolId;
  String? studentGrade;
  bool? dropOffByParent;
  bool? pickupByParent;
  int? fatherId;
  int? motherId;
  int? other1;
  int? other2;
  String? schoolName;
  String? schoolMobileNumber;
  String? schoolLat;
  String? schoolLng;
  String? lat;
  String? long;
  String? driverMobileNumber;
  String? driverMobileToken;
  String? driverName;
  String? assistantName;
  String? assistantMobileNumber;
  int? busId;
  String? roundType;
  bool? isActive;
  String? roundName;
  int? roundId;
  int? assistantId;
  int? routeOrder;
  bool? chatTeachers;
  String? targetLng;
  String? targetLat;
  String? licenseState;
  int? trialDaysLeft;
  int? licenseDaysLeft;
  String? semesterStartDate;
  String? semesterEndDate;
  bool? showAddBusCard;
  bool? allowUploadStudentsImages;
  bool? showMap;
  bool? changeLocation;
  bool? showAbsence;
  bool? showPickupRequest;
  int? pickupRequestDistance;
  StudentStatus? studentStatus;
  List<Features>? features;
  List<MobileNumbers>? mobileNumbers;
  String? db;
  String?schoolImage;
  String?sessionId;
  bool? new_chat;
  Students(
      {this.name,
        this.fname,
        this.id,
        this.userId,
        this.lat,
        this.long,
        this.avatar,
        this.schoolId,
        this.studentGrade,
        this.dropOffByParent,
        this.pickupByParent,
        this.fatherId,
        this.motherId,
        this.other1,
        this.other2,
        this.schoolName,
        this.schoolMobileNumber,
        this.schoolLat,
        this.schoolLng,
        this.driverMobileNumber,
        this.driverMobileToken,
        this.driverName,
        this.assistantName,
        this.assistantMobileNumber,
        this.busId,
        this.roundType,
        this.isActive,
        this.roundName,
        this.roundId,
        this.assistantId,
        this.routeOrder,
        this.chatTeachers,
        this.targetLng,
        this.targetLat,
        this.licenseState,
        this.trialDaysLeft,
        this.licenseDaysLeft,
        this.semesterStartDate,
        this.semesterEndDate,
        this.showAddBusCard,
        this.allowUploadStudentsImages,
        this.showMap,
        this.changeLocation,
        this.showAbsence,
        this.showPickupRequest,
        this.pickupRequestDistance,
        this.studentStatus,
        this.features,
        this.new_chat,
        this.mobileNumbers,this.db,this.schoolImage,this.sessionId});

  Students.fromJson(Map<String, dynamic> json) {
    name = json['name'];
     fname= json['fname'];
    lat = json['lat'];
    long= json['long'];
    id = json['id'];
    userId = json['user_id'];
    avatar = json['avatar'];
    schoolId = json['school_id'];
    studentGrade = json['student_grade'];
    dropOffByParent = json['drop_off_by_parent'];
    pickupByParent = json['pickup_by_parent'];
    fatherId = json['father_id'];
    motherId = json['mother_id'];
    other1 = json['other_1'];
    other2 = json['other_2'];
    schoolName = json['school_name'];
    schoolMobileNumber = json['school_mobile_number'];
    schoolLat = json['school_lat'];
    schoolLng = json['school_lng'];
    driverMobileNumber = json['driver_mobile_number'];
    driverMobileToken = json['driver_mobile_token'];
    driverName = json['driver_name'];
    assistantName = json['assistant_name'];
    assistantMobileNumber = json['assistant_mobile_number'];
    busId = json['bus_id'];
    roundType = json['round_type'];
    isActive = json['is_active'];
    roundName = json['round_name'];
    roundId = json['round_id'];
    assistantId = json['assistant_id'];
    routeOrder = json['route_order'];
    chatTeachers = json['chat_teachers'];
    targetLng = json['target_lng'];
    targetLat = json['target_lat'];
    licenseState = json['license_state'];
    trialDaysLeft = json['trial_days_left'];
    licenseDaysLeft = json['license_days_left'];
    semesterStartDate = json['semester_start_date'];
    semesterEndDate = json['semester_end_date'];
    showAddBusCard = json['show_add_bus_card'];
    allowUploadStudentsImages = json['allow_upload_students_images'];
    showMap = json['show_map'];
    changeLocation = json['change_location'];
    showAbsence = json['show_absence'];
    showPickupRequest = json['show_pickup_request'];
    pickupRequestDistance = json['pickup_request_distance'];
    schoolImage= json['schoolImage'];
    sessionId = json['session_id'];
    db = json['db'];
    new_chat=json['new_chat'];
    studentStatus = json['student_status'] != null
        ? new StudentStatus.fromJson(json['student_status'])
        : null;
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    if (json['mobile_numbers'] != null) {
      mobileNumbers = <MobileNumbers>[];
      json['mobile_numbers'].forEach((v) {
        mobileNumbers!.add(new MobileNumbers.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['fname'] = fname;
    data['lat'] = lat;
    data['long'] = long;
    data['id'] = id;
    data['user_id'] = userId;
    data['avatar'] = avatar;
    data['school_id'] = schoolId;
    data['student_grade'] = studentGrade;
    data['drop_off_by_parent'] = dropOffByParent;
    data['pickup_by_parent'] = pickupByParent;
    data['father_id'] = fatherId;
    data['mother_id'] = motherId;
    data['other_1'] = other1;
    data['other_2'] = other2;
    data['school_name'] = schoolName;
    data['school_mobile_number'] = schoolMobileNumber;
    data['school_lat'] = schoolLat;
    data['school_lng'] = schoolLng;
    data['driver_mobile_number'] = driverMobileNumber;
    data['driver_mobile_token'] = driverMobileToken;
    data['driver_name'] = driverName;
    data['assistant_name'] = assistantName;
    data['assistant_mobile_number'] = assistantMobileNumber;
    data['bus_id'] = busId;
    data['round_type'] = roundType;
    data['is_active'] = isActive;
    data['round_name'] = roundName;
    data['round_id'] = roundId;
    data['assistant_id'] = assistantId;
    data['route_order'] = routeOrder;
    data['chat_teachers'] = chatTeachers;
    data['target_lng'] = targetLng;
    data['target_lat'] = targetLat;
    data['license_state'] = licenseState;
    data['trial_days_left'] = trialDaysLeft;
    data['license_days_left'] = licenseDaysLeft;
    data['semester_start_date'] = semesterStartDate;
    data['semester_end_date'] = semesterEndDate;
    data['show_add_bus_card'] = showAddBusCard;
    data['allow_upload_students_images'] = allowUploadStudentsImages;
    data['show_map'] = showMap;
    data['change_location'] = changeLocation;
    data['show_absence'] = showAbsence;
    data['db'] = db;
    data['show_pickup_request'] = showPickupRequest;
    data['pickup_request_distance'] = pickupRequestDistance;
    data['schoolImage']=schoolImage;
    data['session_id'] = sessionId;
    data['new_chat']=new_chat;

    if (studentStatus != null) {
      data['student_status'] = studentStatus!.toJson();
    }
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    if (mobileNumbers != null) {
      data['mobile_numbers'] =
          mobileNumbers!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class StudentStatus {
  String? activityType;
  int? roundId;
  String? datetime;

  StudentStatus({this.activityType, this.roundId, this.datetime});

  StudentStatus.fromJson(Map<String, dynamic> json) {
    activityType = json['activity_type'];
    roundId = json['round_id'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_type'] = activityType;
    data['round_id'] = roundId;
    data['datetime'] = datetime;
    return data;
  }
}

class Features {
  String? name;
  String? nameAr;
  String? icon;
  String? url;
  String? arabicUrl;
  String?mobile_number;
  String?school_name;
  String? icon_svg;
  bool? new_add;

  Features({this.name, this.nameAr, this.icon, this.url, this.arabicUrl,this.mobile_number,this.school_name,this.icon_svg,this.new_add});

  Features.fromJson(Map<String, dynamic> json) {

    name = json['name'];
    nameAr = json['name_ar'];
    icon = json['icon'];
    url = json['url'];
    arabicUrl = json['arabic_url'];
    icon_svg = json['icon_svg'];
    new_add = json['new_add'];
  //  icon_svg
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['name_ar'] = nameAr;
    data['icon'] = icon;
    data['url'] = url;
    data['arabic_url'] = arabicUrl;
    data['icon_svg'] = icon;
    data['new_add'] = new_add;
    return data;
  }
}

class MobileNumbers {
  String? mobile;
  String? name;
  String? type;

  MobileNumbers({this.mobile, this.name, this.type});

  MobileNumbers.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile'] = mobile;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}

