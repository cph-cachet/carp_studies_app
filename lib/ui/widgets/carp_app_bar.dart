part of '../../main.dart';

class CarpAppBar extends StatelessWidget {
  const CarpAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: Image.asset(
                      'assets/carp_logo.png',
                      fit: BoxFit.contain,
                      height: 16,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.account_circle_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                    tooltip: 'Profile',
                    onPressed: () {
                      context.push('/profile');
                    },
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
