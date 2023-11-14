class Canteen_Student {
  List<FoodAllegies>? foodAllegies;
  String? bannedFood;
  List<SchduleMeals>? schduleMeals;
  List<Spending>? spending;

  Canteen_Student(
      {this.foodAllegies, this.bannedFood, this.schduleMeals, this.spending});

  Canteen_Student.fromJson(Map<String, dynamic> json) {
    if (json['food_allegies'] != null) {
      foodAllegies = <FoodAllegies>[];
      json['food_allegies'].forEach((v) {
        foodAllegies!.add(new FoodAllegies.fromJson(v));
      });
    }
    bannedFood = json['banned_food'];
    if (json['schdule_meals'] != null) {
      schduleMeals = <SchduleMeals>[];
      json['schdule_meals'].forEach((v) {
        schduleMeals!.add(new SchduleMeals.fromJson(v));
      });
    }
    if (json['spending'] != null) {
      spending = <Spending>[];
      json['spending'].forEach((v) {
        spending!.add(new Spending.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foodAllegies != null) {
      data['food_allegies'] =
          this.foodAllegies!.map((v) => v.toJson()).toList();
    }
    data['banned_food'] = this.bannedFood;
    if (this.schduleMeals != null) {
      data['schdule_meals'] =
          this.schduleMeals!.map((v) => v.toJson()).toList();
    }
    if (this.spending != null) {
      data['spending'] = this.spending!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodAllegies {
  String? name;

  FoodAllegies({this.name});

  FoodAllegies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class SchduleMeals {
  String? name;
  String? lenItem;
  int ? day_id;

  SchduleMeals({this.name, this.lenItem,this.day_id});

  SchduleMeals.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lenItem = json['len_item'];
    day_id = json['day_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['len_item'] = this.lenItem;
    data['day_id'] = this.day_id;
    return data;
  }
}

class Spending {
  String? canteenSpending;
  String? studentSpending;
  double? perSpending;

  Spending({this.canteenSpending, this.studentSpending, this.perSpending});

  Spending.fromJson(Map<String, dynamic> json) {
    canteenSpending = json['canteen_spending'];
    studentSpending = json['student_spending'];
    perSpending = json['per_spending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canteen_spending'] = this.canteenSpending;
    data['student_spending'] = this.studentSpending;
    data['per_spending'] = this.perSpending;
    return data;
  }
}