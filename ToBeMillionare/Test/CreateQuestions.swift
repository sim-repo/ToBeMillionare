import Foundation



func getEasyQuestions()->[QuestionModel] {
    
    return [
        QuestionModel(id: 0, levelEnum: .level1, question: "Which month of the year was named after Julius Caesar?",
                      answers: [
                        AnswerModel(questionId: 0, answerId: "A", answerText: "June", isTrue: false),
                        AnswerModel(questionId: 0, answerId: "B", answerText: "October", isTrue: false),
                        AnswerModel(questionId: 0, answerId: "C", answerText: "August", isTrue: true),
                        AnswerModel(questionId: 0, answerId: "D", answerText: "July", isTrue: false)
            ],
                      gameModeEnum: .easy,
                      occupationEnum: .historian
                      ),
        
        QuestionModel(id: 1, levelEnum: .level2, question: "Which month of the year was named after Julius Caesar? 2",
                      answers: [
                        AnswerModel(questionId: 0, answerId: "A", answerText: "June", isTrue: false),
                        AnswerModel(questionId: 0, answerId: "B", answerText: "October", isTrue: false),
                        AnswerModel(questionId: 0, answerId: "C", answerText: "August", isTrue: true),
                        AnswerModel(questionId: 0, answerId: "D", answerText: "July", isTrue: false)
            ],
                      gameModeEnum: .easy,
                    occupationEnum: .historian
            ),
        
        
        QuestionModel(id: 2, levelEnum: .level3, question: "Which month of the year was named after Julius Caesar? 3",
                      answers: [
                        AnswerModel(questionId: 0, answerId: "A", answerText: "June", isTrue: false),
                        AnswerModel(questionId: 0, answerId: "B", answerText: "October", isTrue: false),
                        AnswerModel(questionId: 0, answerId: "C", answerText: "August", isTrue: true),
                        AnswerModel(questionId: 0, answerId: "D", answerText: "July", isTrue: false)
            ],
                      gameModeEnum: .easy,
                      occupationEnum: .historian
                      ),
        
        QuestionModel(id: 3, levelEnum: .level4, question: "Which month of the year was named after Julius Caesar? 4",
                      answers: [
                        AnswerModel(questionId: 0, answerId: "A", answerText: "June", isTrue: false),
                        AnswerModel(questionId: 0, answerId: "B", answerText: "October", isTrue: false),
                        AnswerModel(questionId: 0, answerId: "C", answerText: "August", isTrue: true),
                        AnswerModel(questionId: 0, answerId: "D", answerText: "July", isTrue: false)
            ],
                      gameModeEnum: .easy,
                      occupationEnum: .historian
                      ),
    ]
}


func getProfiles() -> [ProfileModel] {
    return [
        ProfileModel(id: 0, name: "New", fakeProfile: true, age: 15, ava: URL(string: "unknown-ava.png")!),
        ProfileModel(id: 1, name: "Alex", fakeProfile: false, age: 15, ava: URL(string: "ava2.png")!),
        ProfileModel(id: 2, name: "John", fakeProfile: false, age: 15, ava: URL(string: "ava3.png")!),
        ProfileModel(id: 3, name: "Mary", fakeProfile: false, age: 15, ava: URL(string: "ava4.png")!),
        ProfileModel(id: 4, name: "Roxy", fakeProfile: false, age: 15, ava: URL(string: "ava5.png")!),
        ProfileModel(id: 5, name: "Mourice", fakeProfile: false, age: 15, ava: URL(string: "ava6.png")!)
    ]
}

func getTemplateProfile() -> TemplateProfileModel {
    return TemplateProfileModel(avaURLs: [URL(string: "ava2.png")!, URL(string: "ava3.png")!, URL(string: "ava4.png")!, URL(string: "ava5.png")!, URL(string: "ava6.png")!])
}
