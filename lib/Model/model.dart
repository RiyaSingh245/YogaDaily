class YogaModel {
  static String yogaTable1 = "BeginnerYoga";
  static String yogaTable2 = "WeightLossYoga";
  static String yogaTable3 = "KidsYoga";
  static String secondsORtimes = "secondsORtimes";
  static String yogaSummary = "yogaSummary";
  static String workOutName = "workOutName";
  static String bgimageName = "bgimageName";
  static String timeTaken = "timeTaken";
  static String noOfWorkOut = "noOfWorkOut";
  static String idName = "ID";
  static String yogaName = "YogaName";
  static String secondsOrNot = "SecondsOrNot";
  static String imageName = "ImageName";
  static String yogaKey = "yogaKey";
  static String yogaKeyWorkout = "yogaKeyWorkout";
  static List<String>? yogaTable1ColumnName = [
    YogaModel.idName,
    YogaModel.secondsOrNot,
    YogaModel.yogaName,
    YogaModel.imageName,
    YogaModel.secondsORtimes,
  ];
}

class Yoga {
  final int? id;
  final int? yogaKeyWorkout;
  final bool seconds;
  final String yogaTitle;
  final String yogaImgUrl;
  final String secondsORtimes;

  Yoga({
    this.id,
    required this.seconds,
    required this.yogaTitle,
    required this.yogaKeyWorkout,
    required this.yogaImgUrl,
    required this.secondsORtimes,
  });

  Yoga copy({
    int? id,
    bool? seconds,
    String? yogaTitle,
    String? yogaImgUrl,
    int? yogaKeyWorkout,
    String? secondsORtimes,
  }) {
    return Yoga(
      id: id ?? this.id,
      seconds: seconds ?? this.seconds,
      yogaTitle: yogaTitle ?? this.yogaTitle,
      yogaKeyWorkout: yogaKeyWorkout ?? this.yogaKeyWorkout,
      yogaImgUrl: yogaImgUrl ?? this.yogaImgUrl,
      secondsORtimes: secondsORtimes ?? this.secondsORtimes,
    );
  }

  static Yoga fromJson(Map<String, Object?> json) {
    return Yoga(
        id: json[YogaModel.idName] as int?,
        yogaKeyWorkout: json[YogaModel.yogaKeyWorkout] as int?,
        seconds: json[YogaModel.secondsOrNot] == 1,
        yogaTitle: json[YogaModel.yogaName] as String,
        yogaImgUrl: json[YogaModel.imageName] as String,
        secondsORtimes: json[YogaModel.secondsORtimes] as String);
  }

  Map<String, Object?> toJson() {
    return {
      YogaModel.idName: id,
      YogaModel.secondsOrNot: seconds ? 1 : 0,
      YogaModel.yogaName: yogaTitle,
      YogaModel.imageName: yogaImgUrl,
      YogaModel.secondsORtimes: secondsORtimes,
      YogaModel.yogaKeyWorkout: yogaKeyWorkout,
    };
  }
}

class YogaSummary {
  final int? id;
  final int? yogaKey;
  final String workOutName;
  final String bgimageName;
  final String timeTaken;
  final String noOfWorkOut;

  YogaSummary({
    this.id,
    required this.yogaKey,
    required this.workOutName,
    required this.bgimageName,
    required this.timeTaken,
    required this.noOfWorkOut,
  });

  YogaSummary copy({
    int? id,
    int? yogaKey,
    String? workOutName,
    String? bgimageName,
    String? timeTaken,
    String? noOfWorkOut,
  }) {
    return YogaSummary(
      id: id ?? this.id,
      yogaKey: yogaKey ?? this.yogaKey,
      workOutName: workOutName ?? this.workOutName,
      bgimageName: bgimageName ?? this.bgimageName,
      timeTaken: timeTaken ?? this.timeTaken,
      noOfWorkOut: noOfWorkOut ?? this.noOfWorkOut,
    );
  }

  static YogaSummary fromJson(Map<String, Object?> json) {
    return YogaSummary(
      id: json[YogaModel.idName] as int?,
      yogaKey: json[YogaModel.yogaKey] as int?,
      workOutName: json[YogaModel.workOutName] as String,
      bgimageName: json[YogaModel.bgimageName] as String,
      timeTaken: json[YogaModel.timeTaken] as String,
      noOfWorkOut: json[YogaModel.noOfWorkOut] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      YogaModel.idName: id,
      YogaModel.yogaKey: yogaKey,
      YogaModel.workOutName: workOutName,
      YogaModel.bgimageName: bgimageName,
      YogaModel.timeTaken: timeTaken,
      YogaModel.noOfWorkOut: noOfWorkOut,
    };
  }
}
