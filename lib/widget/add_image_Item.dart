import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImageItem extends StatefulWidget {
  final ValueChanged<List<File>>? onImagesSelected;

  const AddImageItem({super.key, this.onImagesSelected});

  @override
  State<AddImageItem> createState() => _AddImageItemState();
}

class _AddImageItemState extends State<AddImageItem> {
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125,
      decoration: BoxDecoration(
        color: const Color(0xffFFFBF5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffE6D8C0)),
      ),
      child: _selectedImages.isEmpty
          ? InkWell(
              onTap: _pickImages,
              borderRadius: BorderRadius.circular(20),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined,
                      color: Color(0xffB08D57), size: 28),
                  SizedBox(height: 8),
                  Text('إضافة صور للجلسة',
                      style: TextStyle(color: Color(0xffB08D57), fontSize: 13)),
                ],
              ),
            )
          : Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_a_photo, color: Color(0xffB08D57)),
                  onPressed: _pickImages,
                ),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8),
                    itemCount: _selectedImages.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _selectedImages[index],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImages.removeAt(index);
                                });
                                widget.onImagesSelected?.call(_selectedImages);
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