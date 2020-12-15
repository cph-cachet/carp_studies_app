part of carp_study_app;

class TaskListPage extends StatelessWidget {
  final TaskListPageModel model;

  TaskListPage(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: Center(
        child: Icon(
          Icons.spellcheck,
          size: 100,
          color: CACHET.ORANGE,
        ),
        //child: CircularProgressIndicator(),
      ),
    );
  }
}
