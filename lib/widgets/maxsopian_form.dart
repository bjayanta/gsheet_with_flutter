import 'package:flutter/material.dart';
import 'package:maxsopian/model/maxsopian.dart';
import 'package:maxsopian/widgets/submit_button.dart';

class MaxsopianForm extends StatefulWidget {
  final String text;
  final Maxsopian? user;
  final ValueChanged<Maxsopian> onSavedMaxsopian;

  const MaxsopianForm({
    Key? key,
    required this.text,
    required this.user,
    required this.onSavedMaxsopian
  }) : super(key: key);

  @override
  _MaxsopianFormState createState() => _MaxsopianFormState();
}

class _MaxsopianFormState extends State<MaxsopianForm> {
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

  @override
  void didUpdateWidget(covariant MaxsopianForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    // update form data
    initMaxsopian();
  }

  void initMaxsopian() {
    final name = widget.user == null ? '' : widget.user!.name;
    final email = widget.user == null ? '' : widget.user!.email;
    final mobile = widget.user == null ? '' : widget.user!.mobile;
    final isIntern = widget.user == null ? true : widget.user!.isIntern;

    setState(() {
      controllerName = TextEditingController(text: name);
      controllerEmail = TextEditingController(text: email);
      controllerMobile = TextEditingController(text: mobile);
      this.isIntern = isIntern;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              SubmitButton(
                  text: widget.text,
                  onClicked: () async {
                    // form data
                    final form = formKey.currentState!;
                    final isValid = form.validate();

                    if(isValid) {
                      final id = widget.user == null ? null : widget.user!.id;
                      final maxsopian = Maxsopian(
                          id: id,
                          name: controllerName.text,
                          email: controllerEmail.text,
                          mobile: controllerMobile.text,
                          isIntern: isIntern
                      );

                      widget.onSavedMaxsopian(maxsopian);
                    }
              }),
            ],
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
}