import 'package:flutter/material.dart';

import '../../main.dart';
import '../constants/colors.dart';
import '../model/data_model.dart';

class NotePage extends StatefulWidget {
  const NotePage({
    super.key,
    required this.updateUI,
    this.stateCheck,
    required this.initialTitle,
    required this.initialContent,
    this.noteKey,
  });

  final VoidCallback updateUI;
  final String? stateCheck;
  final String initialTitle;
  final String initialContent;
  final String? noteKey;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // Text Editing Controllers
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  // Edit Mode Trigger
  late bool isEditMode;
  String? bVal;
  // Initialize State
  @override
  void initState() {
    super.initState();
    // String to Boolean value
    bVal = widget.stateCheck?.toString();
    if (bVal == 'true') {
      isEditMode = true;
    } else {
      isEditMode = false;
    }
    // Text Editor Controllers
    if (isEditMode == true) {
      titleController.text = widget.initialTitle;
      contentController.text = widget.initialContent;
    } else {
      return;
    }
  }

  // dispose
  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Color hardColor = Colors.blue.shade300;
  Color softColor = Colors.blue.shade100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: hardColor,
          ),
        ),
        title: Text(
          isEditMode ? 'Edit Note' : 'Create Note',
          style: TextStyle(
            color: hardColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                setState(() {
                  noteBox.put(
                    widget.noteKey ?? 'key_${titleController.text}',
                    Note(
                      noteTitle: titleController.text,
                      noteContent: contentController.text,
                      noteCreatedAt: DateTime.now(),
                      isSaved: false,
                      isDeleted: false,
                    ),
                  );
                  widget.updateUI();
                  Navigator.pop(context);
                });
                // toast message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isEditMode ? 'Note Changes Saved' : 'Note Saved',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    backgroundColor: Colors.black.withOpacity(0.5),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(30),
              child: Container(
                decoration: ShapeDecoration(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: softColor.withOpacity(0.2),
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.inbox_rounded,
                  color: hardColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(28),
          ),
          child: Container(
            height: 400,
            padding: const EdgeInsets.all(10),
            color: softColor,
            child: Center(
              child: Stack(
                children: [
                  Column(
                    children: [
                      TextField(
                        controller: contentController,
                        maxLines: 6,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          contentPadding: const EdgeInsets.only(
                            bottom: 12,
                            top: 120,
                            left: 20,
                            right: 20,
                          ),
                          hintText: 'Note',
                          hintStyle: const TextStyle(
                            color: AppColors.accentColorTwo,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: titleController,
                    onChanged: null,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      hintText: 'Title',
                      hintStyle: const TextStyle(
                        color: AppColors.accentColorTwo,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
