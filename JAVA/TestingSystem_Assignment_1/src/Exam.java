import java.time.LocalDate;
public class Exam {
	int ExamID;
    String Code;
    String Title;
    CategoryQuestion categoryQuestion;
    int Duration;
    Account CreatorID ;
    Account account;
    LocalDate CreateDate;
    Question[] questions;
	public Exam(int examID, String code, String title, CategoryQuestion categoryQuestion, int duration,
			Account creatorID, Account account, LocalDate createDate, Question[] questions) {
		super();
		ExamID = examID;
		Code = code;
		Title = title;
		this.categoryQuestion = categoryQuestion;
		Duration = duration;
		CreatorID = creatorID;
		this.account = account;
		CreateDate = createDate;
		this.questions = questions;
	}
    
    
}
