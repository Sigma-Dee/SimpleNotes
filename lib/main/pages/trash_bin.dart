import 'package:flutter/material.dart';
import 'package:simple_notes/main/model/data/handler.dart';

import '../../main.dart';
import '../constants/colors.dart';
import '../model/data_model.dart';

class TrashBin extends StatefulWidget {
  const TrashBin({
    super.key,
    required this.updateUI,
  });

  final VoidCallback updateUI;

  @override
  State<TrashBin> createState() => _TrashBinState();
}

class _TrashBinState extends State<TrashBin> {
  bool isListEmpty() {
    if (deletedNotes.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // card color function
    getCardColor(int index) {
      if (index >= 0 && index < cardColors.length) {
        return cardColors[index];
      } else {
        return AppColors.accentColorOne;
      }
    }

    // card color accent function
    getWaterMarkColor(int index) {
      if (index >= 0 && index < waterMarkColors.length) {
        return waterMarkColors[index];
      } else {
        return AppColors.primaryColor;
      }
    }

    Color hardColor = Colors.blue.shade300;
    Color softColor = Colors.blue.shade100;

    return Scaffold(
      appBar: AppBar(
        title: Text('Trash Bin'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Ink(
              decoration: ShapeDecoration(
                color: AppColors.accentColorOne,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(Icons.delete_outline_rounded),
                color: AppColors.primaryColor,
                onPressed: () {
                  Navigator.pop(context);
                  deletedNotes.clear();
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: isListEmpty()
                  ? ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(28),
                      ),
                      child: Container(
                        color: softColor,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              color: Colors.white,
                              child: Text(
                                'Trash Bin Empty',
                                style: TextStyle(
                                  color: hardColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: deletedNotes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: getCardColor(index),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(
                                deletedNotes[index].noteTitle.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  height: 1.5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              subtitle: Text(
                                deletedNotes[index].noteContent,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              trailing: Ink(
                                decoration: ShapeDecoration(
                                  color: getWaterMarkColor(index),
                                  shape: const CircleBorder(),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.restore),
                                  color: Colors.black,
                                  onPressed: () {
                                    Note trash = deletedNotes[index];

                                    String tTitle = trash.noteTitle;
                                    String tContent = trash.noteContent;
                                    DateTime tDate = DateTime.now();
                                    bool tIsSaved = false;

                                    setState(() {
                                      if (deletedNotes.contains(trash)) {
                                        noteBox.put(
                                          'key_$tTitle',
                                          Note(
                                            noteTitle: tTitle,
                                            noteContent: tContent,
                                            noteCreatedAt: tDate,
                                            isSaved: tIsSaved,
                                            isDeleted: false,
                                          ),
                                        );

                                        deletedNotes.remove(trash);
                                        widget.updateUI();
                                      } else {
                                        return;
                                      }

                                      trash.isDeleted = !trash.isDeleted;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
