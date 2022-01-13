import '../../loglytics.dart';
import '../loglytics/loglytics.dart';
import 'analytic.dart';
import 'analytics_interface.dart';

/// Used to provide an easy interface for sending analytics.
///
/// Each [AnalyticsTypes] has its own method that receives a subject and possible parameters.
/// For example when using the [AnalyticsService.viewed] method with given subject 'counter_page'
/// your [AnalyticsService._analyticsImplementation] will attempt to send a 'counter_page_viewed'
/// event.
class AnalyticsService {
  AnalyticsService({
    Loglytics? loglytics,
    AnalyticsInterface? analyticsImplementation,
    CrashReportsInterface? crashReportsImplementation,
  })  : _loglytics = loglytics,
        _analyticsImplementation = analyticsImplementation,
        _crashReportsImplementation = crashReportsImplementation;

  final Loglytics? _loglytics;
  final AnalyticsInterface? _analyticsImplementation;
  final CrashReportsInterface? _crashReportsImplementation;

  /// Used to identify the first input when sending a stream of similar analytics.
  Analytic? _firstInput;

  /// Sets a [userId] that persists throughout the app.
  ///
  /// This applies to your possible [_analyticsImplementation] as well as your
  /// [_crashReportsImplementation].
  void userId({required String userId}) {
    _analyticsImplementation?.setUserId(userId);
    _crashReportsImplementation?.setUserIdentifier(userId);
    _loglytics?.logAnalytic(name: 'user_id', value: userId);
  }

  /// Sets a user [property] and [value] that persists throughout the app.
  ///
  /// This applies to your possible [_analyticsImplementation] as well as your
  /// [_crashReportsImplementation].
  void userProperty({required String property, required Object? value}) {
    final _value = value?.toString() ?? '';
    if (_value.isNotEmpty) {
      _analyticsImplementation?.setUserProperty(name: property, value: _value);
      _crashReportsImplementation?.setCustomKey(property, _value);
      _loglytics?.logAnalytic(name: property, value: _value);
    } else {
      _loglytics?.logError('Refused setting empty value for $property');
    }
  }

  /// Main method used for sending for the more flexible [CustomAnalytic]s.
  void custom({required CustomAnalytic analytic}) =>
      _logCustomAnalytic(analytic);

  /// Sends an [AnalyticsTypes.tapped] based on given [subject] and possible [parameters].
  void tapped({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.tapped,
        ),
      );

  /// Sends an [AnalyticsTypes.clicked] based on given [subject] and possible [parameters].
  void clicked({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.clicked,
        ),
      );

  /// Sends an [AnalyticsTypes.focussed] based on given [subject] and possible [parameters].
  void focussed({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.focussed,
        ),
      );

  /// Sends an [AnalyticsTypes.selected] based on given [subject] and possible [parameters].
  void selected({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.selected,
        ),
      );

  /// Sends an [AnalyticsTypes.connected] based on given [subject] and possible [parameters].
  void connected({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.connected,
        ),
      );

  /// Sends an [AnalyticsTypes.disconnected] based on given [subject] and possible [parameters].
  void disconnected({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.disconnected,
        ),
      );

  /// Sends an [AnalyticsTypes.viewed] based on given [subject] and possible [parameters].
  void viewed({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.viewed,
        ),
      );

  /// Sends an [AnalyticsTypes.hidden] based on given [subject] and possible [parameters].
  void hidden({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.hidden,
        ),
      );

  /// Sends an [AnalyticsTypes.opened] based on given [subject] and possible [parameters].
  void opened({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.opened,
        ),
      );

  /// Sends an [AnalyticsTypes.closed] based on given [subject] and possible [parameters].
  void closed({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.closed,
        ),
      );

  /// Sends an [AnalyticsTypes.failed] based on given [subject] and possible [parameters].
  void failed({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.failed,
        ),
      );

  /// Sends an [AnalyticsTypes.succeeded] based on given [subject] and possible [parameters].
  void succeeded({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.succeeded,
        ),
      );

  /// Sends an [AnalyticsTypes.sent] based on given [subject] and possible [parameters].
  void sent({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.sent,
        ),
      );

  /// Sends an [AnalyticsTypes.received] based on given [subject] and possible [parameters].
  void received({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.received,
        ),
      );

  /// Sends an [AnalyticsTypes.validated] based on given [subject] and possible [parameters].
  void validated({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.validated,
        ),
      );

  /// Sends an [AnalyticsTypes.invalidated] based on given [subject] and possible [parameters].
  void invalidated({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.invalidated,
        ),
      );

  /// Sends an [AnalyticsTypes.searched] based on given [subject] and possible [parameters].
  void searched({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.searched,
        ),
      );

  /// Sends an [AnalyticsTypes.liked] based on given [subject] and possible [parameters].
  void liked({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.liked,
        ),
      );

  /// Sends an [AnalyticsTypes.shared] based on given [subject] and possible [parameters].
  void shared({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.shared,
        ),
      );

  /// Sends an [AnalyticsTypes.commented] based on given [subject] and possible [parameters].
  void commented({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.commented,
        ),
      );

  /// Sends an [AnalyticsTypes.input] based on given [subject] and possible [parameters].
  ///
  /// Defaults to only sending the first analytic by settings [onlyFirstValue] to true.
  void input({
    required String subject,
    Map<String, Object?>? parameters,
    bool onlyFirstValue = true,
  }) {
    final analytic = Analytic(
      subject: subject,
      parameters: parameters,
      type: AnalyticsTypes.input,
    );
    if (_firstInput == null ||
        !onlyFirstValue ||
        !analytic.equals(_firstInput)) {
      _logAnalytic(analytic);
    }
    _firstInput = analytic;
  }

  /// Sends an [AnalyticsTypes.incremented] based on given [subject] and possible [parameters].
  void incremented({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.incremented,
        ),
      );

  /// Sends an [AnalyticsTypes.decremented] based on given [subject] and possible [parameters].
  void decremented({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.decremented,
        ),
      );

  /// Sends an [AnalyticsTypes.accepted] based on given [subject] and possible [parameters].
  void accepted({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.accepted,
        ),
      );

  /// Sends an [AnalyticsTypes.declined] based on given [subject] and possible [parameters].
  void declined({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.declined,
        ),
      );

  /// Sends an [AnalyticsTypes.alert] based on given [subject] and possible [parameters].
  void alert({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.alert,
        ),
      );

  /// Sends an [AnalyticsTypes.scrolled] based on given [subject] and possible [parameters].
  void scrolled({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.scrolled,
        ),
      );

  /// Sends an [AnalyticsTypes.started] based on given [subject] and possible [parameters].
  void started({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.started,
        ),
      );

  /// Sends an [AnalyticsTypes.stopped] based on given [subject] and possible [parameters].
  void stopped({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.stopped,
        ),
      );

  /// Sends an [AnalyticsTypes.initialised] based on given [subject] and possible [parameters].
  void initialised({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.initialised,
        ),
      );

  /// Sends an [AnalyticsTypes.disposed] based on given [subject] and possible [parameters].
  void disposed({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.disposed,
        ),
      );

  /// Sends an [AnalyticsTypes.fetched] based on given [subject] and possible [parameters].
  void fetched({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.fetched,
        ),
      );

  /// Sends an [AnalyticsTypes.set] based on given [subject] and possible [parameters].
  void set({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.set,
        ),
      );

  /// Sends an [AnalyticsTypes.get] based on given [subject] and possible [parameters].
  void get({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.get,
        ),
      );

  /// Sends an [AnalyticsTypes.foreground] based on given [subject] and possible [parameters].
  void foreground({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.foreground,
        ),
      );

  /// Sends an [AnalyticsTypes.background] based on given [subject] and possible [parameters].
  void background({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.background,
        ),
      );

  /// Sends an [AnalyticsTypes.purchased] based on given [subject] and possible [parameters].
  void purchased({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.purchased,
        ),
      );

  /// Sends an [AnalyticsTypes.dismissed] based on given [subject] and possible [parameters].
  void dismissed({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.dismissed,
        ),
      );

  /// Sends an [AnalyticsTypes.upgraded] based on given [subject] and possible [parameters].
  void upgraded({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.upgraded,
        ),
      );

  /// Sends an [AnalyticsTypes.downgraded] based on given [subject] and possible [parameters].
  void downgraded({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.downgraded,
        ),
      );

  /// Sends an [AnalyticsTypes.interaction] based on given [subject] and possible [parameters].
  void interaction({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.interaction,
        ),
      );

  /// Sends an [AnalyticsTypes.query] based on given [subject] and possible [parameters].
  void query({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.query,
        ),
      );

  /// Sends an [AnalyticsTypes.confirmed] based on given [subject] and possible [parameters].
  void confirmed({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.confirmed,
        ),
      );

  /// Sends an [AnalyticsTypes.canceled] based on given [subject] and possible [parameters].
  void canceled({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.canceled,
        ),
      );

  /// Sends an [AnalyticsTypes.created] based on given [subject] and possible [parameters].
  void created({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.created,
        ),
      );

  /// Sends an [AnalyticsTypes.read] based on given [subject] and possible [parameters].
  void read({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.read,
        ),
      );

  /// Sends an [AnalyticsTypes.updated] based on given [subject] and possible [parameters].
  void updated({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.updated,
        ),
      );

  /// Sends an [AnalyticsTypes.deleted] based on given [subject] and possible [parameters].
  void deleted({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.deleted,
        ),
      );

  /// Sends an [AnalyticsTypes.added] based on given [subject] and possible [parameters].
  void added({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.added,
        ),
      );

  /// Sends an [AnalyticsTypes.removed] based on given [subject] and possible [parameters].
  void removed({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.removed,
        ),
      );

  /// Sends an [AnalyticsTypes.subscribed] based on given [subject] and possible [parameters].
  void subscribed({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.subscribed,
        ),
      );

  /// Sends an [AnalyticsTypes.unsubscribed] based on given [subject] and possible [parameters].
  void unsubscribed({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.unsubscribed,
        ),
      );

  /// Sends an [AnalyticsTypes.changed] based on given [subject] and possible [parameters].
  void changed({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.changed,
        ),
      );

  /// Sends an [AnalyticsTypes.denied] based on given [subject] and possible [parameters].
  void denied({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.denied,
        ),
      );

  /// Sends an [AnalyticsTypes.skipped] based on given [subject] and possible [parameters].
  void skipped({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.skipped,
        ),
      );

  /// Sends an [AnalyticsTypes.checked] based on given [subject] and possible [parameters].
  void checked({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.checked,
        ),
      );

  /// Sends an [AnalyticsTypes.unchecked] based on given [subject] and possible [parameters].
  void unchecked({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.unchecked,
        ),
      );

  /// Sends an [AnalyticsTypes.attempted] based on given [subject] and possible [parameters].
  void attempted({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.attempted,
        ),
      );

  /// Sends an [AnalyticsTypes.reset] based on given [subject] and possible [parameters].
  void reset({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.reset,
        ),
      );

  /// Sends an [AnalyticsTypes.enabled] based on given [subject] and possible [parameters].
  void enabled({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.enabled,
        ),
      );

  /// Sends an [AnalyticsTypes.disabled] based on given [subject] and possible [parameters].
  void disabled({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.disabled,
        ),
      );

  /// Sends an [AnalyticsTypes.began] based on given [subject] and possible [parameters].
  void began({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.began,
        ),
      );

  /// Sends an [AnalyticsTypes.ended] based on given [subject] and possible [parameters].
  void ended({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.ended,
        ),
      );

  /// Sends an [AnalyticsTypes.refreshed] based on given [subject] and possible [parameters].
  void refreshed({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.refreshed,
        ),
      );

  /// Sends an [AnalyticsTypes.generated] based on given [subject] and possible [parameters].
  void generated({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.generated,
        ),
      );

  /// Sends an [AnalyticsTypes.unsupported] based on given [subject] and possible [parameters].
  void unsupported({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.unsupported,
        ),
      );

  /// Sends an [AnalyticsTypes.invalid] based on given [subject] and possible [parameters].
  void invalid({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.invalid,
        ),
      );

  /// Sends an [AnalyticsTypes.valid] based on given [subject] and possible [parameters].
  void valid({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.valid,
        ),
      );

  /// Sends an [AnalyticsTypes.shown] based on given [subject] and possible [parameters].
  void shown({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.shown,
        ),
      );

  /// Sends an [AnalyticsTypes.saved] based on given [subject] and possible [parameters].
  void saved({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.saved,
        ),
      );

  /// Sends an [AnalyticsTypes.loaded] based on given [subject] and possible [parameters].
  void loaded({
    required String subject,
    Map<String, Object?>? parameters,
  }) =>
      _logAnalytic(
        Analytic(
          subject: subject,
          parameters: parameters,
          type: AnalyticsTypes.loaded,
        ),
      );

  /// Sends the current screen based on given [subject] and possible [parameters].
  void screen({
    required String subject,
  }) {
    final name = subject;
    _analyticsImplementation?.setCurrentScreen(name: name);
    _loglytics?.logAnalytic(name: name);
  }

  /// Resets all current analytics data.
  Future<void> resetAnalytics() async =>
      _analyticsImplementation?.resetAnalyticsData();

  /// Resets the [_firstInput] used by [AnalyticsService.input].
  void resetFirstInput() => _firstInput = null;

  /// Main method used for sending any [analytic] in this class.
  void _logAnalytic(Analytic analytic) {
    final name = analytic.name;
    final parameters = analytic.parameters;
    _analyticsImplementation?.logEvent(name: name, parameters: parameters);
    _loglytics?.logAnalytic(name: name, parameters: parameters);
  }

  /// Alternate method used for sending [CustomAnalytic]s.
  void _logCustomAnalytic(CustomAnalytic customAnalytic) {
    final name = customAnalytic.name;
    final parameters = customAnalytic.parameters;
    _analyticsImplementation?.logEvent(name: name, parameters: parameters);
    _loglytics?.logAnalytic(name: name, parameters: parameters);
  }
}
