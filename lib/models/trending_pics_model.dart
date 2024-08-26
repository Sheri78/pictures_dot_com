class TrendingPicsModel {
  TrendingPicsModel({
    required this.success,
    required this.images,
  });

  final bool? success;
  final List<TrendingPicsModelImage> images;

  factory TrendingPicsModel.fromJson(Map<String, dynamic> json) {
    return TrendingPicsModel(
      success: json["success"],
      images: json["images"] == null
          ? []
          : List<TrendingPicsModelImage>.from(json["images"]!.map((x) => TrendingPicsModelImage.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "images": images.map((x) => x?.toJson()).toList(),
  };
}

class TrendingPicsModelImage {
  TrendingPicsModelImage({
    required this.id,
    required this.userId,
    required this.v,
    required this.createdAt,
    required this.images,
  });

  final String? id;
  final String? userId;
  final int? v;
  final DateTime? createdAt;
  final List<ImageImage> images;

  factory TrendingPicsModelImage.fromJson(Map<String, dynamic> json) {
    return TrendingPicsModelImage(
      id: json["_id"],
      userId: json["userId"],
      v: json["__v"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      images: json["images"] == null
          ? []
          : List<ImageImage>.from(json["images"]!.map((x) => ImageImage.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "images": images.map((x) => x?.toJson()).toList(),
  };
}

class ImageImage {
  ImageImage({
    required this.isVerify,
    required this.publicId,
    required this.url,
    required this.description,
    required this.tags,
    required this.name,
    required this.category,
    required this.id,
    required this.subCategory,
    required this.status,
    required this.remarks,
    required this.contentRating,
    required this.adultPercentage,
    required this.violencePercentage,
    required this.racyPercentage,
    required this.medicalPercentage,
    required this.spoofPercentage,
  });

  final bool? isVerify;
  final String? publicId;
  final String? url;
  final String? description;
  final String? tags;
  final String? name;
  final String? category;
  final String? id;
  final String? subCategory;
  final String? status;
  final ContentRating? remarks;
  final ContentRating? contentRating;
  final int? adultPercentage;
  final int? violencePercentage;
  final int? racyPercentage;
  final int? medicalPercentage;
  final int? spoofPercentage;

  factory ImageImage.fromJson(Map<String, dynamic> json) {
    return ImageImage(
      isVerify: json["isVerify"],
      publicId: json["public_id"],
      url: json["url"],
      description: json["description"],
      tags: json["tags"],
      name: json["name"],
      category: json["category"],
      id: json["_id"],
      subCategory: json["subCategory"],
      status: json["status"],
      remarks: json["remarks"] == null ? null : ContentRating.fromJson(json["remarks"]),
      contentRating: json["contentRating"] == null ? null : ContentRating.fromJson(json["contentRating"]),
      adultPercentage: json["adultPercentage"],
      violencePercentage: json["violencePercentage"],
      racyPercentage: json["racyPercentage"],
      medicalPercentage: json["medicalPercentage"],
      spoofPercentage: json["spoofPercentage"],
    );
  }

  Map<String, dynamic> toJson() => {
    "isVerify": isVerify,
    "public_id": publicId,
    "url": url,
    "description": description,
    "tags": tags,
    "name": name,
    "category": category,
    "_id": id,
    "subCategory": subCategory,
    "status": status,
    "remarks": remarks?.toJson(),
    "contentRating": contentRating?.toJson(),
    "adultPercentage": adultPercentage,
    "violencePercentage": violencePercentage,
    "racyPercentage": racyPercentage,
    "medicalPercentage": medicalPercentage,
    "spoofPercentage": spoofPercentage,
  };
}

class ContentRating {
  ContentRating({
    required this.adult,
    required this.violence,
    required this.racy,
    required this.medical,
    required this.spoof,
    required this.id,
  });

  final String? adult;
  final String? violence;
  final String? racy;
  final String? medical;
  final String? spoof;
  final String? id;

  factory ContentRating.fromJson(Map<String, dynamic> json) {
    return ContentRating(
      adult: json["adult"],
      violence: json["violence"],
      racy: json["racy"],
      medical: json["medical"],
      spoof: json["spoof"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "violence": violence,
    "racy": racy,
    "medical": medical,
    "spoof": spoof,
    "_id": id,
  };
}
