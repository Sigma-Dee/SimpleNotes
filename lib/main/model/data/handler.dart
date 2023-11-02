import '../data_model.dart';

String userName = 'User';
String userDetail = 'admin';
String userEmail = 'user@admin.com';
// listener
bool isToggled = false;
// note
List<Note> deletedNotes = [];
List<Note> savedNotes = [];
// time
String formatTimeDifference(DateTime createdAt) {
  final now = DateTime.now();
  final difference = now.difference(createdAt);

  if (difference.inSeconds < 60) {
    return 'Just now';
  } else if (difference.inMinutes < 60) {
    final minutes = difference.inMinutes;
    return '$minutes min${minutes > 1 ? 's' : ''} ago';
  } else if (difference.inHours < 24) {
    final hours = difference.inHours;
    return '$hours hour${hours > 1 ? 's' : ''} ago';
  } else if (difference.inDays < 7) {
    final days = difference.inDays;
    return '$days day${days > 1 ? 's' : ''} ago';
  } else {
    final weeks = difference.inDays ~/ 7;
    return '$weeks week${weeks > 1 ? 's' : ''} ago';
  }
}
