import '../enums/log_type.dart';

/// Used to define a proper name per [LogType] when icons are not preferred.
extension LogTypeExtensions on LogType {
  String get name {
    switch (this) {
      case LogType.info:
        return '[INFO]';
      case LogType.warning:
        return '[WARNING]';
      case LogType.error:
        return '[ERROR]';
      case LogType.success:
        return '[SUCCESS]';
      case LogType.analytic:
        return '[ANALYTIC]';
      case LogType.value:
        return '[VALUE]';
      case LogType.debug:
        return '[DEBUG]';
      case LogType.mvvm:
        return '[MVVM]';
      case LogType.bloc:
        return '[BLOC]';
      case LogType.test:
        return '[TEST]';
    }
  }

  /// Used to define a proper icon per [LogType] when a name is not preferred.
  String get icon {
    switch (this) {
      case LogType.info:
        return '๐ฃ $name';
      case LogType.warning:
        return 'โ  $name';
      case LogType.error:
        return 'โ $name';
      case LogType.success:
        return 'โ $name';
      case LogType.analytic:
        return '๐ $name';
      case LogType.value:
        return '๐พ $name';
      case LogType.debug:
        return '๐ $name';
      case LogType.mvvm:
        return '๐ $name';
      case LogType.bloc:
        return '๐งฑ $name';
      case LogType.test:
        return '๐งช $name';
    }
  }
}
