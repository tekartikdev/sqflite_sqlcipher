import 'package:flutter/services.dart';
import 'package:sqflite/src/constant.dart';
import 'package:sqflite/src/exception.dart';

/// Wrap any exception to a [DatabastException]
Future<T> wrapDatabaseException<T>(Future<T> action()) async {
  try {
    final T result = await action();
    return result;
  } on PlatformException catch (e) {
    if (e.code == sqliteErrorCode || 
        // Go-Flutter doesn't handle custom error codes, it returns error
        e.code == "error") {
      throw SqfliteDatabaseException(e.message, e.details);
      //rethrow;
    } else {
      rethrow;
    }
  }
}
