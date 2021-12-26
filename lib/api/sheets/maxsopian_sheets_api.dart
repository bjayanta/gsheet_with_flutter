import 'package:gsheets/gsheets.dart';
import 'package:maxsopian/model/maxsopian.dart';

class MaxsopianSheetApi {
  static final _credentials = r'''{
  "type": "service_account",
  "project_id": "maxsopian",
  "private_key_id": "bb4df2c4440bc93df7b36b881ceb10d7cb66759c",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC0TQyxxOULHdff\nRX+oDHgmCKv55LeaMJ+31FrA9nYmS/vJIlytuqKfJCFQrJGEmI0dTHrQVZ+B+tcn\nC0URoKsHdB3+GgQzP6uADmkeyBPZ8gagmP6U95+TWpinfAetPdOWx6VwxLeuNHI4\nINd0VHPGwdNykP4Ymo8LAwRqQxZkdmMOG4aE3EJILkyrjkb++IQ0QroYd4Yn68SA\nN9Ue8HHL07aZPevLzJOinPXSuEVOOP9Kk5VyvAF7wwYoaOv0dTdXFGBK+4Jek72P\nCkFEgKCuXxgrvBnFU/+5IxAXbsBcOa0nkJg0fRXYhRD7S2MWdTgf4VdJHPiDHX8K\nYVrML9mpAgMBAAECggEAPAf1ZJD+g9OFZyDwLocsT9mOTQ8ydGOhIidRqjLFRt4A\nsMjAm9VqxNrWPtKeRsw2G921fH0ttSzMCwNtFT/uAfbO76ZA5MFbvDDQHkAWn/e9\n7iXSic3is0C0V/trYOqXcvn5IxFUaOusZfTFV8WwoKozWU9eUtnPK6bvBuRcZckX\n0Xyp/vzqs+gw3I1JwO0YslJEuW4AVcvAQxdU4VkHUL3EZKOPALaMEU6Qg0vPsvvc\nIFi7HldSUrgDPkpokooIWtrdawN7L4RJPDG0t75ZpqQstJ9PD31NH0oWdjFSxE8Y\nOx1T5jq6Xr1E9Vdb7gI0WsZ+fwlZrz9Eizla23ovUwKBgQDidt1Ava29TPIF6ZDC\n31CTmGTlwmyR+dzrGLiC6EbapVjPfgB871wt7CBEOms9jnlrWO8JB/JUmdev3MpV\nYVsdudm7w+VErPp9J/cZ+F2lnH1Tips7HH8371MtAzRKonLTxnfUiHjrHEdFZSdG\nS86bvJXb1lQXj9M/hDIWuVt5kwKBgQDL0OUaYRiShbRkaGP+B31bWS0Gvx5bCBkL\nMnYbHhc2kA/hjug9JKfDe7axg7IPqiqew6wZOAwWt5kDc5nElSXhXDIOtdonHAhP\nd4SdlLXlpCvdJt+/qOo4MUBcDpf3DwSSOMLZoLwAb4eNdTqVBIkNslRvvUkFFALp\n5En0mLQ1UwKBgEXwj8Q+0Dl2WgiZaavFbA0pM4AB26X5lNDGgbVsJvW/uv3Z3Cy5\nf65vDkgEArqwFa+hd7FCUwTtvj8B4TsdJha4HxZuGZBsG7Ard5T9r25GNi5m0Coh\nUujjcLymELA8G1psIPXyb+WshhZYdxiusNBIHcAXIUFlmcgz+4QpGqchAoGAMRpR\np8pOrjYyIKKZvIC3bcONOnve51WLGwx8McpNE2MfwFq6jsh+9nSeriOpSWbYv8kq\ndCTxnKN85Lz8BcVdC+83TB35wcRaKDMGKyTBseKcgroz26vpScJr3AHUELx4gHXW\nU7IKuRwljyn4BCDEmB0nhIgYyHVqwkiynJARkmsCgYEAi51aIhazP150Z/qLVVyO\noI2SLBDe6x2NBwi+RdrDIKNg+T6iQZd6+1ezIbFaTQsVuXSAmB8/mHTWfpEoCJiE\nmIFmps9+LojHmCtL2Xx5gctm2x+IHduFLs3Cf0CprcpPGHtBsD6RbVg5IOaPWTFa\nlmix9RYCC+psJeyQGMx51Qc=\n-----END PRIVATE KEY-----\n",
  "client_email": "maxsopian@maxsopian.iam.gserviceaccount.com",
  "client_id": "100037989435245752147",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/maxsopian%40maxsopian.iam.gserviceaccount.com"
}''';
  static final _spreadsheetId = '1TlB8SOigcYn3M3YXeFUtHGrCc8LdkyVL9TpG2MT3ouk';
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