abstract class BaseNetwork {
  Future get(String endPoint);
  Future post(String endPoint);
  Future delete(String endPoint);
  Future update(String endPoint);
}
