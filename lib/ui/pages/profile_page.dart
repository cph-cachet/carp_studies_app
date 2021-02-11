part of carp_study_app;

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      IconButton(
                          icon:
                              Icon(Icons.keyboard_backspace, color: Theme.of(context).primaryColor, size: 30),
                          tooltip: 'Back',
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      SizedBox(width: 2),
                      Text('MY PROFILE',
                          style: sectionTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
