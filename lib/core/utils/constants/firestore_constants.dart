class FirestoreCollections {
  static const String users = 'users';
  static const String posts = 'posts';
  static const String moderationQueue = 'moderation_queue';
  static const String likes = 'likes';
  static const String follows = 'follows';
  static const String notifications = 'notifications';
  static const String categories = 'categories';
  static const String saves = 'saves';
}

class FirestoreFields {
  // Common user fields
  static const String email = 'email';
  static const String displayName = 'displayName';
  static const String role = 'role';
  static const String parentalApproved = 'parentalApproved';
  static const String age = 'age';
  static const String parentEmail = 'parentEmail';
  static const String createdAt = 'createdAt';
  static const String banned = 'banned';

  // Post fields
  static const String userId = 'userId';
  static const String type = 'type';
  static const String url = 'url';
  static const String caption = 'caption';
  static const String categories = 'categories';
  static const String tags = 'tags';
  static const String thumbnailUrl = 'thumbnailUrl';
  static const String duration = 'duration';
  static const String music = 'music';
  static const String status = 'status';
  static const String likes = 'likes';
  static const String saves = 'saves';
  static const String views = 'views';
  static const String moderatorId = 'moderatorId';
  static const String moderationReason = 'moderationReason';
  static const String moderatedAt = 'moderatedAt';

  // Moderation queue fields
  static const String postId = 'postId';
  static const String submittedBy = 'submittedBy';
  static const String assignedTo = 'assignedTo';
  static const String moderationAction = 'moderationAction';
  static const String flaggedBy = 'flaggedBy';
  static const String reason = 'reason';

  // Like/follow/save fields
  static const String followerId = 'followerId';
  static const String followingId = 'followingId';
  static const String notificationId = 'notificationId';
  static const String referenceId = 'referenceId';
  static const String read = 'read';
  static const String title = 'title';
  static const String body = 'body';
  static const String name = 'name';
  static const String description = 'description';
}
