import 'package:flutter/material.dart';
import 'package:shopping_app/models/help_question_model.dart';
import 'package:shopping_app/utils/show_bottom_sheet.dart';
import 'package:shopping_app/widgets/cards/app_list_tile.dart';
import 'package:shopping_app/widgets/page_app_bar.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  /// Question List
  List<HelpQuestionModel> _questions = [];

  @override
  void initState() {
    // initialize questions
    _questions = QuestionBank.questions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: "Help"),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _questions.length,
          itemBuilder: (context, index) => AppListTile(
            margin: 12,
            padding: 12,
            text: _questions.elementAt(index).question,
            onTap: () => showAppBottomSheet(
              context: context,
              widget: QuestionDetail(
                questionModel: _questions.elementAt(index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Help Question detail content
class QuestionDetail extends StatelessWidget {
  final HelpQuestionModel questionModel;

  const QuestionDetail({
    required this.questionModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questionModel.question,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 10),
          Text(
            questionModel.answer,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
