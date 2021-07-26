// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:splashscreen/splashscreen.dart';
//import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

//COMEÇA AQUI (SPLASH SCREEN)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Splash Screen Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 5,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xffED213A),
            Color(0xff93291E)
          ],
        ),
        navigateAfterSeconds: MyRoutes2(),
        loaderColor: Colors.transparent,
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("imagens/computadorLogo.png"),
          ),
        ),
      ),
    ],
  );
}


//ACABA AQUI (SPLASH SCREEN)

//ROTAS
class MyRoutes2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),
      },
      // Criando uma função para operar com rotas nomeadas.
      // Usamos esta função para identificar o nome da
      // rota que tem push, e criar a rota para a
      // tela correta.
      onGenerateRoute: (settings) {
        // Se você der push passamos argumentos pela rota
        if (settings.name == PassArgumentsScreen.routeName) {


          // Em seguida, extraia os dados necessários dos
          // os argumentos e passar os dados para a
          // tela correta.
          // configuração da estilização da tela
          return MaterialPageRoute(
            builder: (context) {
              return PassArgumentsScreen(
              );
            },
          );
        }
        // O código suporta apenas
        // PassArgumentsScreen.routeName a partir de agora.
        // Outros valores precisam ser implementados se precisarmos

        assert(false, 'Precisa implemetar ${settings.name}');
        return null;
      },
      title: 'Navegação com argumentos',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text('Rotas Nomeadas'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.asset("imagens/codigo.jpg"),
            ),
            // ​​botão que navega para uma rota nomeada.
            // A rota nomeada extrai os argumentos
            // sozinha.
            ElevatedButton(
              onPressed: () {
                // O que acontece:
                // Quando o usuário toca no botão,
                // navega para uma rota nomeada e
                // fornece os argumentos como um opcional de
                // parâmetro.
                Navigator.pushNamed(
                  context,
                  ExtractArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Argumentos',
                    'Esta mensagem é extraída no método de construção. É a extração dos argumentos passados no método',
                  ),
                );
              },
              child: Text('Clique para enviar dados'),
            ),
            // O ​​botão que navega para uma rota nomeada.
            // Para esta rota, extraia os argumentos em
            // a função onGenerateRoute e envia
            // para a tela definida.
            Padding(padding: EdgeInsets.all(8)),
            ElevatedButton(
              onPressed: () {
                // Quando o usuário toca no botão,
                // navega para uma rota nomeada e
                // fornece os argumentos como um opcional de
                // parâmetro.
                Navigator.pushNamed(
                  context,
                  PassArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Recebendo do Route',
                    'Esta mensagem é extraída na função onGenerateRoute.',
                  ),
                );
              },
              child: Text('Navegue até uma rota que aceita argumentos'),
            ),
          ],
        ),
      ),
    );
  }
}

// Este ​​widget que extrai os argumentos necessários de
// o ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extrai os argumentos do ModalRoute atual
    // configura e e envia como ScreenArguments.
    final args = ModalRoute.of(context).settings.arguments as ScreenArguments;

    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                "imagens/flutterMen.png",
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker.",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(args.message,
                  style: TextStyle(
                      backgroundColor: Colors.black87,
                      color: Colors.white,
                      fontSize: 18
                  )),
            ),
          ],
        ),

      ),
    );
  }
}

// W​widget aceita os argumentos necessários por meio do
// construtor
class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';


  // Este widget aceita os argumentos como construtor de
  // parâmetros, porém não extrai os argumentos de
  // o ModalRoute.
  // ----------------------------------
  // Os argumentos são extraídos pela função onGenerateRoute
  // declarada no widget MaterialApp.


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text("ROTAS"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Image.asset(
                        "imagens/flutterOn.png",
                        width: 150,
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Image.asset(
                        "imagens/flutterOn.png",
                        width: 150,
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                )
            ),
            Text("TESTE DE ROTAS E SPLASH SCREEN",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: ElevatedButton(onPressed: () {},
                child: Text(
                  "NULL",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Podemos passar qualquer objeto para o parâmetro de argumentos.
// Neste exemplo, criamos uma classe que com título e uma
// mensagem
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

/*-----------------------------------aaaqqui--------*/
// class MyHomePage extends StatefulWidget {
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return _introScreen();
//   }
// }
//
// Widget _introScreen() {
//   return Stack(
//     children: <Widget>[
//       SplashScreen(
//         seconds: 5,
//         gradientBackground: LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             Color(0xffED213A),
//             Color(0xff93291E)
//           ],
//         ),
//         navigateAfterSeconds: HomeScreen(),
//         loaderColor: Colors.transparent,
//       ),
//       Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("imagem/logo.png"),
//             fit: BoxFit.none,
//           ),
//         ),
//       ),
//     ],
//   );
// }