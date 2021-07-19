
public class Answer {
	int AnswerID;
    String Content;
    Question question;
    Boolean isCorrect;
	public Answer(int answerID, String content, Question question, Boolean isCorrect) {
		super();
		AnswerID = answerID;
		Content = content;
		this.question = question;
		this.isCorrect = isCorrect;
	}
    
}
