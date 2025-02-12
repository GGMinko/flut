import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/shopping_list_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shoppingListViewModel = Provider.of<ShoppingListViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    // Проверяем, авторизован ли пользователь
    final user = authViewModel.currentUser;

    if (user != null) {
      // Если пользователь уже авторизован, перенаправляем на экран со списком покупок
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/shopping');
      });
      return Center(child: Text('Redirecting to your shopping lists...'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Переход на экран авторизации'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Task manager',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Текущий cписок задач по категориям',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: shoppingListViewModel.shoppingLists.length,
                itemBuilder: (context, index) {
                  final shoppingList =
                      shoppingListViewModel.shoppingLists[index];
                  return ListTile(
                    title: Text(shoppingList.title),
                    subtitle: Text(shoppingList.description),
                    trailing: Icon(
                      shoppingList.isFavorite ? Icons.star : Icons.star_border,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Авторизуйся для обновления списка',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Авторизоваться'),
            ),
          ],
        ),
      ),
    );
  }
}
