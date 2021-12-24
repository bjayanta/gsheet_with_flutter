import 'package:flutter/material.dart';
import 'package:maxsopian/api/sheets/maxsopian_sheets_api.dart';
import 'package:maxsopian/model/maxsopian.dart';

class CreateSheetsPage extends StatefulWidget {
  const CreateSheetsPage({Key? key}) : super(key: key);

  @override
  _CreateSheetsPageState createState() => _CreateSheetsPageState();
}

class _CreateSheetsPageState extends State<CreateSheetsPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late TextEditingController controllerMobile;
  late bool isIntern;

  @override
  void initState() {
    super.initState();

    initMaxsopian();
  }

  void initMaxsopian() {
    controllerName = TextEditingController();
    controllerEmail = TextEditingController();
    controllerMobile = TextEditingController();
    this.isIntern = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GSheet"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildName(),
                SizedBox(height: 16,),
                buildEmail(),
                SizedBox(height: 16,),
                buildMobile(),
                SizedBox(height: 16,),
                buildIntern(),
                SizedBox(height: 16,),
                buildSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName() => TextFormField(
    controller: controllerName,
    decoration: InputDecoration(
      labelText: 'Name',
      border: OutlineInputBorder(),
    ),
    validator: (value) => value != null && value.isEmpty ? 'Enter Name' : null,
  );

  Widget buildEmail() => TextFormField(
    controller: controllerEmail,
    decoration: InputDecoration(
      labelText: 'Email',
      border: OutlineInputBorder(),
    ),
    validator: (value) => value != null && !value.contains('@') ? 'Enter Email' : null,
  );

  Widget buildMobile() => TextFormField(
    controller: controllerMobile,
    decoration: InputDecoration(
      labelText: 'Mobile number',
      border: OutlineInputBorder(),
    ),
    validator: (value) => value != null && value.isEmpty ? 'Enter Mobile number' : null,
  );

  Widget buildIntern() => SwitchListTile(
    contentPadding: EdgeInsets.zero,
    controlAffinity: ListTileControlAffinity.leading,
    value: isIntern,
    title: Text("Is intern?"),
    onChanged: (value) {
      setState(() {
        this.isIntern = value;
      });
    },
  );

  Widget buildSubmit() => ButtonWidget(text: 'Save');

  Widget ButtonWidget({text, onClicked}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
        shape: StadiumBorder(),
      ),
      child: FittedBox(
        child: Text(text, style: TextStyle(
            fontSize: 20, color: Colors.white
        ),),
      ),
      onPressed: () async {
        // single entry
        // final maxsopian = Maxsopian(id: 1, name: "Jayanta Biswas", email: "jayanta@maxsop.com", mobile: "+8801775219457", isIntern: false);
        // await MaxsopianSheetApi.insert([maxsopian.toJson()]);

        // multiple entry
        // insertMaxsopians();

        // form data
        final form = formKey.currentState!;
        final isValid = form.validate();

        if(isValid) {
          final maxsopian = Maxsopian(
              name: controllerName.text,
              email: controllerEmail.text,
              mobile: controllerMobile.text,
              isIntern: isIntern
          );

          // form data
          final id = await MaxsopianSheetApi.getRowCount() + 1;
          final newMaxsopian = maxsopian.copy(id: id);

          await MaxsopianSheetApi.insert([newMaxsopian.toJson()]);
        }

      },
    );
  }

  Future insertMaxsopians() async {
    final maxsopians = [
      Maxsopian(id: 1, name: "Jayanta Biswas", email: "jayanta@maxsop.com", mobile: "+8801775219457", isIntern: false),
      Maxsopian(id: 2, name: "Sir", email: "ikram@maxsop.com", mobile: "+8801775219458", isIntern: false),
      Maxsopian(id: 3, name: "Araf", email: "araf@maxsop.com", mobile: "+8801775219459", isIntern: false),
      Maxsopian(id: 4, name: "Maruf Hasan", email: "maruf@maxsop.com", mobile: "+8801775219460", isIntern: false),
      Maxsopian(id: 5, name: "Anando", email: "anando@maxsop.com", mobile: "+8801775219461", isIntern: true),
      Maxsopian(id: 5, name: "Iqbal", email: "iqbal@maxsop.com", mobile: "+8801775219462", isIntern: true),
    ];
    final jsonMaxsopian = maxsopians.map((maxsopian) => maxsopian.toJson()).toList();

    await MaxsopianSheetApi.insert(jsonMaxsopian);
  }
}

