import "package:flutter/material.dart";

import "package:fast_immutable_collections_benchmarks/fast_immutable_collections_benchmarks.dart";

import "../screens/code_screen.dart";
import "collection_button.dart";

class BenchWidget extends StatefulWidget {
  final String description;
  final Map<String, String> code;
  final MultiBenchmarkReporter benchmark;

  BenchWidget({
    this.description,
    this.code,
    @required this.benchmark,
  });

  @override
  _BenchWidgetState createState() => _BenchWidgetState();
}

class _BenchWidgetState extends State<BenchWidget> {
  bool _isRunning;
  RecordsTable _results;

  @override
  void initState() {
    super.initState();
    _isRunning = false;
  }

  // TODO: not working... it doesn't disable the button during processing probably because it is
  // being executed synchronously.
  void _run() {
    setState(() => _isRunning = true);
    widget.benchmark.report();
    _results = widget.benchmark.emitter.table;
    setState(() => _isRunning = false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.description,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: CollectionButton(
                    label: "Run",
                    onPressed: _isRunning ? null : _run,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CollectionButton(
                    label: "Results",
                    onPressed: !_isRunning ? () => print("View results!") : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CollectionButton(
                    label: "Code",
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CodeScreen(widget.description, widget.code)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}