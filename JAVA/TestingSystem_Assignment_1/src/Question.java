import java.time.LocalDate;
public class Question {
	int QuestionID;
    String Content;
    CategoryQuestion categoryQuestion;
    TypeQuestion typeQuestion;
    Account CreatorID ;
    Account account;
    LocalDate CreateDate;
    Exam [] exams;
    
	public Question(int questionID, String content, CategoryQuestion categoryQuestion, TypeQuestion typeQuestion,
			Account creatorID, Account account, LocalDate createDate, Exam[] exams) {
		super();
		QuestionID = questionID;
		Content = content;
		this.categoryQuestion = categoryQuestion;
		this.typeQuestion = typeQuestion;
		CreatorID = creatorID;
		this.account = account;
		CreateDate = createDate;
		this.exams = exams;
	}
    
}
