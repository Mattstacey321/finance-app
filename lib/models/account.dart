import 'package:hive/hive.dart';
part 'account.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject{
  @HiveField(0)
  String nickName;
  @HiveField(1)
  String email;
  @HiveField(2)
  String fullName;
  @HiveField(3)
  int balance;
  Account({this.nickName, this.fullName, this.email, this.balance});
}
