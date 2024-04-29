part of carp_study_app;

class CarpAppBar extends StatelessWidget {
  const CarpAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/carp_logo.png',
                      fit: BoxFit.contain,
                      height: 16,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
