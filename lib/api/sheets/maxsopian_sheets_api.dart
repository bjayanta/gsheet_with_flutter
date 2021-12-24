import 'package:gsheets/gsheets.dart';
import 'package:maxsopian/model/maxsopian.dart';

class MaxsopianSheetApi {
  static final _credentials = r'''{
  "type": "",
  "project_id": "",
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "",
  "token_uri": "",
  "auth_provider_x509_cert_url": "",
  "client_x509_cert_url": ""
}''';
  static final _spreadsheetId = '';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _maxsopianSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _maxsopianSheet = await _getWorkSheet(spreadsheet, title: 'Maxsopian');

      final firstRow = MaxsopianFields.getFields();
      _maxsopianSheet!.values.insertRow(1, firstRow);
    } catch(e) {
      print('Init error: $e');
    }
  }

  static Future _getWorkSheet(Spreadsheet spreadsheet, { required String title }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if(_maxsopianSheet == null) return;

    _maxsopianSheet!.values.map.appendRows(rowList);
  }

  static Future<int> getRowCount() async {
    if(_maxsopianSheet == null) return 0;

    // get last row
    final lastRow = await _maxsopianSheet!.values.lastRow();

    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }
}