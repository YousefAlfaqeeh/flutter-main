

class ChatTeacher {
  String? jsonrpc;
  Null? id;
  ResultChat? result;

  ChatTeacher({this.jsonrpc, this.id, this.result});

  ChatTeacher.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result =
    json['result'] != null ? new ResultChat.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['id'] = this.id;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class ResultChat {
  List<Messages>? messages;

  ResultChat({this.messages});

  ResultChat.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        // print(v);
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? messageContent;
  String? messageType;
  String? imageTeacher;
  String? nameTeacher;
  String? date;
  String? attachmentName;
  String? attachmentType;
  String? attachmentData;
  List<AttachmentFiles>? attachmentFiles;
  int? message_id;

  Messages(
      {this.messageContent,
        this.messageType,
        this.imageTeacher,
        this.nameTeacher,
        this.date,
        this.attachmentName,
        this.attachmentType,
        this.attachmentData,
        this.attachmentFiles,
      this.message_id});

  Messages.fromJson(Map<String, dynamic> json) {
    messageContent = json['messageContent'];
    messageType = json['messageType'];
    imageTeacher = json['imageTeacher'];
    nameTeacher = json['nameTeacher'];
    date = json['date'];
    attachmentName = json['attachment_name'];
    attachmentType = json['attachment_type'];
    attachmentData = json['attachment_data'];
    message_id = json['message_id'];
    if (json['attachment_files'] != null) {
      attachmentFiles = <AttachmentFiles>[];
      json['attachment_files'].forEach((v) {
        attachmentFiles!.add(new AttachmentFiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageContent'] = this.messageContent;
    data['messageType'] = this.messageType;
    data['imageTeacher'] = this.imageTeacher;
    data['nameTeacher'] = this.nameTeacher;
    data['date'] = this.date;
    data['attachment_name'] = this.attachmentName;
    data['attachment_type'] = this.attachmentType;
    data['attachment_data'] = this.attachmentData;
    data['message_id'] = this.message_id;
    if (this.attachmentFiles != null) {
      data['attachment_files'] =
          this.attachmentFiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttachmentFiles {
  String? attachmentName;
  String? attachmentType;
  String? attachmentData;
  String? attachmentSize;
  String? attachmentUrl;
  int? attachmentId;
  AttachmentFiles(
      {this.attachmentName, this.attachmentType, this.attachmentData, this.attachmentSize, this.attachmentUrl,this.attachmentId});

  AttachmentFiles.fromJson(Map<String, dynamic> json) {
    attachmentName = json['attachment_name'];
    attachmentType = json['attachment_type'];
    attachmentData = json['attachment_data'];
    attachmentSize = json['attachment_size'];
    attachmentUrl = json['attachment_url'];
    attachmentId = json['attachment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attachment_name'] = this.attachmentName;
    data['attachment_type'] = this.attachmentType;
    data['attachment_data'] = this.attachmentData;
    data['attachment_size'] =this.attachmentSize;
    data['attachment_url'] =this.attachmentUrl;
    data['attachment_id'] =this.attachmentId;
    return data;
  }
}