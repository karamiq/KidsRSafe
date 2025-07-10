# KidSafe Media - Firestore Collections Schema

## 📊 Collections Overview

### 1. **users** Collection
```json
{
  "userId": "string (auto-generated)",
  "email": "string",
  "displayName": "string",
  "username": "string (unique)",
  "dateOfBirth": "timestamp",
  "age": "number",
  "role": "string (kid | moderator | admin)",
  "status": "string (pending | active | suspended | banned)",
  "parentEmail": "string",
  "parentApproved": "boolean",
  "parentApprovedAt": "timestamp",
  "schoolId": "string (reference to schools)",
  "grade": "string",
  "followersCount": "number",
  "followingCount": "number",
  "postsCount": "number",
  "approvedPostsCount": "number",
  "totalLikes": "number",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### 2. **posts** Collection
```json
{
  "postId": "string (auto-generated)",
  "userId": "string (reference to users)",
  "type": "string (video | photo | text)",
  "content": {
    "mediaUrls": ["string (URLs)"],
    "text": "string"
  },
  "category": "string",
  "status": "string (pending | approved | rejected)",
  "moderatedBy": "string (reference to users - moderator)",
  "moderatedAt": "timestamp",
  "rejectionReason": "string",
  "likesCount": "number",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "approvedAt": "timestamp"
}
```

### 3. **moderation_queue** Collection
```json
{
  "queueId": "string (auto-generated)",
  "postId": "string (reference to posts)",
  "userId": "string (reference to users)",
  "status": "string (pending | in_review | approved | rejected)",
  "assignedTo": "string (reference to users - moderator)",
  "assignedAt": "timestamp",
  "contentType": "string (video | photo | text)",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### 4. **likes** Collection
```json
{
  "likeId": "string (auto-generated)",
  "postId": "string (reference to posts)",
  "userId": "string (reference to users)",
  "createdAt": "timestamp"
}
```

### 5. **follows** Collection
```json
{
  "followId": "string (auto-generated)",
  "followerId": "string (reference to users)",
  "followingId": "string (reference to users)",
  "status": "string (pending | approved)",
  "createdAt": "timestamp",
  "approvedAt": "timestamp"
}
```

### 6. **notifications** Collection
```json
{
  "notificationId": "string (auto-generated)",
  "userId": "string (reference to users)",
  "type": "string (post_approved | post_rejected | new_follower | like)",
  "title": "string",
  "message": "string",
  "postId": "string (reference to posts)",
  "isRead": "boolean",
  "createdAt": "timestamp"
}
```

### 7. **schools** Collection
```json
{
  "schoolId": "string (auto-generated)",
  "name": "string",
  "contactEmail": "string",
  "moderators": ["string (reference to users)"],
  "status": "string (active | inactive)",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### 8. **categories** Collection
```json
{
  "categoryId": "string (auto-generated)",
  "name": "string",
  "isActive": "boolean",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### 9. **reports** Collection
```json
{
  "reportId": "string (auto-generated)",
  "reportedBy": "string (reference to users)",
  "reportedUser": "string (reference to users)",
  "reportedPost": "string (reference to posts)",
  "type": "string (inappropriate_content | bullying | spam)",
  "reason": "string",
  "status": "string (pending | resolved)",
  "assignedTo": "string (reference to users - moderator)",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```



## 🔐 Security Rules Considerations

### Indexes Required:
- `users`: username (unique), email (unique), role, status, schoolId
- `posts`: userId, status, createdAt, category, approvedAt
- `moderation_queue`: status, assignedTo, createdAt
- `likes`: postId, userId (composite unique)
- `follows`: followerId, followingId (composite unique)
- `notifications`: userId, isRead, createdAt
- `reports`: status, assignedTo, createdAt

### Data Validation Rules:
- Age verification for kid accounts (6-14 years)
- Parent approval required for kid accounts
- Content moderation workflow enforcement
- Role-based access control

### Privacy Considerations:
- No personal data in public posts
- Parental consent tracking

## 📱 Collection Relationships

```
users (1) ←→ (many) posts
users (1) ←→ (many) notifications
users (1) ←→ (many) reports
posts (1) ←→ (many) likes
posts (1) ←→ (1) moderation_queue
schools (1) ←→ (many) users
categories (1) ←→ (many) posts
```

This schema supports all core features while maintaining security, moderation workflow, and scalability for the KidSafe Media platform. 