import Foundation




func getEasyQuestions()->[QuestionModel] {
    
    var arr: [QuestionModel] = []
    
    for i in 0...12 {
        let level = LevelEnum.allCases[i]
        for j in 0...12 {
            let q = QuestionModel(id: j, levelEnum: level, question: "Which month of the year was named after Julius Caesar? \(j)" ,
                                 answers: [
                                   AnswerModel(questionId: j, answerId: "A", answerText: "June", isTrue: false),
                                   AnswerModel(questionId: j, answerId: "B", answerText: "October", isTrue: false),
                                   AnswerModel(questionId: j, answerId: "C", answerText: "August", isTrue: true),
                                   AnswerModel(questionId: j, answerId: "D", answerText: "July", isTrue: false)
                       ],
                                 gameModeEnum: .easy,
                                 occupationEnum: .historian
                                 )
            arr.append(q)
        }
    }
    return arr
}




func getProfiles() -> [ProfileModel] {
    return [
        ProfileModel(name: "New", fakeProfile: true, age: 15, ava: URL(string: "unknown-ava.png")!),
        ProfileModel(name: "Alex", fakeProfile: false, age: 15, ava: URL(string: "ava2.png")!),
        ProfileModel(name: "John", fakeProfile: false, age: 15, ava: URL(string: "ava3.png")!),
        ProfileModel(name: "Mary", fakeProfile: false, age: 15, ava: URL(string: "ava4.png")!),
        ProfileModel(name: "Roxy", fakeProfile: false, age: 15, ava: URL(string: "ava5.png")!),
        ProfileModel(name: "Mourice", fakeProfile: false, age: 15, ava: URL(string: "ava6.png")!)
    ]
}


func getTemplateProfile() -> TemplateProfileModel {
    return TemplateProfileModel(avaURLs: [URL(string: "ava2.png")!, URL(string: "ava3.png")!, URL(string: "ava4.png")!, URL(string: "ava5.png")!, URL(string: "ava6.png")!])
}
