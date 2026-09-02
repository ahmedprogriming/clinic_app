import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImageItem extends StatefulWidget {
  final ValueChanged<List<File>>? onImagesSelected;
  final ValueChanged<List<String>>? onUrlsChanged;
  final List<String> initialUrls;
  final bool isReadOnly;

  const AddImageItem({
    super.key,
    this.onImagesSelected,
    this.onUrlsChanged,
    this.initialUrls = const [],
    this.isReadOnly = false,
  });

  @override
  State<AddImageItem> createState() => _AddImageItemState();
}

class _AddImageItemState extends State<AddImageItem> {
  late List<String> _currentUrls;
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _currentUrls = List.from(widget.initialUrls);
  }

  @override
  void didUpdateWidget(covariant AddImageItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialUrls != widget.initialUrls) {
      _currentUrls = List.from(widget.initialUrls);
    }
  }

  Future<void> _pickImages() async {
    if (widget.isReadOnly) return;

    final List<XFile> pickedFiles = await _picker.pickMultiImage(
      imageQuality: 80,
    );

    if (pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(pickedFiles.map((x) => File(x.path)));
      });
      widget.onImagesSelected?.call(_selectedImages);
    }
  }

  void _removeUrlImage(int index) {
    setState(() {
      _currentUrls.removeAt(index);
    });
    widget.onUrlsChanged?.call(_currentUrls);
  }

  void _removeFileImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
    widget.onImagesSelected?.call(_selectedImages);
  }

  @override
  Widget build(BuildContext context) {
    final int totalCount = _currentUrls.length + _selectedImages.length;

    return Container(
      width: double.infinity,
      height: 125,
      decoration: BoxDecoration(
        color: const Color(0xffFFFBF5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffE6D8C0)),
      ),
      child: totalCount == 0
          ? InkWell(
              onTap: widget.isReadOnly ? null : _pickImages,
              borderRadius: BorderRadius.circular(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.isReadOnly
                        ? Icons.image_not_supported_outlined
                        : Icons.add_photo_alternate_outlined,
                    color: const Color(0xffB08D57),
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.isReadOnly ? 'لا توجد صور مرفقة' : 'إضافة صور للجلسة',
                    style: const TextStyle(color: Color(0xffB08D57), fontSize: 13),
                  ),
                ],
              ),
            )
          : Row(
              children: [
                if (!widget.isReadOnly)
                  IconButton(
                    icon: const Icon(Icons.add_a_photo, color: Color(0xffB08D57)),
                    onPressed: _pickImages,
                  ),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8),
                    itemCount: totalCount,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final bool isNetworkImage = index < _currentUrls.length;

                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: isNetworkImage
                                ? Image.network(
                                    _currentUrls[index],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey.shade200,
                                      child: const Icon(Icons.broken_image),
                                    ),
                                  )
                                : Image.file(
                                    _selectedImages[index - _currentUrls.length],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          if (!widget.isReadOnly)
                            Positioned(
                              top: 2,
                              right: 2,
                              child: GestureDetector(
                                onTap: () {
                                  if (isNetworkImage) {
                                    _removeUrlImage(index);
                                  } else {
                                    _removeFileImage(index - _currentUrls.length);
                                  }
                                },
                                child: const CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.close, size: 12, color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}