import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_entity.g.dart';
@JsonSerializable()
class UserEntity{
  String? fullName;
  String? province;
  String? district;
  String? address;
  String? city;
  int? phoneNo;
  double totalAmount;
  final List items;

  UserEntity( {
    this.fullName,
    this.address,
    this.district,
    this.province,
    this.phoneNo,
    this.city,
    required this.totalAmount,
    required this.items,

});
  factory UserEntity.fromJson(Map<String,dynamic> json)=>_$UserEntityFromJson(json);
  Map<String,dynamic> toJson()=>_$UserEntityToJson(this);
  static CollectionReference<UserEntity> collection() {
    return FirebaseFirestore.instance.collection('UserEntity').withConverter<UserEntity>(
        fromFirestore: (snapshot, _) => UserEntity.fromJson(snapshot.data()!),
        toFirestore: (userEntity


            , _) => userEntity.toJson());
  }

  static DocumentReference<UserEntity> doc({required String studentId}) {
    return FirebaseFirestore.instance.doc('UserEntity/$studentId').withConverter<UserEntity>(
        fromFirestore: (snapshot, _) => UserEntity.fromJson(snapshot.data()!),
        toFirestore: (userEntity, _) => userEntity.toJson());
  }
}