import 'package:flutter/material.dart';
import 'package:sera_que_chove/controllers/cidade_controller.dart';
import 'package:sera_que_chove/models/cidade.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sera_que_chove/services/cidade_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  late List<Cidade> cidades;
  late bool carregandoCidades;

  @override
  void initState() {
    super.initState();
    carregarCidades();
    this.carregandoCidades = false;
  }

  void carregarCidades() async {
    CidadeService service = CidadeService();
    cidades = await service.recuperarCidades();
  }

  Iterable<Cidade> filtrarCidades(String consulta) {
    return this.cidades.where(
        (cidade) => cidade.nome.toLowerCase().contains(consulta.toLowerCase()));
  }

  @override
  Widget build(BuildContext context) {
    bool algumaCidadeEscolhida =
        CidadeController.instancia.cidadeEscolhida != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(algumaCidadeEscolhida
            ?  AppLocalizations.of(context)!.app_home
            : AppLocalizations.of(context)!.app_home),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 60, 16, 0),
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.7,
            image: AssetImage(
              'images/telaconfiguracoes.gif',
            ), // Substitua 'background_image.png' pelo caminho da sua imagem de fundo.
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Text(
              "Sera Que Chove?", // Texto adicionado
              style: TextStyle(
                fontSize: 100,
                //fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 100),
            TypeAheadField<Cidade>(
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: AppLocalizations.of(context)!.msgBusca,
                ),
              ),
              suggestionsCallback: filtrarCidades,
              onSuggestionSelected: (sugestao) async {
                CidadeService service = CidadeService();
                final String filtro = sugestao.nome + ' ' + sugestao.estado;
                service
                    .pesquisarCidade(filtro)
                    .then((resultado) => Navigator.pushNamed(context, '/home'));
                setState(() {
                  this.carregandoCidades = true;
                });
              },
              itemBuilder: (context, sugestao) {
                return ListTile(
                  leading: Icon(Icons.place),
                  title: Text(sugestao.nome + " - " + sugestao.siglaEstado),
                  subtitle: Text(sugestao.estado),
                );
              },
              noItemsFoundBuilder: (context) => Container(
                child: Center(
                  child: Text(
                    'Nenhuma cidade encontrada',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            this.carregandoCidades
                ? Column(
                    children: [
                      Padding(padding: EdgeInsets.all(20)),
                      Image(
                        image: AssetImage('images/loading.gif'),
                        width: 200,
                      )
                    ],
                  )
                : Text('')
          ],
        ),
      ),
    );
  }
}
