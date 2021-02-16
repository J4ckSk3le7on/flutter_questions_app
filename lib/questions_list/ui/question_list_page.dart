import 'package:flutter/material.dart';
import 'package:questions_app/publish_question/ui/publish_question.dart';

import 'package:questions_app/global_widgets/custom_global_appBar.dart';
import 'package:questions_app/questions_list/model/questions_model.dart';
import 'package:questions_app/questions_list/provider/questions_list_provider.dart';
import 'package:questions_app/questions_list/ui/widgets/question_card.dart';

class QuestionsList extends StatefulWidget {
  @required final String categoryName;
  @required final String userEmail;

  QuestionsList({
    this.categoryName,
    this.userEmail
  });

  @override
  _QuestionsListState createState() => _QuestionsListState();
}

class _QuestionsListState extends State<QuestionsList> {

  List<Document> allQuestions = List();

  @override
  void initState() { 
    super.initState();
    QuestionsGetProvider().getQuestions(widget.categoryName).then((questionsFromServer) {
      setState(() {
        allQuestions = questionsFromServer;
      });
    });
  }

  @override
  void dispose() { 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      floatingActionButton: FloatingActionButton(
        onPressed:() {Navigator.push(context, 
          MaterialPageRoute(builder: (context) => PublishQuestion(
            userEmail: widget.userEmail,
          )
        ));},
        backgroundColor: Color(0xffFF7043),
        child: Icon(Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomGlobalAppBar(
          tittle: widget.categoryName.toUpperCase(),
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: Color(0xffFF7043),
        color: Colors.white,
        onRefresh: _refreshList,
        child: questionsBuilder()
      )
    );
  }

  Widget questionsBuilder() {
    if (allQuestions.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFF7043)),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: allQuestions.length,
        itemBuilder: (context, index) {
          return QuestionCard(
            questionCategory: widget.categoryName,
            questions: allQuestions,
            index: index,
            userEmail: widget.userEmail
          );
        },
      );
    }
  }

  Future<void> _refreshList() async {
    QuestionsGetProvider().getQuestions(widget.categoryName).then((questionsFromServer) {
      setState(() {
        allQuestions = questionsFromServer;
      });
    });
  }
}