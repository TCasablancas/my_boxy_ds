import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();

  static final NavigationService instance = NavigationService._();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory NavigationService() => instance;

  NavigatorState get _navigator {
    final navigator = navigatorKey.currentState;
    if (navigator == null) {
      throw StateError(
        'NavigationService is not attached to a MaterialApp navigator.',
      );
    }
    return navigator;
  }

  Future<T?> pushFactory<T extends Object?>(
      Widget Function(List<dynamic> parameters) pageFactory, {
        List<dynamic> parameters = const <dynamic>[],
        RouteSettings? settings,
      }) {
    return _navigator.push<T>(
      MaterialPageRoute<T>(
        builder: (_) => pageFactory(parameters),
        settings: settings,
      ),
    );
  }

  Future<T?> push<T extends Object?>(Widget page, {RouteSettings? settings}) {
    return _navigator.push<T>(
      MaterialPageRoute<T>(builder: (_) => page, settings: settings),
    );
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
      String routeName, {
        TO? result,
        Object? arguments,
      }) {
    return _navigator.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
      Widget page, {
        RouteSettings? settings,
        TO? result,
      }) {
    return _navigator.pushReplacement<T, TO>(
      MaterialPageRoute<T>(builder: (_) => page, settings: settings),
      result: result,
    );
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(
      Widget page, {
        RouteSettings? settings,
        RoutePredicate predicate = _removeAllRoutes,
      }) {
    return _navigator.pushAndRemoveUntil<T>(
      MaterialPageRoute<T>(builder: (_) => page, settings: settings),
      predicate,
    );
  }

  bool canPop() => _navigator.canPop();

  void pop<T extends Object?>([T? result]) {
    _navigator.pop<T>(result);
  }

  Future<bool> maybePop<T extends Object?>([T? result]) {
    return _navigator.maybePop<T>(result);
  }

  static bool _removeAllRoutes(Route<dynamic> route) => false;
}
