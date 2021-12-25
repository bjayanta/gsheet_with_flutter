import 'package:flutter/material.dart';
import 'package:maxsopian/api/sheets/maxsopian_sheets_api.dart';
import 'package:maxsopian/model/maxsopian.dart';
import 'package:maxsopian/widgets/maxsopian_form.dart';
import 'package:maxsopian/widgets/navigate_maxsopians_widget.dart';
import 'package:maxsopian/widgets/submit_button.dart';

class ModifySheetsPage extends StatefulWidget {
  const ModifySheetsPage({Key? key}) : super(key: key);

  @override
  _ModifySheetsPageState createState() => _ModifySheetsPageState();
}

class _ModifySheetsPageState extends State<ModifySheetsPage> {
  List<Maxsopian> maxsopians = [];
  int index = 0;

  void initState() {
    super.initState();

    getMaxsopian();
  }

  Future getMaxsopian() async {
    final maxsopians = await MaxsopianSheetApi.getAll();

    setState(() {
      this.maxsopians = maxsopians;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modify Sheets Page"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16),
          children: [
            MaxsopianForm(
              text: "Update",
              user: maxsopians.isEmpty ? null : maxsopians[index],
              onSavedMaxsopian: (maxsopian) async {
                // update a row
                await MaxsopianSheetApi.update(
                    maxsopian.id!, maxsopian.toJson());

                // update a specific column
                // MaxsopianSheetApi.updateCell(id: maxsopian.id!, key: 'name', value: 'Flutter');

                print(maxsopian.toJson());
              },
            ),
            if (maxsopians.isNotEmpty) buildMaxsopianControls(),
          ],
        ),
      ),
    );
  }

  Widget buildMaxsopianControls() => Column(
        children: [
          SubmitButton(
              text: 'Delete',
              onClicked: deleteMaxsopian,
          ),
          SizedBox(height: 5,),
          NavigateMaxsopiansWidget(
              text: '${index + 1}/${maxsopians.length} MaxSOPians',
              onClickedNext: () {
                final nextIndex =
                    index >= maxsopians.length - 1 ? 0 : index + 1;
                setState(() {
                  index = nextIndex;
                });
              },
              onClickedPrevious: () {
                final previousIndex =
                    index <= 0 ? maxsopians.length - 1 : index - 1;
                setState(() {
                  index = previousIndex;
                });
              }),
        ],
      );

  Future deleteMaxsopian() async {
    final maxsopian = maxsopians[index];
    await MaxsopianSheetApi.deleteById(maxsopian.id!);

    // updating ui
    final newIndex = index > 0 ? index - 1 : 0;

    setState(() {
      index = newIndex;
    });

    await getMaxsopian();
  }
}
