import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

String getTimesAgoFromTimestamp(Timestamp timestamp) {
  return timeago.format(timestamp.toDate());
}
