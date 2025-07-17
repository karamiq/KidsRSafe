# Post Media Components

This directory contains refactored components for displaying post media content with proper separation of concerns and clear layering.

## Components Overview

### 1. `PostMediaView` - Main Container
The main component that orchestrates all the media display layers.

**Features:**
- Clean separation of media content, overlays, and action buttons
- Proper layering to prevent UI conflicts
- Handles both video and image posts

**Layers (from bottom to top):**
1. **Media Content Layer**: Video player or image carousel
2. **Content Overlay Layer**: Title and caption text
3. **Action Buttons Layer**: Like, comment, save, share buttons

### 2. `VideoPlayerWidget` - Video Player Component
Handles video playback with full controls.

**Features:**
- Video initialization and disposal
- Play/pause controls
- Progress slider with time display
- Auto-play for approved posts
- Error handling and loading states

### 3. `ImageCarouselWidget` - Image Display Component
Handles multiple image display with carousel functionality.

**Features:**
- PageView for multiple images
- Page indicators for navigation
- Loading and error states
- Touch interaction support

### 4. `PostContentOverlay` - Content Text Overlay
Displays post title and caption over the media.

**Features:**
- Conditional display based on post status
- Proper text styling and positioning
- Text overflow handling
- Responsive layout

### 5. `PostActionButtons` - Action Buttons Component
Handles all interactive buttons for the post.

**Features:**
- Like, comment, save, share buttons
- Active state indicators
- Proper positioning and spacing
- Touch feedback

## Component Architecture

```
PostMediaView (Main Container)
├── VideoPlayerWidget (for videos)
├── ImageCarouselWidget (for images)
├── PostContentOverlay (title/caption)
└── PostActionButtons (interactions)
```

## Benefits of Refactoring

1. **Separation of Concerns**: Each component has a single responsibility
2. **Reusability**: Components can be used independently
3. **Maintainability**: Easier to debug and modify individual features
4. **Clear Layering**: No UI conflicts between components
5. **Testability**: Each component can be tested in isolation
6. **Code Reduction**: Main component reduced from 427 lines to ~60 lines

## Usage Example

```dart
PostMediaView(
  post: postModel,
  onLike: () => handleLike(),
  onComment: () => handleComment(),
  onSave: () => handleSave(),
  onShare: () => handleShare(),
  isLiked: true,
  isSaved: false,
)
```

## Component Dependencies

- `VideoPlayerWidget`: Uses `cached_video_player_plus`
- `ImageCarouselWidget`: Uses `cached_network_image`
- All components use shared constants from `app/core/utils/constants/sizes.dart`

## Performance Optimizations

1. **Lazy Loading**: Video controller only initialized when needed
2. **Memory Management**: Proper disposal of video controllers
3. **Conditional Rendering**: Components only render when needed
4. **Cached Images**: Network images are cached for better performance

## Accessibility

- All interactive elements have proper touch targets
- Text has appropriate contrast ratios
- Loading states provide user feedback
- Error states are clearly communicated 