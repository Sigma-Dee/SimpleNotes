import 'package:flutter/material.dart';
import 'package:simple_notes/main/model/data/handler.dart';

import '../constants/colors.dart';

class BookmarkedScreen extends StatefulWidget {
  const BookmarkedScreen({
    super.key,
  });

  @override
  State<BookmarkedScreen> createState() => _BookmarkedScreenState();
}

class _BookmarkedScreenState extends State<BookmarkedScreen> {
  bool isListEmpty() {
    if (savedNotes.isEmpty) {
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
        title: Text('Bookmarked'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Ink(
              decoration: ShapeDecoration(
                color: AppColors.accentColorOne,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(Icons.bookmark_border_outlined),
                color: AppColors.primaryColor,
                onPressed: () {
                  Navigator.pop(context);
                  savedNotes.clear();
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
                                'Bookmark Empty',
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
                      itemCount: savedNotes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: getCardColor(index),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(
                                savedNotes[index].noteTitle.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  height: 1.5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              subtitle: Text(
                                savedNotes[index].noteContent,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              trailing: Icon(
                                Icons.bookmark,
                                color: getWaterMarkColor(index),
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
