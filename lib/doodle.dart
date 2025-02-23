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
                            _buildColorButton(Colors.white),
                            _buildColorButton(Colors.yellow),
                            _buildColorButton(Colors.blue),
                            _buildColorButton(Colors.green),
                            _buildColorButton(Colors.pink),
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
                            _buildEmojiButton('😀'),
                            _buildEmojiButton('😍'),
                            _buildEmojiButton('😂'),
                            _buildEmojiButton('😎'),
                            _buildEmojiButton('🤩'),
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
                            _buildStickerButton(Icons.star, Colors.yellow),
                            _buildStickerButton(Icons.favorite, Colors.red),
                            _buildStickerButton(Icons.thumb_up, Colors.blue),
                            _buildStickerButton(Icons.face, Colors.green),
                            _buildStickerButton(Icons.pets, Colors.brown),
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
                              _buildColorButton(Colors.black),
                              _buildColorButton(Colors.red),
                              _buildColorButton(Colors.blue),
                              _buildColorButton(Colors.green),
                              _buildColorButton(Colors.purple),
                              _buildColorButton(Colors.orange),
                              _buildColorButton(Colors.yellow),
                              _buildColorButton(Colors.brown),
                              _buildColorButton(Colors.grey),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text('Brush Size'),
                          Slider(
                            value: strokeWidth,
                            min: 1,
                            max: 10,
                            onChanged: (value) {
                              setState(() {
                                strokeWidth = value; // Update strokeWidth
                              });
                            },
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

  Widget _buildColorButton(Color color) {
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

  Widget _buildEmojiButton(String emoji) {
    return InkWell(
      onTap: () {
        setState(() {
          emojis.add(Emoji(emoji, Offset(100, 100)));
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
        setState(() {
          stickers.add(Sticker(icon, color, Offset(100, 100)));
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

      for (double i = 0; i < size.width; i += 20) {
        canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
      }
      for (double i = 0; i < size.height; i += 20) {
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