# Cloudinary Upload Troubleshooting Guide

## Common 400 Error Causes

### 1. Upload Preset Issues
The most common cause of 400 errors is incorrect upload preset configuration.

**Solution:**
- Go to your Cloudinary Dashboard
- Navigate to Settings > Upload
- Check if the upload preset `ml_default` exists and is properly configured
- If not, create a new upload preset:
  1. Go to Settings > Upload
  2. Click "Add upload preset"
  3. Set signing mode to "Unsigned"
  4. Save the preset with a name like `kidsrsafe_upload`

### 2. File Size Limits
Cloudinary has file size limits depending on your plan.

**Solution:**
- Free plan: 10MB per file
- Paid plans: Up to 100MB per file
- Check your file size before upload
- Consider compressing images if they're too large

### 3. File Format Issues
Some file formats might not be supported or properly handled.

**Solution:**
- Use common formats: JPG, PNG, GIF, WebP for images
- Use MP4, MOV for videos
- Check file extension and content type

### 4. Network Issues
Poor network connectivity can cause upload failures.

**Solution:**
- Check internet connection
- Try uploading smaller files first
- Increase timeout values if needed

## Debugging Steps

### 1. Check Cloudinary Dashboard
- Log into your Cloudinary account
- Go to Media Library
- Check if uploads are appearing there
- Look for any error messages

### 2. Test with Different Files
- Try uploading a small, simple JPG file first
- Test with different file sizes
- Try different file formats

### 3. Check Upload Presets
- Verify your upload presets in Cloudinary dashboard
- Try creating a new unsigned upload preset
- Test with the `unsigned` preset (no authentication required)

### 4. Monitor Network Requests
- Use browser developer tools to monitor network requests
- Check if requests are reaching Cloudinary
- Look for CORS issues

## Updated Service Features

The updated `CloudinaryUploadService` now includes:

1. **Multiple upload preset fallback** - tries different presets if one fails
2. **File size validation** - checks file size before upload
3. **Better error logging** - provides detailed error information
4. **Content type detection** - automatically detects file type
5. **Timeout configuration** - prevents hanging uploads

## Testing

Run the test to verify upload functionality:

```bash
flutter test test/cloudinary_test.dart
```

Make sure to place a test image at `test/test_image.jpg` before running the test.

## Configuration

If you need to change the Cloudinary configuration:

1. Update `cloudName` in `CloudinaryUploadService`
2. Update `uploadPresets` list with your presets
3. Adjust file size limits if needed

## Common Error Messages

- **"Upload preset not found"** - Create or fix upload preset in dashboard
- **"File too large"** - Compress file or upgrade plan
- **"Invalid file format"** - Check file type and extension
- **"Network timeout"** - Check internet connection and increase timeouts 