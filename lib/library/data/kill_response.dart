import 'package:hive/hive.dart';
import 'user.dart';
part 'kill_response.g.dart';

@HiveType(typeId: 25)
class KillResponse extends HiveObject {
  @HiveField(0)
  User? killer;

  @HiveField(1)
  String? message;

  @HiveField(2)
  String? organizationId;

  @HiveField(3)
  String? date;

  @HiveField(4)
  User? user;
  @HiveField(5)
  String? id;


  KillResponse(
      {required this.message,
        required this.organizationId,
        required this.date,
        this.id,
        required this.user,
        required this.killer}); // KillResponse({required this.message, this.userId, required this.date});

  KillResponse.fromJson(Map data) {
    // pp(data);
    message = data['message'];
    date = data['date'];
    organizationId = data['organizationId'];
    id = data['id'];
    if (data['user'] != null) {
      user = User.fromJson(data['user']);
    }
    if (data['killer'] != null) {
      user = User.fromJson(data['killer']);
    }

  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'message': message,
      'organizationId': organizationId,
      'date': date,
      'id': id,
      'user': user == null ? null : user!.toJson(),
      'killer': killer == null ? null : killer!.toJson(),
    };
    return map;
  }
}