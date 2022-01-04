// To parse this JSON data, do
//
//     final caroSlide = caroSlideFromMap(jsonString);



import 'databaseItem.dart';

class CaroSlide extends DatabaseItem{
    CaroSlide({
        this.id,
        required this.imageUrl,
        required this.updateDate,
    }):super(id);

    final String? id;
    final String imageUrl;
    final DateTime updateDate;

    // CaroSlide copyWith({
    //     String id,
    //     String imageUrl,
    //     DateTime updateDate,
    // }) => 
    //     CaroSlide(
    //         id: id ?? this.id,
    //         imageUrl: imageUrl ?? this.imageUrl,
    //         updateDate: updateDate ?? this.updateDate,
    //     );


    factory CaroSlide.fromMap(String id,Map<String, dynamic> json) => CaroSlide(
        id: id,
        imageUrl: json["imageUrl"],
        updateDate: json["updateDate"]?.toDate(),
    );

    Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "updateDate": updateDate,
    };
}
