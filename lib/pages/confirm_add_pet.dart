import 'package:adoptapet_app/adoptapet_package.dart';

class ConfirmAddPet extends StatelessWidget {
  const ConfirmAddPet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset('assets/images/svg/confirm-add-pet.svg',
                    height: 300),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Wrap(
                    children: [
                      Text(
                        'Has registrado tu mascota correctamente',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'home');
                  },
                  child: const Text('Continuar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
