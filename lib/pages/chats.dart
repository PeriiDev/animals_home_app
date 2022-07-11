import 'package:adoptapet_app/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:adoptapet_app/adoptapet_package.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'chat'),
                child: _CustomChat()),
            const SizedBox(
              height: 10,
            ),
            _CustomChat(),
            const SizedBox(
              height: 10,
            ),
            _CustomChat(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: ButtonNavigationBarProfessionalCustom(),
    );
  }
}

class _CustomChat extends StatelessWidget {
  const _CustomChat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(1, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CustomContainer(
                width: 80,
                height: 80,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image(
                      image: NetworkImage(
                          'https://www.dogingtonpost.com/wp-content/uploads/2018/03/dogscaping-main-1000x600.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: CustomContainer(
              //backgroundColor: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'NOMBRE DE LA PERSONA',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Ultimo mensaje enviado',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
