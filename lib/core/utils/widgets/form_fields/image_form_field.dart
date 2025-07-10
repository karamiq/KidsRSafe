import 'dart:io';

import 'package:app/common_lib.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageFormField extends StatelessWidget {
  const ImageFormField({
    super.key,
    required this.dimension,
    required this.text,
    required this.image,
    required this.onChanged,
  });

  ImageFormField.notifier(
    ValueNotifier<File?> notifier, {
    super.key,
    required this.dimension,
    required this.text,
  })  : image = notifier.value,
        onChanged = notifier.update;

  final File? image;
  final ValueChanged<File> onChanged;
  final double dimension;
  final String text;

  Future<void> _pickImage() async {
    final result = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (result != null) {
      onChanged(File(result.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedSwitcher(
      duration: Time.small,
      child: image == null
          ? FormField(
              initialValue: image,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) return context.l10n.validatorRequired;
                return null;
              },
              builder: (field) {
                return InkWell(
                  onTap: _pickImage,
                  child: ColumnPadded(
                    gap: 4,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: dimension,
                        height: dimension,
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.colorScheme.outline),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add_a_photo,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        text,
                        style: theme.textTheme.titleLarge,
                      ),
                      if (field.hasError)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            field.errorText!,
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                        )
                    ],
                  ),
                );
              },
            )
          : InkWell(
              onTap: _pickImage,
              child: Column(
                children: [
                  Container(
                    width: dimension,
                    height: dimension,
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.outline),
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(dimension),
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    text,
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
    );
  }
}
