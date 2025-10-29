import 'dart:ui';

import 'package:get/get.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/core/utils/logger.dart';

class ThreadsService extends GetxService {
  /// A service that safely executes asynchronous actions within
  /// a controlled context.
  ///
  /// This wrapper is designed to:
  /// - Execute an async [ ´func´ ].
  /// - Catch and handle exceptions gracefully.
  /// - Optionally rethrow exceptions for upstream handling.
  /// - Invoke a callback ([ ´onError´ ]) only if an exception occurs.
  /// - Return `true` on success and `false` on failure.
  ///
  /// Example:
  /// ```dart
  /// final List<dynamic> assistants = [];
  /// await ThreadsService.i.execute(
  ///   func: () async {
  ///    assistants = await repository.fetchData();
  ///   },
  ///   onError: () {
  ///     assistants = [];
  ///
  ///     /// opcional: Enviar un mensaje de error
  ///     Get.snackbar('Error', 'Failed to fetch data')
  ///   },
  /// );
  /// ```
  Future<void> execute({
    required Future<void> Function() func,
    bool rethrowException = false,
    String errorMsg = '',
    VoidCallback? onError,
  }) async {
    try {
      await func.call();
    } on Exception catch (e, stack) {
      logger.e(
        'Exception caught in ThreadsService.execute: $e',
        error: e,
        stackTrace: stack,
      );

      /// callback on error
      onError?.call();

      /// error handling
      ExceptionManager.handleError(e, errorMsg);

      if (rethrowException) {
        rethrow;
      }
    }
  }
}

// class ThreadsService extends GetxService {
//   Future<bool> execute({
//     required Future<void> Function() func,
//     bool rethrowException = false,
//     String message = '',
//     VoidCallback? onError,
//   }) async {
//     try {
//       await func.call();
//       return true;
//     } on Exception catch (e) {
//       logger.e('Exception: $e');

//       if (rethrowException) {
//         rethrow;
//       }

//       onError?.call();

//       ExceptionManager.handleError(e, message);
//       return false;
//     }
//   }
// }
