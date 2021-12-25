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

  static Future getById(int id) async {
    if(_maxsopianSheet == null) return null;

    final json = await _maxsopianSheet!.values.map.rowByKey(id, fromColumn: 1);

    return json == null ? null : Maxsopian.fromJson(json);
  }

  static Future<List<Maxsopian>> getAll() async {
    if(_maxsopianSheet == null) return <Maxsopian>[];

    final maxsopian = await _maxsopianSheet!.values.map.allRows();

    return maxsopian == null ? <Maxsopian>[] : maxsopian.map(Maxsopian.fromJson).toList();
  }

  static Future<bool> update(int id, Map<String, dynamic> maxsopian) async {
    if(_maxsopianSheet == null) return false;
    
    return _maxsopianSheet!.values.map.insertRowByKey(id, maxsopian);
  }

  static Future<bool> updateCell({required int id, required String key, required dynamic value}) async {
    if(_maxsopianSheet == null) return false;

    return _maxsopianSheet!.values.insertValueByKeys(
        value,
        columnKey: key,
        rowKey: id
    );
  }

  static Future<bool> deleteById(int id) async {
    if(_maxsopianSheet == null) return false;

    final index = await _maxsopianSheet!.values.rowIndexOf(id);

    if (index == -1) return false;

    return _maxsopianSheet!.deleteRow(index);
  }
}