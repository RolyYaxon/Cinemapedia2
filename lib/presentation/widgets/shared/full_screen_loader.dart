import 'package:flutter/material.dart';

class FullScreenloader extends StatelessWidget {
  const FullScreenloader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      "¡Prepárate para una experiencia cinematográfica única! Asegúrate de ajustar el volumen y disfruta de la película en una habitación con poca luz para una inmersión total",
      "¿Sabías que esta película tardó meses en realizarse? ¡El esfuerzo y dedicación del equipo de producción se ven reflejados en cada escena!",
      "¿Listo para emocionarte? Respira hondo y prepárate para un viaje lleno de emociones, risas y lágrimas.",
      "Te invitamos a desconectarte del mundo exterior y sumergirte en esta historia. Silencia tu teléfono y déjate llevar por el poder del cine."
    ];
    return Stream.periodic(const Duration(seconds: 3), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Espere"),
        const SizedBox(
          height: 20,
        ),
        const CircularProgressIndicator(
          strokeWidth: 2,
        ),
        const SizedBox(height: 10),
        StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("cargando");
              return Text(snapshot.data!);
            })
      ]),
    );
  }
}
