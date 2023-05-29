abstract class FCMRepository {
  Future<int> sendMessage({required String title, required String message});
}
