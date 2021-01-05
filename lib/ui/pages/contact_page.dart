part of carp_study_app;

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: height * .08),
              Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Have any questions? \nPlease contact us',
                      style: welcomeMessageStyle),
                ),
              ),
              _entryField("Name", _nameController),
              _entryField("Email", _emailController),
              _entryField("Message", _messageController, maxLines: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('BACK')),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('SEND')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController controllerName,
      {bool isPassword = false, int maxLines = null}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5),
          TextField(
              keyboardType: TextInputType.multiline,
              maxLines: maxLines,
              controller: controllerName,
              obscureText: isPassword,
              decoration: InputDecoration(
                  hintText: title,
                  hintStyle: inputFieldStyle,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff3f3f4))),
                  fillColor: Color(0xfff3f3f4),
                  filled: false))
        ],
      ),
    );
  }
}
