import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/components/buttons/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/controllers/feira_controller.dart';
import 'package:ecommerceassim/shared/core/models/feira_model.dart';

class FeirasScreen extends StatelessWidget {
  const FeirasScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ??
            {};
    final int cidadeId = arguments['id'] as int;
    final String cidadeNome = arguments['nome'] as String? ?? 'Cidade';

    final feiraController =
        Provider.of<FeiraController>(context, listen: false);
    feiraController.loadFeirasByCidadeId(cidadeId);

    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Feiras em $cidadeNome',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const CustomSearchField(
            fillColor: kOnBackgroundColorText,
            iconColor: kDetailColor,
            hintText: 'Buscar por feiras',
            padding: EdgeInsets.all(5),
          ),
          Expanded(
            child: Consumer<FeiraController>(
              builder: (context, feiraController, child) {
                if (feiraController.isLoading) {
                  // Se ainda estiver carregando, exiba o indicador de progresso
                  return Center(
                    child: CircularProgressIndicator(color: kDetailColor),
                  );
                } else {
                  // Se o carregamento estiver completo, exiba a lista de feiras
                  List<FeiraModel> feiras = feiraController.feiras;

                  return ListView.builder(
                    itemCount: feiras.length,
                    itemBuilder: (context, index) {
                      FeiraModel feira = feiras[index];

                      return Container(
                        margin: const EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Screens.bancas,
                                  arguments: {
                                    'id': feira.id,
                                    'nome': feira.nome,
                                    'bairro': feira.bairroId,
                                    'horarios': feira.horariosFuncionamento,
                                  });
                            },
                            borderRadius: BorderRadius.circular(15.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 25.0,
                                    backgroundImage: AssetImage(
                                      "lib/assets/images/banca-fruta.jpg",
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: Text(
                                      feira.nome,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: kTextColorBlack,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
