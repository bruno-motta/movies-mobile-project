#  Projeto Flutter - Movies

Aplicação mobile desenvolvida em **Flutter + Dart**, utilizando **SQLite** como banco de dados local e arquitetura **MVVM (Model - View - ViewModel)**.  
O objetivo do projeto é permitir o cadastro, edição, visualização e exclusão de filmes, além da exibição detalhada e avaliação por estrelas.

---

##  **Participantes do Projeto**
- **Wanderson Bruno**
- **Ian Quaresma**
- **José Vitor**

---

##  **Funcionalidades**
✔ Listagem de filmes  
✔ Busca de filmes pelo título  
✔ Cadastro de novos filmes  
✔ Edição de filmes existentes   
✔ Tela de detalhes com avaliação por estrelas  
✔ Armazenamento local utilizando SQLite     

---

##  **Arquitetura**
A arquitetura utilizada segue o padrão **MVVM**, distribuída da seguinte forma:

### **Model**
- Representa o objeto `Movie`
- Define atributos como título, gênero, descrição, avaliação, ano e duração

### **View**
- Telas da aplicação:
  - `movie_list_screen.dart`
  - `movie_form_screen.dart`
  - `movie_detail_screen.dart`
- Widgets reutilizáveis:
  - `movie_item_widget.dart`

### **ViewModel**
- `movie_viewmodel.dart`
- Responsável por:
  - carregar filmes
  - adicionar
  - atualizar
  - deletar
  - buscar
  - notificar mudanças na UI (`notifyListeners()`)

### **Repository**
- `movie_repository.dart`
- Camada intermediária entre ViewModel e DBHelper  
- Centraliza operações de banco

### **Database**
- `db_helper.dart`
- Cria banco SQLite
- Executa CRUD via SQL
- Armazena todos os filmes localmente

---


Projeto completo utilizando:

•Flutter

•SQLite

•Provider

•MVVM

•Validação de formulários

•Telas organizadas

•Widgets reutilizáveis




