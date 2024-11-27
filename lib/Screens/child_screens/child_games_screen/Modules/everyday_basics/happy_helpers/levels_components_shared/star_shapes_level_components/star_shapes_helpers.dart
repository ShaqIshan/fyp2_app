import 'package:flutter/material.dart';

class StarShapesHelpers {
  static bool isNearStar(Offset point, Offset starPosition) {
    final distance = (point - starPosition).distance;
    return distance < 40.0; // Increased from 30.0 for more forgiving detection
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
          // Only add if it's a new star and not the same as the last connected star
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
    Offset start,
    Offset end,
    List<List<Offset>> completedLines,
    List<List<Offset>> validConnections,
  ) {
    // Check if this connection already exists
    for (var line in completedLines) {
      if ((line.first == start && line.last == end) ||
          (line.first == end && line.last == start)) {
        return false;
      }
    }

    // Check if this is a valid connection
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

    // Check consecutive pairs of stars
    for (int i = 0; i < connectedStars.length - 1; i++) {
      Offset start = connectedStars[i];
      Offset end = connectedStars[i + 1];

      // Check if this connection is valid and not already completed
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
    // Adjust top padding and distribution
    final topPadding = 220.0; // Increased from 160.0 to give more space
    // Also reserve some bottom space
    final availableHeight = size.height - topPadding - 100.0;
    switch (shape.toLowerCase()) {
      case 'triangle':
        return [
          // Top
          Offset(size.width * 0.5, topPadding + (availableHeight * 0)),
          // Bottom Left
          Offset(size.width * 0.2, topPadding + (availableHeight * 0.8)),
          // Bottom Right
          Offset(size.width * 0.8, topPadding + (availableHeight * 0.8)),
        ];
      case 'square':
        return [
          // Top Left
          Offset(size.width * 0.2, topPadding + (availableHeight * 0.1)),
          // Top Right
          Offset(size.width * 0.8, topPadding + (availableHeight * 0.1)),
          // Bottom Left
          Offset(size.width * 0.2, topPadding + (availableHeight * 0.8)),
          // Bottom Right
          Offset(size.width * 0.8, topPadding + (availableHeight * 0.8)),
        ];
      // You can add more shapes here
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
          [starPositions[0], starPositions[1]], // Top to Bottom Left
          [starPositions[1], starPositions[2]], // Bottom Left to Bottom Right
          [starPositions[2], starPositions[0]], // Bottom Right to Top
        ];
      case 'square':
        return [
          [starPositions[0], starPositions[1]], // Top Left to Top Right
          [starPositions[1], starPositions[3]], // Top Right to Bottom Right
          [starPositions[3], starPositions[2]], // Bottom Right to Bottom Left
          [starPositions[2], starPositions[0]], // Bottom Left to Top Left
        ];
      // You can add more shapes here
      default:
        return [];
    }
  }
}
