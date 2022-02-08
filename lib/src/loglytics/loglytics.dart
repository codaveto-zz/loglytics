import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/src/analytics/analytic.dart';
import 'package:loglytics/src/analytics/analytics_factory.dart';
import 'package:loglytics/src/enums/analytics_types.dart';
import 'package:loglytics/src/enums/log_type.dart';
import 'package:loglytics/src/extensions/log_type_extensions.dart';

import '../analytics/analytics.dart';
import '../analytics/analytics_interface.dart';
import '../crash_reports/crash_reports_interface.dart';
import '../extensions/date_time_extensions.dart';

part '../analytics/analytics_service.dart';
part '../log/log.dart';
part 'event_bus.dart';

/// Used to provide all logging, analytics and crashlytics functionality to a class of your choosing.
///
/// If you want to make use of the analytic functionality use [Loglytics.setUp] to provide your
/// implementations of the [AnalyticsInterface] and [CrashReportsInterface]. After doing so you can
/// add the [Loglytics] mixin to any class where you would like to add logging and/or analytics to.
/// In order to have access to the appropriate [Analytics] implementation for a specific
/// feature or part of your project you should add the implementation as generic arguments to a
/// [Loglytics] like Loglytics<CounterAnalytics>.
///
/// Defining the generic [Analytics] is optional however as the [Loglytics] will also work without
/// it. When no generic is specified you can even use our basic analytic functionality through the
/// default [Analytics.core] getter that's accessible through [Loglytics.analytics].
mixin Loglytics<D extends Analytics> {
  // Used to register and provider the proper [Analytics]
  static final GetIt _getIt = GetIt.asNewInstance();

  // Used to create an instance of Loglytics when using a mixin is not possible or breaks a const constructor.
  static Loglytics<T> create<T extends Analytics>({required String location}) =>
      _Loglytics<T>(
        location: location,
      );

  /// Used to handle events in the proper order that they are sent.
  static late final EventBus _eventBus = EventBus();

  /// Provides the configured [Analytics] functionality through the [Loglytics] mixin.
  late final D analytics = _getIt.get<D>()
    ..service = AnalyticsService(loglytics: this);

  /// Used to provide all logging capabilities.
  late final Log log = Log(
    location: location,
    maxLinesStackTrace: _maxLinesStackTrace,
  );

  /// Used to define the location of Loglytics logging and implementation.
  String get location => runtimeType.toString();

  // --------------- SETUP --------------- SETUP --------------- SETUP --------------- \\

  static AnalyticsInterface? _analyticsInterface;
  static CrashReportsInterface? _crashReportsInterface;

  static int? _maxLinesStackTrace;
  static bool _combineEvents = false;
  static bool _isActive = false;
  static bool get isActive => _isActive;

  /// Used to configure the logging and analytic abilities of the [Loglytics].
  ///
  /// Use the [analyticsInterface] and [crashReportsInterface] to specify your implementations
  /// of both functionalities. This is optional as the [Loglytics] can also be used as a pure logger.
  /// Populate the [analytics] parameter with callbacks to your [Analytics] implementations.
  /// Example: [() => CounterAnalytics(), () => CookieAnalytics()].
  static void setUp({
    AnalyticsInterface? analyticsInterface,
    CrashReportsInterface? crashReportsInterface,
    void Function(AnalyticsFactory analyticsFactory)? analytics,
    int? maxLinesStackTrace,
    bool combineEvents = true,
  }) {
    _analyticsInterface = analyticsInterface;
    _crashReportsInterface = crashReportsInterface;
    if (analytics != null) {
      registerAnalytics(analytics: analytics);
    }
    _maxLinesStackTrace = maxLinesStackTrace;
    _combineEvents = combineEvents;
    _eventBus._listen();
    _isActive = true;
  }

  /// Used to register analytics objects, default to .
  static void registerAnalytics({
    required void Function(AnalyticsFactory analyticsFactory) analytics,
    bool registerDefaultAnalytics = true,
  }) {
    final analyticsFactory = AnalyticsFactory(getIt: _getIt);
    if (registerDefaultAnalytics) {
      analyticsFactory.registerAnalytic(() => Analytics());
    }
    analytics(analyticsFactory);
  }

  /// Used to reset analytics objects.
  static Future<void> resetAnalytics() => _getIt.reset();

  /// Used to configure the logging and analytic abilities of the [Loglytics].
  static Future<void> dispose() async {
    _analyticsInterface = null;
    _crashReportsInterface = null;
    _maxLinesStackTrace = null;
    await resetAnalytics();
    await _eventBus.dispose();
    _isActive = false;
  }
}

/// Used to provide [Loglytics] as a an object while keeping mixin functionality.
class _Loglytics<X extends Analytics> with Loglytics<X> {
  _Loglytics({
    required String location,
  }) : _location = location;

  final String _location;

  @override
  String get location => _location;
}
