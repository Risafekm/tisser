// lib/core/utils/export_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:tisser_app/features/task/domain/entities/task_entities.dart';

class ExportService {
  static final _dateFmt = DateFormat('MMM dd, yyyy');

  /// Returns saved file [File]
  static Future<File> exportTasksToCsv({
    required List<TaskEntity> tasks,
    String filename = 'tasks_report.csv',
  }) async {
    final headers = ['ID', 'Title', 'Description', 'Status', 'Created Date'];

    final rows =
        tasks.map((t) {
          return [
            t.id ?? '',
            t.title,
            t.description,
            t.status,
            _dateFmt.format(t.createdDate),
          ];
        }).toList();

    final csv = const ListToCsvConverter().convert([headers, ...rows]);
    final file = await _saveToFile(
      bytes: utf8.encode(csv),
      suggestedName: filename,
    );
    return file;
  }

  /// Returns saved file [File]
  static Future<File> exportTasksToPdf({
    required List<TaskEntity> tasks,
    String filename = 'tasks_report.pdf',
    String title = 'Tasks Report',
  }) async {
    final pdf = pw.Document();

    final tableHeaders = ['ID', 'Title', 'Status', 'Created', 'Description'];

    final tableData =
        tasks.map((t) {
          return [
            t.id ?? '',
            t.title,
            t.status,
            _dateFmt.format(t.createdDate),
            t.description,
          ];
        }).toList();

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(24),
        pageFormat: PdfPageFormat.a4,
        build:
            (context) => [
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                'Generated: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}',
              ),
              pw.SizedBox(height: 16),
              pw.Table.fromTextArray(
                headers: tableHeaders,
                data: tableData,
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration: const pw.BoxDecoration(
                  color: PdfColors.grey300,
                ),
                cellAlignment: pw.Alignment.centerLeft,
                headerAlignment: pw.Alignment.centerLeft,
                cellStyle: const pw.TextStyle(fontSize: 10),
                cellPadding: const pw.EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 6,
                ),
                columnWidths: {
                  0: const pw.FlexColumnWidth(1), // ID
                  1: const pw.FlexColumnWidth(2.2), // Title
                  2: const pw.FlexColumnWidth(1.4), // Status
                  3: const pw.FlexColumnWidth(1.6), // Created
                  4: const pw.FlexColumnWidth(3), // Description
                },
              ),
            ],
      ),
    );

    final bytes = await pdf.save();
    final file = await _saveToFile(bytes: bytes, suggestedName: filename);
    return file;
  }

  /// Opens the platform share sheet for the given file.
  static Future<void> shareFile(
    File file, {
    String? subject,
    String? text,
  }) async {
    if (kIsWeb) {
      // On web, Share.shareXFiles is supported but saving to real FS differs.
      await Share.shareXFiles([XFile(file.path)], subject: subject, text: text);
      return;
    }
    await Share.shareXFiles([XFile(file.path)], subject: subject, text: text);
  }

  /// Utility to save bytes to a writable location with a suggested filename.
  static Future<File> _saveToFile({
    required List<int> bytes,
    required String suggestedName,
  }) async {
    Directory dir;

    // Prefer app docs dir (no runtime perms needed). Works on iOS/Android/desktop.
    dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$suggestedName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
