part of carp_study_app;

class AudioTaskHeader extends StatelessWidget {
  final int currentStep;
  final List<int> steps;

  AudioTaskHeader(this.currentStep, this.steps);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.help_outline, color: Theme.of(context).primaryColor, size: 30),
          tooltip: 'Close',
          onPressed: () {
            print("close");
          },
        ),
        //Carousel
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: this.steps.asMap().entries.map(
              (step) {
                var index = step.value;
                return Container(
                  width: 7.0,
                  height: 7.0,
                  margin: EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index <= this.currentStep
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor.withOpacity(0.5)),
                );
              },
            ).toList(),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close, color: Theme.of(context).primaryColor, size: 30),
          tooltip: 'Close',
          onPressed: () {
            print("close");
          },
        ),
      ],
    );
  }
}
