import '../../providers/fcm_provider.dart';
import 'fcm_repository.dart';

class FCMREpositoryImpl implements FCMRepository {
  final _fcmProvider = FCMProvider();
  @override
  Future<int> sendMessage(
      {required String title, required String message}) async {
    final result =
        await _fcmProvider.sendMessage(title: title, message: message);
    return result.statusCode;
  }
}
