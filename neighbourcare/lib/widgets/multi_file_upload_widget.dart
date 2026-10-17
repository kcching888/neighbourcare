import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MultiFileUploadWidget extends StatefulWidget {
  final Function(List<PlatformFile> files) onFilesSelected;

  const MultiFileUploadWidget({
    super.key,
    required this.onFilesSelected,
  });

  @override
  State<MultiFileUploadWidget> createState() => _MultiFileUploadWidgetState();
}

class _MultiFileUploadWidgetState extends State<MultiFileUploadWidget> {
  final List<PlatformFile> _selectedFiles = [];

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx'],
      withData: kIsWeb, // Ensures byte data is available on Web
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFiles.addAll(result.files);
      });
      widget.onFilesSelected(_selectedFiles);
    }
  }

  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
    widget.onFilesSelected(_selectedFiles);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: _pickFiles,
          icon: const Icon(Icons.attach_file),
          label: const Text('Attach Files / Images'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(180, 48),
          ),
        ),
        if (_selectedFiles.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            'Selected Files (${_selectedFiles.length}):',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_selectedFiles.length, (index) {
              final file = _selectedFiles[index];
              final isImage = ['jpg', 'png', 'jpeg'].contains(file.extension?.toLowerCase());

              return Chip(
                avatar: isImage && file.bytes != null
                    ? CircleAvatar(
                        backgroundImage: MemoryImage(file.bytes!),
                      )
                    : Icon(_getFileIcon(file.extension)),
                label: Text(
                  file.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onDeleted: () => _removeFile(index),
              );
            }),
          ),
        ],
      ],
    );
  }

  IconData _getFileIcon(String? extension) {
    switch (extension?.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }
}