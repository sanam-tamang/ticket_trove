import 'package:ticket_trove/common/utils/debug_log.dart';

String getFirebaseSimplifiedExceptionMessage(String? message) {
  message = message?.split('FirebaseError: Firebase:').last;
  message = message?.split(".").firstOrNull;
  debugLog(message ?? "");
  return message ?? "Opps! something went wrong";
}
