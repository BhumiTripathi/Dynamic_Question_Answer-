
A dynamic feedback form, where one can add the questions, and give the answers.

1. QuestionsVC - Contains the questions that are added inside the quitionaire json file.
2. DetailVC - One can select the answer or write the answer as per the type of question.
3. AddQuestionVC - where one can add the their own question.

Model Class:

Questions- 
id - a unique number or the primary key
type - type of the question, it defines the view that will be going to show on that particular question.
question- the question that is displayed or added.
arrOption- this option is for the radio and checkbox type, where one can is going to select the answers from the options
arrAnswers- it contains the answers for the radio and checkbox types.
Answer - other than radioa nd checkbox, the answers are going to store here.

Answers
id - a primary key to distinguish between the answers.
value - display content.

