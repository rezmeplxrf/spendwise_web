class Router {
  final Map<String, Function> _routes = {};

  void register(String routePath, Function callback) {
    _routes[routePath] = callback;
  }

  void route(String path) {
    _routes[path]?.call();
  }
}