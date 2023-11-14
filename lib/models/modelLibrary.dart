class ModelLibrary {
  List<BookRequest>? bookRequest;
  List<BookBorrowed>? bookBorrowed;
  List<Book>? book;

  ModelLibrary({this.bookRequest, this.bookBorrowed, this.book});

  ModelLibrary.fromJson(Map<String, dynamic> json) {
    if (json['book_request'] != null) {
      bookRequest = <BookRequest>[];
      json['book_request'].forEach((v) {
        bookRequest!.add(new BookRequest.fromJson(v));
      });
    }
    if (json['book_borrowed'] != null) {
      bookBorrowed = <BookBorrowed>[];
      json['book_borrowed'].forEach((v) {
        bookBorrowed!.add(new BookBorrowed.fromJson(v));
      });
    }
    if (json['book'] != null) {
      book = <Book>[];
      json['book'].forEach((v) {
        book!.add(new Book.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookRequest != null) {
      data['book_request'] = this.bookRequest!.map((v) => v.toJson()).toList();
    }
    if (this.bookBorrowed != null) {
      data['book_borrowed'] =
          this.bookBorrowed!.map((v) => v.toJson()).toList();
    }
    if (this.book != null) {
      data['book'] = this.book!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookRequest {
  int? id;
  String? name;
  String? requestedDate;
  String? status;

  BookRequest({this.id, this.name, this.requestedDate, this.status});

  BookRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    requestedDate = json['requested_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['requested_date'] = this.requestedDate;
    data['status'] = this.status;
    return data;
  }
}

class BookBorrowed {
  int? id;
  String? name;
  String? dateDelivered;
  String? dateReturned;
  String? dateReturnedOn;
  String? status;
  String? bookAuthor;

  BookBorrowed(
      {this.id,
        this.name,
        this.dateDelivered,
        this.dateReturned,this.dateReturnedOn,
        this.status,
        this.bookAuthor});

  BookBorrowed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateDelivered = json['date_delivered'];
    dateReturned = json['date_returned'];
dateReturnedOn = json['date_returned_on'];
    status = json['status'];
    bookAuthor = json['book_author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date_delivered'] = this.dateDelivered;
    data['date_returned'] = this.dateReturned;
    data['status'] = this.status;
    data['book_author'] = this.bookAuthor;
   data['date_returned_on']=this.dateReturnedOn;
    return data;
  }
}

class Book {
  int? id;
  String? name;
  String? borrow_days;

  Book({this.id, this.name,this.borrow_days});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    borrow_days = json['borrow_period_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
     data['borrow_period_days']=this.borrow_days;
    return data;
  }
}