import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import '../flutter_flow_theme.dart';

import '../../backend/supabase/supabase.dart';

import '../../index.dart';
import '../../main.dart';
import '../lat_lng.dart';
import '../place.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, _) => NavBarPage(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => NavBarPage(),
          routes: [
            FFRoute(
              name: 'ShoppingList',
              path: 'shoppingList',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: ShoppingListWidget(),
              ),
            ),
            FFRoute(
              name: 'AldiLidl',
              path: 'aldiLidl',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: AldiLidlWidget(),
              ),
            ),
            FFRoute(
              name: 'Iceland',
              path: 'iceland',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: IcelandWidget(),
              ),
            ),
            FFRoute(
              name: 'Regular',
              path: 'regular',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: RegularWidget(),
              ),
            ),
            FFRoute(
              name: 'ALL',
              path: 'all',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: AllWidget(),
              ),
            ),
            FFRoute(
              name: 'Essentials',
              path: 'essentials',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: EssentialsWidget(),
              ),
            ),
            FFRoute(
              name: 'Fridge',
              path: 'fridge',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: FridgeWidget(),
              ),
            ),
            FFRoute(
              name: 'Frozen',
              path: 'frozen',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: FrozenWidget(),
              ),
            ),
            FFRoute(
              name: 'Sweet',
              path: 'sweet',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: SweetWidget(),
              ),
            ),
            FFRoute(
              name: 'Drinks',
              path: 'drinks',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: DrinksWidget(),
              ),
            ),
            FFRoute(
              name: 'FruitnVeg',
              path: 'fruitnVeg',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: FruitnVegWidget(),
              ),
            ),
            FFRoute(
              name: 'Misc',
              path: 'misc',
              builder: (context, params) => NavBarPage(
                initialPage: '',
                page: MiscWidget(),
              ),
            ),
            FFRoute(
              name: 'Select',
              path: 'select',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'Select')
                  : SelectWidget(),
            ),
            FFRoute(
              name: 'AllShopping',
              path: 'allShopping',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'AllShopping')
                  : AllShoppingWidget(),
            ),
            FFRoute(
              name: 'Shops',
              path: 'shops',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'Shops')
                  : ShopsWidget(),
            ),
            FFRoute(
              name: 'List',
              path: 'list',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'List')
                  : ListWidget(),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      urlPathStrategy: UrlPathStrategy.path,
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (GoRouter.of(this).routerDelegate.matches.length <= 1) {
      go('/');
    } else {
      pop();
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(params)
    ..addAll(queryParams)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}
