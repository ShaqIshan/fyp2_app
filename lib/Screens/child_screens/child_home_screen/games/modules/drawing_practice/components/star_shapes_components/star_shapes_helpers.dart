import 'package:flutter/material.dart';

class StarShapesHelpers {
  static bool isNearStar(Offset point, Offset starPosition) {
    final distance = (point - starPosition).distance;
    return distance < 40.0;
  }

  static Offset? findNearestStar(Offset point, List<Offset> starPositions) {
    Offset? nearest;
    double minDistance = double.infinity;

    for (var starPos in starPositions) {
      final distance = (point - starPos).distance;
      if (distance < 40.0 && distance < minDistance) {
        minDistance = distance;
        nearest = starPos;
      }
    }

    return nearest;
  }

  static List<Offset> findConnectedStars(
    List<Offset> drawingPoints,
    List<Offset> starPositions,
  ) {
    List<Offset> connectedStars = [];
    Offset? lastConnectedStar;

    for (var point in drawingPoints) {
      for (var star in starPositions) {
        if (isNearStar(point, star)) {
          if (lastConnectedStar == null || star != lastConnectedStar) {
            connectedStars.add(star);
            lastConnectedStar = star;
          }
        }
      }
    }

    return connectedStars;
  }

  static bool isValidConnection(
    List<Offset> start,
    List<Offset> end,
    List<List<Offset>> completedLines,
    List<List<Offset>> validConnections,
  ) {
    for (var line in completedLines) {
      if ((line.first == start && line.last == end) ||
          (line.first == end && line.last == start)) {
        return false;
      }
    }

    for (var connection in validConnections) {
      if ((connection.first == start && connection.last == end) ||
          (connection.first == end && connection.last == start)) {
        return true;
      }
    }

    return false;
  }

  static List<List<Offset>> validateConnections(
    List<Offset> connectedStars,
    List<List<Offset>> validConnections,
    List<List<Offset>> completedLines,
  ) {
    List<List<Offset>> newValidConnections = [];

    for (int i = 0; i < connectedStars.length - 1; i++) {
      Offset start = connectedStars[i];
      Offset end = connectedStars[i + 1];

      bool isValid = validConnections.any((connection) =>
          (connection.first == start && connection.last == end) ||
          (connection.first == end && connection.last == start));

      bool isNotCompleted = !completedLines.any((line) =>
          (line.first == start && line.last == end) ||
          (line.first == end && line.last == start));

      if (isValid && isNotCompleted) {
        newValidConnections.add([start, end]);
      }
    }

    return newValidConnections;
  }

  static bool isShapeComplete(
    List<List<Offset>> completedLines,
    List<List<Offset>> validConnections,
  ) {
    if (completedLines.length != validConnections.length) return false;

    for (var validConnection in validConnections) {
      bool found = false;
      for (var completedLine in completedLines) {
        if ((completedLine.first == validConnection.first &&
                completedLine.last == validConnection.last) ||
            (completedLine.first == validConnection.last &&
                completedLine.last == validConnection.first)) {
          found = true;
          break;
        }
      }
      if (!found) return false;
    }

    return true;
  }

  static List<Offset> getStarPositionsForShape(Size size, String shape) {
    final topPadding = 220.0;
    final availableHeight = size.height - topPadding - 100.0;

    switch (shape.toLowerCase()) {
      case 'triangle':
        return [
          Offset(size.width * 0.5, topPadding + (availableHeight * 0.1)),
          Offset(size.width * 0.2, topPadding + (availableHeight * 0.8)),
          Offset(size.width * 0.8, topPadding + (availableHeight * 0.8)),
        ];
      case 'square':
        return [
          Offset(size.width * 0.2, topPadding + (availableHeight * 0.2)),
          Offset(size.width * 0.8, topPadding + (availableHeight * 0.2)),
          Offset(size.width * 0.2, topPadding + (availableHeight * 0.8)),
          Offset(size.width * 0.8, topPadding + (availableHeight * 0.8)),
        ];
      default:
        return [];
    }
  }

  static List<List<Offset>> getValidConnectionsForShape(
    List<Offset> starPositions,
    String shape,
  ) {
    switch (shape.toLowerCase()) {
      case 'triangle':
        return [
          [starPositions[0], starPositions[1]],
          [starPositions[1], starPositions[2]],
          [starPositions[2], starPositions[0]],
        ];
      case 'square':
        return [
          [starPositions[0], starPositions[1]],
          [starPositions[1], starPositions[3]],
          [starPositions[3], starPositions[2]],
          [starPositions[2], starPositions[0]],
        ];
      default:
        return [];
    }
  }
}
