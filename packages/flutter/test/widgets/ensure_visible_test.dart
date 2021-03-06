// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

Finder findKey(int i) => find.byKey(new ValueKey<int>(i));

Widget buildSingleChildScrollView(Axis scrollDirection, { bool reverse: false }) {
  return new Center(
    child: new SizedBox(
      width: 600.0,
      height: 400.0,
      child: new SingleChildScrollView(
        scrollDirection: scrollDirection,
        reverse: reverse,
        child: new BlockBody(
          mainAxis: scrollDirection,
          children: <Widget>[
            new Container(key: const ValueKey<int>(0), width: 200.0, height: 200.0),
            new Container(key: const ValueKey<int>(1), width: 200.0, height: 200.0),
            new Container(key: const ValueKey<int>(2), width: 200.0, height: 200.0),
            new Container(key: const ValueKey<int>(3), width: 200.0, height: 200.0),
            new Container(key: const ValueKey<int>(4), width: 200.0, height: 200.0),
            new Container(key: const ValueKey<int>(5), width: 200.0, height: 200.0),
            new Container(key: const ValueKey<int>(6), width: 200.0, height: 200.0),
          ],
        ),
      ),
    ),
  );
}

Widget buildListView(Axis scrollDirection, { bool reverse: false, bool shrinkWrap: false }) {
  return new Center(
    child: new SizedBox(
      width: 600.0,
      height: 400.0,
      child: new ListView(
        scrollDirection: scrollDirection,
        reverse: reverse,
        shrinkWrap: shrinkWrap,
        children: <Widget>[
          new Container(key: const ValueKey<int>(0), width: 200.0, height: 200.0),
          new Container(key: const ValueKey<int>(1), width: 200.0, height: 200.0),
          new Container(key: const ValueKey<int>(2), width: 200.0, height: 200.0),
          new Container(key: const ValueKey<int>(3), width: 200.0, height: 200.0),
          new Container(key: const ValueKey<int>(4), width: 200.0, height: 200.0),
          new Container(key: const ValueKey<int>(5), width: 200.0, height: 200.0),
          new Container(key: const ValueKey<int>(6), width: 200.0, height: 200.0),
        ],
      ),
    ),
  );
}

void main() {

  group('SingleChildScollView', () {
    testWidgets('SingleChildScollView ensureVisible Axis.vertical', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));

      await tester.pumpWidget(buildSingleChildScrollView(Axis.vertical));

      Scrollable2.ensureVisible(findContext(3));
      await tester.pump();
      expect(tester.getTopLeft(findKey(3)).y, equals(100.0));

      Scrollable2.ensureVisible(findContext(6));
      await tester.pump();
      expect(tester.getTopLeft(findKey(6)).y, equals(300.0));

      Scrollable2.ensureVisible(findContext(4), alignment: 1.0);
      await tester.pump();
      expect(tester.getBottomRight(findKey(4)).y, equals(500.0));

      Scrollable2.ensureVisible(findContext(0), alignment: 1.0);
      await tester.pump();
      expect(tester.getTopLeft(findKey(0)).y, equals(100.0));

      Scrollable2.ensureVisible(findContext(3), duration: const Duration(seconds: 1));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1020));
      expect(tester.getTopLeft(findKey(3)).y, equals(100.0));
    });

    testWidgets('SingleChildScollView ensureVisible Axis.horizontal', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));

      await tester.pumpWidget(buildSingleChildScrollView(Axis.horizontal));

      Scrollable2.ensureVisible(findContext(3));
      await tester.pump();
      expect(tester.getTopLeft(findKey(3)).x, equals(100.0));

      Scrollable2.ensureVisible(findContext(6));
      await tester.pump();
      expect(tester.getTopLeft(findKey(6)).x, equals(500.0));

      Scrollable2.ensureVisible(findContext(4), alignment: 1.0);
      await tester.pump();
      expect(tester.getBottomRight(findKey(4)).x, equals(700.0));

      Scrollable2.ensureVisible(findContext(0), alignment: 1.0);
      await tester.pump();
      expect(tester.getTopLeft(findKey(0)).x, equals(100.0));

      Scrollable2.ensureVisible(findContext(3), duration: const Duration(seconds: 1));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1020));
      expect(tester.getTopLeft(findKey(3)).x, equals(100.0));
    });

    testWidgets('SingleChildScollView ensureVisible Axis.vertical reverse', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));

      await tester.pumpWidget(buildSingleChildScrollView(Axis.vertical, reverse: true));

      Scrollable2.ensureVisible(findContext(3));
      await tester.pump();
      expect(tester.getBottomRight(findKey(3)).y, equals(500.0));

      Scrollable2.ensureVisible(findContext(0));
      await tester.pump();
      expect(tester.getBottomRight(findKey(0)).y, equals(300.0));

      Scrollable2.ensureVisible(findContext(2), alignment: 1.0);
      await tester.pump();
      expect(tester.getTopLeft(findKey(2)).y, equals(100.0));

      Scrollable2.ensureVisible(findContext(6), alignment: 1.0);
      await tester.pump();
      expect(tester.getBottomRight(findKey(6)).y, equals(500.0));

      Scrollable2.ensureVisible(findContext(3), duration: const Duration(seconds: 1));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1020));
      expect(tester.getBottomRight(findKey(3)).y, equals(500.0));
    });

    testWidgets('SingleChildScollView ensureVisible Axis.horizontal reverse', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));

      await tester.pumpWidget(buildSingleChildScrollView(Axis.horizontal, reverse: true));

      Scrollable2.ensureVisible(findContext(3));
      await tester.pump();
      expect(tester.getBottomRight(findKey(3)).x, equals(700.0));

      Scrollable2.ensureVisible(findContext(0));
      await tester.pump();
      expect(tester.getBottomRight(findKey(0)).x, equals(300.0));

      Scrollable2.ensureVisible(findContext(2), alignment: 1.0);
      await tester.pump();
      expect(tester.getTopLeft(findKey(2)).x, equals(100.0));

      Scrollable2.ensureVisible(findContext(6), alignment: 1.0);
      await tester.pump();
      expect(tester.getBottomRight(findKey(6)).x, equals(700.0));

      Scrollable2.ensureVisible(findContext(3), duration: const Duration(seconds: 1));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1020));
      expect(tester.getBottomRight(findKey(3)).x, equals(700.0));
    });

    testWidgets('SingleChildScollView ensureVisible rotated child', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));

      await tester.pumpWidget(
        new Center(
          child: new SizedBox(
            width: 600.0,
            height: 400.0,
            child: new SingleChildScrollView(
              child: new BlockBody(
                children: <Widget>[
                  new Container(height: 200.0),
                  new Container(height: 200.0),
                  new Container(height: 200.0),
                  new Container(
                    height: 200.0,
                    child: new Center(
                      child: new Transform(
                        transform: new Matrix4.rotationZ(math.PI),
                        child: new Container(
                          key: const ValueKey<int>(0),
                          width: 100.0,
                          height: 100.0,
                          decoration: const BoxDecoration(
                            backgroundColor: const Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Container(height: 200.0),
                  new Container(height: 200.0),
                  new Container(height: 200.0),
                ],
              ),
            ),
          ),
        )
      );

      Scrollable2.ensureVisible(findContext(0));
      await tester.pump();
      expect(tester.getBottomRight(findKey(0)).y, closeTo(100.0, 0.1));

      Scrollable2.ensureVisible(findContext(0), alignment: 1.0);
      await tester.pump();
      expect(tester.getTopLeft(findKey(0)).y, closeTo(500.0, 0.1));
    });
  });

  group('ListView', () {
    testWidgets('ListView ensureVisible Axis.vertical', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));
      Future<Null> prepare(double offset) async {
        tester.state<Scrollable2State>(find.byType(Scrollable2)).position.jumpTo(offset);
        await tester.pump();
      }

      await tester.pumpWidget(buildListView(Axis.vertical));

      await prepare(480.0);
      Scrollable2.ensureVisible(findContext(3));
      await tester.pump();
      expect(tester.getTopLeft(findKey(3)).y, equals(100.0));

      await prepare(1083.0);
      Scrollable2.ensureVisible(findContext(6));
      await tester.pump();
      expect(tester.getTopLeft(findKey(6)).y, equals(300.0));

      await prepare(735.0);
      Scrollable2.ensureVisible(findContext(4), alignment: 1.0);
      await tester.pump();
      expect(tester.getBottomRight(findKey(4)).y, equals(500.0));

      await prepare(123.0);
      Scrollable2.ensureVisible(findContext(0), alignment: 1.0);
      await tester.pump();
      expect(tester.getTopLeft(findKey(0)).y, equals(100.0));

      await prepare(523.0);
      Scrollable2.ensureVisible(findContext(3), duration: const Duration(seconds: 1));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1020));
      expect(tester.getTopLeft(findKey(3)).y, equals(100.0));
    });

    testWidgets('ListView ensureVisible Axis.horizontal', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));
      Future<Null> prepare(double offset) async {
        tester.state<Scrollable2State>(find.byType(Scrollable2)).position.jumpTo(offset);
        await tester.pump();
      }

      await tester.pumpWidget(buildListView(Axis.horizontal));

      await prepare(23.0);
      Scrollable2.ensureVisible(findContext(3));
      await tester.pump();
      expect(tester.getTopLeft(findKey(3)).x, equals(100.0));

      await prepare(843.0);
      Scrollable2.ensureVisible(findContext(6));
      await tester.pump();
      expect(tester.getTopLeft(findKey(6)).x, equals(500.0));

      await prepare(415.0);
      Scrollable2.ensureVisible(findContext(4), alignment: 1.0);
      await tester.pump();
      expect(tester.getBottomRight(findKey(4)).x, equals(700.0));

      await prepare(46.0);
      Scrollable2.ensureVisible(findContext(0), alignment: 1.0);
      await tester.pump();
      expect(tester.getTopLeft(findKey(0)).x, equals(100.0));

      await prepare(211.0);
      Scrollable2.ensureVisible(findContext(3), duration: const Duration(seconds: 1));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1020));
      expect(tester.getTopLeft(findKey(3)).x, equals(100.0));
    });

    testWidgets('ListView ensureVisible Axis.vertical reverse', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));
      Future<Null> prepare(double offset) async {
        tester.state<Scrollable2State>(find.byType(Scrollable2)).position.jumpTo(offset);
        await tester.pump();
      }

      await tester.pumpWidget(buildListView(Axis.vertical, reverse: true));

      await prepare(211.0);
      Scrollable2.ensureVisible(findContext(3));
      await tester.pump();
      expect(tester.getBottomRight(findKey(3)).y, equals(500.0));

      await prepare(23.0);
      Scrollable2.ensureVisible(findContext(0));
      await tester.pump();
      expect(tester.getBottomRight(findKey(0)).y, equals(500.0));

      await prepare(230.0);
      Scrollable2.ensureVisible(findContext(2), alignment: 1.0);
      await tester.pump();
      expect(tester.getTopLeft(findKey(2)).y, equals(100.0));

      await prepare(1083.0);
      Scrollable2.ensureVisible(findContext(6), alignment: 1.0);
      await tester.pump();
      expect(tester.getBottomRight(findKey(6)).y, equals(300.0));

      await prepare(345.0);
      Scrollable2.ensureVisible(findContext(3), duration: const Duration(seconds: 1));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1020));
      expect(tester.getBottomRight(findKey(3)).y, equals(500.0));
    });

    testWidgets('ListView ensureVisible Axis.horizontal reverse', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));
      Future<Null> prepare(double offset) async {
        tester.state<Scrollable2State>(find.byType(Scrollable2)).position.jumpTo(offset);
        await tester.pump();
      }

      await tester.pumpWidget(buildListView(Axis.horizontal, reverse: true));

      await prepare(211.0);
      Scrollable2.ensureVisible(findContext(3));
      await tester.pump();
      expect(tester.getBottomRight(findKey(3)).x, equals(700.0));

      await prepare(23.0);
      Scrollable2.ensureVisible(findContext(0));
      await tester.pump();
      expect(tester.getBottomRight(findKey(0)).x, equals(700.0));

      await prepare(230.0);
      Scrollable2.ensureVisible(findContext(2), alignment: 1.0);
      await tester.pump();
      expect(tester.getTopLeft(findKey(2)).x, equals(100.0));

      await prepare(1083.0);
      Scrollable2.ensureVisible(findContext(6), alignment: 1.0);
      await tester.pump();
      expect(tester.getBottomRight(findKey(6)).x, equals(300.0));

      await prepare(345.0);
      Scrollable2.ensureVisible(findContext(3), duration: const Duration(seconds: 1));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1020));
      expect(tester.getBottomRight(findKey(3)).x, equals(700.0));
    });

    // TODO(abarth): Unskip this test. See https://github.com/flutter/flutter/issues/7919
    testWidgets('ListView ensureVisible negative child', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));
      Future<Null> prepare(double offset) async {
        tester.state<Scrollable2State>(find.byType(Scrollable2)).position.jumpTo(offset);
        await tester.pump();
      }

      double getOffset() {
        return tester.state<Scrollable2State>(find.byType(Scrollable2)).position.pixels;
      }

      Widget buildSliver(int i) {
        return new SliverToBoxAdapter(
          key: new ValueKey<int>(i),
          child: new Container(width: 200.0, height: 200.0),
        );
      }

      await tester.pumpWidget(new Center(
        child: new SizedBox(
          width: 600.0,
          height: 400.0,
          child: new Scrollable2(
            viewportBuilder: (BuildContext context, ViewportOffset offset) {
              return new Viewport2(
                offset: offset,
                center: const ValueKey<int>(4),
                slivers: <Widget>[
                  buildSliver(0),
                  buildSliver(1),
                  buildSliver(2),
                  buildSliver(3),
                  buildSliver(4),
                  buildSliver(5),
                  buildSliver(6),
                ],
              );
            },
          ),
        ),
      ));

      await prepare(-125.0);
      Scrollable2.ensureVisible(findContext(3));
      await tester.pump();
      expect(getOffset(), equals(-200.0));

      await prepare(-225.0);
      Scrollable2.ensureVisible(findContext(2));
      await tester.pump();
      expect(getOffset(), equals(-400.0));
    }, skip: true);

    testWidgets('ListView ensureVisible rotated child', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));
      Future<Null> prepare(double offset) async {
        tester.state<Scrollable2State>(find.byType(Scrollable2)).position.jumpTo(offset);
        await tester.pump();
      }

      await tester.pumpWidget(
        new Center(
          child: new SizedBox(
            width: 600.0,
            height: 400.0,
            child: new ListView(
              children: <Widget>[
                new Container(height: 200.0),
                new Container(height: 200.0),
                new Container(height: 200.0),
                new Container(
                  height: 200.0,
                  child: new Center(
                    child: new Transform(
                      transform: new Matrix4.rotationZ(math.PI),
                      child: new Container(
                        key: const ValueKey<int>(0),
                        width: 100.0,
                        height: 100.0,
                        decoration: const BoxDecoration(
                          backgroundColor: const Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
                new Container(height: 200.0),
                new Container(height: 200.0),
                new Container(height: 200.0),
              ],
            ),
          ),
        )
      );

      await prepare(321.0);
      Scrollable2.ensureVisible(findContext(0));
      await tester.pump();
      expect(tester.getBottomRight(findKey(0)).y, closeTo(100.0, 0.1));

      Scrollable2.ensureVisible(findContext(0), alignment: 1.0);
      await tester.pump();
      expect(tester.getTopLeft(findKey(0)).y, closeTo(500.0, 0.1));
    });
  });

  group('ListView shrinkWrap', () {
    testWidgets('ListView ensureVisible Axis.vertical', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));
      Future<Null> prepare(double offset) async {
        tester.state<Scrollable2State>(find.byType(Scrollable2)).position.jumpTo(offset);
        await tester.pump();
      }

      await tester.pumpWidget(buildListView(Axis.vertical, shrinkWrap: true));

      await prepare(480.0);
      Scrollable2.ensureVisible(findContext(3));
      await tester.pump();
      expect(tester.getTopLeft(findKey(3)).y, equals(100.0));

      await prepare(1083.0);
      Scrollable2.ensureVisible(findContext(6));
      await tester.pump();
      expect(tester.getTopLeft(findKey(6)).y, equals(300.0));

      await prepare(735.0);
      Scrollable2.ensureVisible(findContext(4), alignment: 1.0);
      await tester.pump();
      expect(tester.getBottomRight(findKey(4)).y, equals(500.0));

      await prepare(123.0);
      Scrollable2.ensureVisible(findContext(0), alignment: 1.0);
      await tester.pump();
      expect(tester.getTopLeft(findKey(0)).y, equals(100.0));

      await prepare(523.0);
      Scrollable2.ensureVisible(findContext(3), duration: const Duration(seconds: 1));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1020));
      expect(tester.getTopLeft(findKey(3)).y, equals(100.0));
    });

    testWidgets('ListView ensureVisible Axis.horizontal', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));
      Future<Null> prepare(double offset) async {
        tester.state<Scrollable2State>(find.byType(Scrollable2)).position.jumpTo(offset);
        await tester.pump();
      }

      await tester.pumpWidget(buildListView(Axis.horizontal, shrinkWrap: true));

      await prepare(23.0);
      Scrollable2.ensureVisible(findContext(3));
      await tester.pump();
      expect(tester.getTopLeft(findKey(3)).x, equals(100.0));

      await prepare(843.0);
      Scrollable2.ensureVisible(findContext(6));
      await tester.pump();
      expect(tester.getTopLeft(findKey(6)).x, equals(500.0));

      await prepare(415.0);
      Scrollable2.ensureVisible(findContext(4), alignment: 1.0);
      await tester.pump();
      expect(tester.getBottomRight(findKey(4)).x, equals(700.0));

      await prepare(46.0);
      Scrollable2.ensureVisible(findContext(0), alignment: 1.0);
      await tester.pump();
      expect(tester.getTopLeft(findKey(0)).x, equals(100.0));

      await prepare(211.0);
      Scrollable2.ensureVisible(findContext(3), duration: const Duration(seconds: 1));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1020));
      expect(tester.getTopLeft(findKey(3)).x, equals(100.0));
    });

    testWidgets('ListView ensureVisible Axis.vertical reverse', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));
      Future<Null> prepare(double offset) async {
        tester.state<Scrollable2State>(find.byType(Scrollable2)).position.jumpTo(offset);
        await tester.pump();
      }

      await tester.pumpWidget(buildListView(Axis.vertical, reverse: true, shrinkWrap: true));

      await prepare(211.0);
      Scrollable2.ensureVisible(findContext(3));
      await tester.pump();
      expect(tester.getBottomRight(findKey(3)).y, equals(500.0));

      await prepare(23.0);
      Scrollable2.ensureVisible(findContext(0));
      await tester.pump();
      expect(tester.getBottomRight(findKey(0)).y, equals(500.0));

      await prepare(230.0);
      Scrollable2.ensureVisible(findContext(2), alignment: 1.0);
      await tester.pump();
      expect(tester.getTopLeft(findKey(2)).y, equals(100.0));

      await prepare(1083.0);
      Scrollable2.ensureVisible(findContext(6), alignment: 1.0);
      await tester.pump();
      expect(tester.getBottomRight(findKey(6)).y, equals(300.0));

      await prepare(345.0);
      Scrollable2.ensureVisible(findContext(3), duration: const Duration(seconds: 1));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1020));
      expect(tester.getBottomRight(findKey(3)).y, equals(500.0));
    });

    testWidgets('ListView ensureVisible Axis.horizontal reverse', (WidgetTester tester) async {
      BuildContext findContext(int i) => tester.element(findKey(i));
      Future<Null> prepare(double offset) async {
        tester.state<Scrollable2State>(find.byType(Scrollable2)).position.jumpTo(offset);
        await tester.pump();
      }

      await tester.pumpWidget(buildListView(Axis.horizontal, reverse: true, shrinkWrap: true));

      await prepare(211.0);
      Scrollable2.ensureVisible(findContext(3));
      await tester.pump();
      expect(tester.getBottomRight(findKey(3)).x, equals(700.0));

      await prepare(23.0);
      Scrollable2.ensureVisible(findContext(0));
      await tester.pump();
      expect(tester.getBottomRight(findKey(0)).x, equals(700.0));

      await prepare(230.0);
      Scrollable2.ensureVisible(findContext(2), alignment: 1.0);
      await tester.pump();
      expect(tester.getTopLeft(findKey(2)).x, equals(100.0));

      await prepare(1083.0);
      Scrollable2.ensureVisible(findContext(6), alignment: 1.0);
      await tester.pump();
      expect(tester.getBottomRight(findKey(6)).x, equals(300.0));

      await prepare(345.0);
      Scrollable2.ensureVisible(findContext(3), duration: const Duration(seconds: 1));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1020));
      expect(tester.getBottomRight(findKey(3)).x, equals(700.0));
    });
  });
}
