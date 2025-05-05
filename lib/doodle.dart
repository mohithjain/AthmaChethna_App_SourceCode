import 'package:flutter/material.dart';
import 'dart:ui';

class DoodlePage extends StatefulWidget {
  @override
  _DoodlePageState createState() => _DoodlePageState();
}

class _DoodlePageState extends State<DoodlePage> {
  List<DrawingPoint?> drawingPoints = []; // Allow nulls for stroke separation
  double strokeWidth = 2.0;
  Color selectedColor = Colors.black;
  Color canvasColor = Colors.white;
  List<Emoji> emojis = [];
  List<Sticker> stickers = [];
  bool showGrid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doodle Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () {
              setState(() {
                if (drawingPoints.isNotEmpty) {
                  drawingPoints.removeLast();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Choose Canvas Color'),
                        Wrap(
                          spacing: 8,
                          children: [
                            _buildCanvasColorButton(Colors.white),
                            _buildCanvasColorButton(Colors.yellow),
                            _buildCanvasColorButton(Colors.blue),
                            _buildCanvasColorButton(Colors.green),
                            _buildCanvasColorButton(Colors.pink),
                            _buildCanvasColorButton(Colors.brown),
                            _buildCanvasColorButton(Colors.black),
                            _buildCanvasColorButton(Colors.orange),
                            _buildCanvasColorButton(Colors.teal),
                            _buildCanvasColorButton(Colors.grey),
                            _buildCanvasColorButton(Colors.deepPurple),
                            _buildCanvasColorButton(Colors.redAccent),
                            _buildCanvasColorButton(Colors.amber),
                            _buildCanvasColorButton(Colors.purple),
                            _buildCanvasColorButton(Colors.deepOrange),
                            _buildCanvasColorButton(Colors.blueGrey),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.emoji_emotions),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Add Emoji'),
                        Wrap(
                          spacing: 8,
                          children: [
                            _buildEmojiButton('😀'), // Grinning face
                            _buildEmojiButton('😍'), // Heart eyes
                            _buildEmojiButton('😂'), // Tears of joy
                            _buildEmojiButton('😎'), // Cool face
                            _buildEmojiButton('🤩'), // Star-struck
                            _buildEmojiButton('😊'), // Smiling face
                            _buildEmojiButton('😘'), // Kissing face
                            _buildEmojiButton('😜'), // Winking face with tongue
                            _buildEmojiButton('🤔'), // Thinking face
                            _buildEmojiButton('😏'), // Smirking face
                            _buildEmojiButton('😢'), // Crying face
                            _buildEmojiButton('😡'), // Angry face
                            _buildEmojiButton('🤯'), // Exploding head
                            _buildEmojiButton('🥳'), // Party face
                            _buildEmojiButton('🥺'), // Pleading face
                            _buildEmojiButton('🤗'), // Hugging face
                            _buildEmojiButton('🤠'), // Cowboy face
                            _buildEmojiButton('😇'), // Smiling face with halo
                            _buildEmojiButton('🤡'), // Clown face
                            _buildEmojiButton('👻'), // Ghost
                            _buildEmojiButton('💩'), // Pile of poo
                            _buildEmojiButton('👏'), // Clapping hands
                            _buildEmojiButton('🙌'), // Raising hands
                            _buildEmojiButton('👍'), // Thumbs up
                            _buildEmojiButton('👎'), // Thumbs down
                            _buildEmojiButton('❤️'), // Red heart
                            _buildEmojiButton('🔥'), // Fire
                            _buildEmojiButton('🌈'), // Rainbow
                            _buildEmojiButton('🎉'), // Party popper
                            _buildEmojiButton('💯'), // Hundred points
                            _buildEmojiButton('🦋'), // Butterfly
                            _buildEmojiButton('🚀'), // Rocket
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Add Sticker'),
                        Wrap(
                          spacing: 8,
                          children: [
                            _buildStickerButton(Icons.star, Colors.yellow), // Star icon
                            _buildStickerButton(Icons.favorite, Colors.red), // Heart icon (red)
                            _buildStickerButton(Icons.thumb_up, Colors.blue), // Thumbs up icon
                            _buildStickerButton(Icons.face, Colors.green), // Smiley face icon
                            _buildStickerButton(Icons.pets, Colors.brown), // Pets icon
                            _buildStickerButton(Icons.add_photo_alternate_outlined, Colors.black), // Add photo icon
                            _buildStickerButton(Icons.account_tree, Colors.black), // Account tree icon
                            _buildStickerButton(Icons.accessibility_new, Colors.black), // Accessibility icon
                            _buildStickerButton(Icons.home, Colors.black), // Home icon
                            _buildStickerButton(Icons.access_time_filled, Colors.black), // Time icon
                            _buildStickerButton(Icons.add_comment, Colors.black), // Add comment icon
                            _buildStickerButton(Icons.abc_rounded, Colors.black), // ABC icon
                            _buildStickerButton(Icons.people, Colors.purple), // People/relationship icon
                            _buildStickerButton(Icons.group_add, Colors.green), // Group add icon
                            _buildStickerButton(Icons.heart_broken, Colors.red), // Broken heart icon
                            _buildStickerButton(Icons.calendar_today, Colors.blue), // Calendar icon
                            _buildStickerButton(Icons.timer, Colors.yellow), // Timer icon
                            _buildStickerButton(Icons.watch_later, Colors.black), // Watch later icon
                            _buildStickerButton(Icons.fitness_center, Colors.green), // Fitness icon
                            _buildStickerButton(Icons.health_and_safety, Colors.red), // Health and safety icon
                            _buildStickerButton(Icons.local_hospital, Colors.blue), // Hospital icon
                            _buildStickerButton(Icons.medication, Colors.purple), // Medication icon
                            _buildStickerButton(Icons.self_improvement, Colors.green), // Self-improvement icon
                            _buildStickerButton(Icons.nature_people, Colors.brown), // Nature and people icon
                            _buildStickerButton(Icons.emoji_people, Colors.yellow), // Emoji people icon
                            _buildStickerButton(Icons.emoji_emotions, Colors.purple), // Emoji emotions icon
                            _buildStickerButton(Icons.emoji_objects, Colors.blue), // Emoji objects icon
                            _buildStickerButton(Icons.emoji_food_beverage, Colors.green), // Food and beverage icon
                            _buildStickerButton(Icons.emoji_transportation, Colors.black), // Transportation icon
                            _buildStickerButton(Icons.emoji_symbols, Colors.yellow), // Symbols icon
                            _buildStickerButton(Icons.emoji_flags, Colors.red), // Flags icon
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: () {
              setState(() {
                showGrid = !showGrid;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: canvasColor,
            child: GestureDetector(
              onPanStart: (details) {
                setState(() {
                  if (drawingPoints.isEmpty || drawingPoints.last == null) {
                    drawingPoints.add(DrawingPoint(
                      details.localPosition,
                      Paint()
                        ..color = selectedColor
                        ..strokeWidth = strokeWidth // Use the updated strokeWidth
                        ..isAntiAlias = true
                        ..strokeCap = StrokeCap.round,
                    ));
                  }
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  if (drawingPoints.isNotEmpty && drawingPoints.last != null) {
                    drawingPoints.add(DrawingPoint(
                      details.localPosition,
                      Paint()
                        ..color = selectedColor
                        ..strokeWidth = strokeWidth // Use the updated strokeWidth
                        ..isAntiAlias = true
                        ..strokeCap = StrokeCap.round,
                    ));
                  }
                });
              },
              onPanEnd: (details) {
                setState(() {
                  drawingPoints.add(null); // Break the stroke connection
                });
              },
              child: CustomPaint(
                size: Size.infinite,
                painter: DrawingPainter(drawingPoints, showGrid),
              ),
            ),
          ),
          ...emojis.map((emoji) => _buildDraggableEmoji(emoji)).toList(),
          ...stickers.map((sticker) => _buildDraggableSticker(sticker)).toList(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.brush),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Choose Brush Color'),
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildBrushColorButton(Colors.white),
                              _buildBrushColorButton(Colors.yellow),
                              _buildBrushColorButton(Colors.blue),
                              _buildBrushColorButton(Colors.green),
                              _buildBrushColorButton(Colors.pink),
                              _buildBrushColorButton(Colors.brown),
                              _buildBrushColorButton(Colors.black),
                              _buildBrushColorButton(Colors.orange),
                              _buildBrushColorButton(Colors.teal),
                              _buildBrushColorButton(Colors.grey),
                              _buildBrushColorButton(Colors.deepPurple),
                              _buildBrushColorButton(Colors.redAccent),
                              _buildBrushColorButton(Colors.amber),
                              _buildBrushColorButton(Colors.purple),
                              _buildBrushColorButton(Colors.deepOrange),
                              _buildBrushColorButton(Colors.blueGrey),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text('Choose Brush Size'),
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildBrushSizeButton(2.0),
                              _buildBrushSizeButton(4.0),
                              _buildBrushSizeButton(6.0),
                              _buildBrushSizeButton(8.0),
                              _buildBrushSizeButton(10.0),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  drawingPoints.clear();
                  emojis.clear();
                  stickers.clear();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrushColorButton(Color color) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
        Navigator.pop(context);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildBrushSizeButton(double size) {
    return InkWell(
      onTap: () {
        setState(() {
          strokeWidth = size; // Update the strokeWidth
        });
        Navigator.pop(context); // Close the bottom sheet
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Icon(
            Icons.brush,
            size: size * 4, // Visual representation of the brush size
            color: selectedColor,
          ),
        ),
      ),
    );
  }

  Widget _buildCanvasColorButton(Color color) {
    return InkWell(
      onTap: () {
        setState(() {
          canvasColor = color;
        });
        Navigator.pop(context);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildEmojiButton(String emoji) {
    return InkWell(
      onTap: () {
        // Get the center of the screen
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset center = renderBox.size.center(Offset.zero);

        setState(() {
          emojis.add(Emoji(emoji, center));
        });
        Navigator.pop(context);
      },
      child: Text(
        emoji,
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  Widget _buildStickerButton(IconData icon, Color color) {
    return InkWell(
      onTap: () {
        // Get the center of the screen
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset center = renderBox.size.center(Offset.zero);

        setState(() {
          stickers.add(Sticker(icon, color, center));
        });
        Navigator.pop(context);
      },
      child: Icon(icon, size: 30, color: color),
    );
  }

  Widget _buildDraggableEmoji(Emoji emoji) {
    return Positioned(
      left: emoji.position.dx,
      top: emoji.position.dy,
      child: Draggable(
        feedback: Text(emoji.emoji, style: TextStyle(fontSize: 40)),
        child: Text(emoji.emoji, style: TextStyle(fontSize: 40)),
        childWhenDragging: Container(),
        onDragEnd: (details) {
          setState(() {
            emoji.position = details.offset;
          });
        },
      ),
    );
  }

  Widget _buildDraggableSticker(Sticker sticker) {
    return Positioned(
      left: sticker.position.dx,
      top: sticker.position.dy,
      child: Draggable(
        feedback: Icon(sticker.icon, size: 40, color: sticker.color),
        child: Icon(sticker.icon, size: 40, color: sticker.color),
        childWhenDragging: Container(),
        onDragEnd: (details) {
          setState(() {
            sticker.position = details.offset;
          });
        },
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> drawingPoints;
  final bool showGrid;

  DrawingPainter(this.drawingPoints, this.showGrid);

  @override
  void paint(Canvas canvas, Size size) {
    if (showGrid) {
      final paint = Paint()
        ..color = Colors.grey.withOpacity(0.5)
        ..strokeWidth = 1;

      // Increase the grid spacing from 20 to 40
      for (double i = 0; i < size.width; i += 40) {
        canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
      }
      for (double i = 0; i < size.height; i += 40) {
        canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
      }
    }

    for (int i = 0; i < drawingPoints.length - 1; i++) {
      final currentPoint = drawingPoints[i];
      final nextPoint = drawingPoints[i + 1];

      if (currentPoint != null && nextPoint != null) {
        if (nextPoint.offset != currentPoint.offset) {
          canvas.drawLine(
            currentPoint.offset,
            nextPoint.offset,
            currentPoint.paint,
          );
        }
      } else if (currentPoint != null && nextPoint == null) {
        // Draw a single point when the stroke ends
        final singlePointPaint = Paint()
          ..color = currentPoint.paint.color
          ..strokeWidth = currentPoint.paint.strokeWidth
          ..strokeCap = StrokeCap.round
          ..isAntiAlias = true;

        canvas.drawPoints(
          PointMode.points,
          [currentPoint.offset],
          singlePointPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DrawingPoint {
  final Offset offset;
  final Paint paint;

  DrawingPoint(this.offset, this.paint);
}

class Emoji {
  String emoji;
  Offset position;

  Emoji(this.emoji, this.position);
}

class Sticker {
  IconData icon;
  Color color;
  Offset position;

  Sticker(this.icon, this.color, this.position);
}