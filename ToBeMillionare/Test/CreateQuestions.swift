import Foundation




func getEasyQuestions()->[QuestionModel] {
    
    var arr: [QuestionModel] = []
    for i in 0...12 {
        let level = LevelEnum.allCases[i]
        let q = QuestionModel(id: i, levelEnum: level, question: "Which month of the year was named after Julius Caesar? \(i)" ,
                             answers: [
                               AnswerModel(questionId: i, answerId: "A", answerText: "June", isTrue: false),
                               AnswerModel(questionId: i, answerId: "B", answerText: "October", isTrue: false),
                               AnswerModel(questionId: i, answerId: "C", answerText: "August", isTrue: true),
                               AnswerModel(questionId: i, answerId: "D", answerText: "July", isTrue: false)
                   ],
                             gameModeEnum: .easy,
                             occupationEnum: .historian
                             )
        arr.append(q)
    }
    return arr
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
