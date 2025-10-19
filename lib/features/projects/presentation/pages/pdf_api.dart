import 'dart:io';
import 'dart:typed_data';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class PdfApi {
  final String invoiceNum;
  final DateTime createdAt;
  final String? paymentMethod;
  final String projectName;
  final double amount;
  final Client client;
  PdfApi({
    required this.invoiceNum,
    required this.createdAt,
    required this.paymentMethod,
    required this.projectName,
    required this.amount,
    required this.client,
  });
  Future<File> generatePDFInvoice(
    Uint8List? signatureBytes,
    String invoiceName,
  ) async {
    final signatureImage = signatureBytes != null
        ? pw.MemoryImage(signatureBytes)
        : null;
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(16),
            ),
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(20),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Header
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.all(20),
                    decoration: pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.circular(12),
                      gradient: const pw.LinearGradient(
                        colors: [PdfColors.blue, PdfColors.purple],
                        begin: pw.Alignment.topLeft,
                        end: pw.Alignment.bottomRight,
                      ),
                    ),
                    child: pw.Row(
                      children: [
                        pw.Icon(
                          const pw.IconData(0xe876),
                          color: PdfColors.white,
                        ),
                        pw.SizedBox(width: 8),
                        pw.Text(
                          "INVOICE",
                          style: pw.TextStyle(
                            fontSize: 22,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    invoiceNum,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  pw.Text(createdAt.toString()),
                  pw.Divider(height: 30),
                  // Client Section
                  pw.Text(
                    "Client",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(client.clientName),
                  pw.Text(client.companyName),
                  pw.Text(client.clientEmail),
                  pw.Divider(height: 30),
                  // Project Section
                  pw.Text(
                    "Project",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    projectName,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),

                  pw.SizedBox(height: 8),

                  pw.Divider(height: 30),

                  // Payment Method
                  pw.Text(
                    "Payment Method",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  pw.Text(paymentMethod!),
                  pw.Divider(height: 30),

                  // Total
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "Total Due",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      pw.Text(
                        '\$ ${amount.toString()}',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  pw.Divider(height: 30),

                  // Signature Section
                  pw.Text(
                    "Authorized Signature",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  // Insert signature if available
                  if (signatureImage != null)
                    pw.Container(height: 80, child: pw.Image(signatureImage))
                  else
                    pw.Text("No signature provided"),
                  pw.SizedBox(height: 20),
                  pw.Text("Alex Doe   +1 555-123-4567"),
                  pw.Text("www.alexdoe.com"),
                ],
              ),
            ),
          );
        },
      ),
    );
    return saveDocument(name: invoiceName, pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
