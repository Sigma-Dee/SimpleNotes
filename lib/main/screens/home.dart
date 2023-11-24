import 'package:flutter/material.dart';
import 'package:simple_notes/main.dart';
import 'package:simple_notes/main/pages/trash_bin.dart';

import '../constants/colors.dart';
import '../model/data/handler.dart';
import '../model/data_model.dart';
import '../pages/create_edit_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isListEmpty() {
    if (noteBox.isEmpty) {
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrashBin(
                          updateUI: updateUI,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Trash Bin',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: 'Search notes...',
                hintStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                filled: true,
                fillColor: Colors.blue.shade200,
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
            const SizedBox(
              height: 15,
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
                                'Note Box Empty',
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
                      itemCount: noteBox.length,
                      itemBuilder: (context, index) {
                        Note noteData = noteBox.getAt(index);
                        String noteKey = noteBox.keyAt(index);
                        final createdAt = noteData.noteCreatedAt;
                        final formattedTime = formatTimeDifference(createdAt);
                        return Dismissible(
                          key: Key(noteKey),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            Note discarded = noteBox.getAt(index);

                            String dTitle = discarded.noteTitle;
                            String dContent = discarded.noteContent;
                            DateTime dDate = discarded.noteCreatedAt;
                            bool dIsSaved = discarded.isSaved;

                            setState(() {
                              if (deletedNotes.contains(discarded)) {
                                return;
                              } else {
                                deletedNotes.add(discarded);
                                noteBox.deleteAt(index);
                              }

                              if (savedNotes.contains(discarded)) {
                                savedNotes.remove(discarded);
                              } else {
                                return;
                              }

                              noteData.isDeleted = !noteData.isDeleted;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Note Deleted'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    setState(() {
                                      if (deletedNotes.contains(discarded)) {
                                        noteBox.put(
                                          'key_$dTitle',
                                          Note(
                                            noteTitle: dTitle,
                                            noteContent: dContent,
                                            noteCreatedAt: dDate,
                                            isSaved: dIsSaved,
                                            isDeleted: false,
                                          ),
                                        );

                                        deletedNotes.remove(discarded);
                                      } else {
                                        return;
                                      }

                                      noteData.isDeleted = !noteData.isDeleted;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                          background: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: AppColors.deleteColor,
                                ),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: AppColors.deleteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: Card(
                            color: getCardColor(index),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: ListTile(
                                title: Text(
                                  noteData.noteTitle.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    height: 1.5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      noteData.noteContent,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      'Created: $formattedTime',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                                trailing: Ink(
                                  decoration: ShapeDecoration(
                                    color: noteData.isSaved
                                        ? getWaterMarkColor(index)
                                        : Colors.transparent,
                                    shape: const CircleBorder(),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.bookmark),
                                    color: noteData.isSaved
                                        ? Colors.black
                                        : Colors.grey.withOpacity(0.5),
                                    onPressed: () {
                                      setState(() {
                                        Note bookMarked = noteBox.getAt(index);
                                        if (savedNotes.contains(bookMarked)) {
                                          savedNotes.remove(bookMarked);
                                        } else {
                                          savedNotes.add(bookMarked);
                                        }
                                        noteData.isSaved = !noteData.isSaved;
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            noteData.isSaved
                                                ? 'Added to favorites'
                                                : 'Removed from favorites',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          backgroundColor:
                                              Colors.black.withOpacity(0.5),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => NotePage(
                                        initialTitle: noteData.noteTitle,
                                        initialContent: noteData.noteContent,
                                        noteKey: noteKey,
                                        stateCheck: 'true',
                                        updateUI: updateUI,
                                      ),
                                    ),
                                  );
                                },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Add new note'),
            ),
          );
          // Function
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NotePage(
                initialTitle: '',
                initialContent: '',
                updateUI: updateUI,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
