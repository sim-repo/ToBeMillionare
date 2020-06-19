//
//  GameSessionPresentor.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 19.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

final class GameSessionService {
    
    internal var gameSessionModel: GameSessionModel!
    
    
    init(profile: ReadableProfile) {
        gameSessionModel = GameSessionModel()
        
        let questions = RealmService.loadQuestions(profile.getGameMode(), profile.getUsePassedQuestions())
        setQuestions(questions)
    }
}


//MARK:- functions using static data
extension GameSessionService {
    
    public func setQuestions(_ questions: [QuestionModel]) {
        gameSessionModel.setQuestions(questions)
    }
    
    func getQuestion(curLevel: LevelEnum) -> ReadableQuestion {
        let questions = gameSessionModel.getQuestions().filter{$0.levelEnum.rawValue == curLevel.rawValue}
        let rand = Int.random(in: 0...questions.count-1)
        return questions[rand]
    }
    
    
    func getRightAnswerId(questionId: Int) -> String {
        let question = gameSessionModel.getQuestions().first(where: {$0.id == questionId})!
        let rightAnswerId = question.answers.first(where: { $0.getIsTrue() == true })!
        return rightAnswerId.getAnswerId()
    }
    
    
    func getAnswers(questionId: Int) -> [ReadableAnswer] {
        let question = gameSessionModel.getQuestions().first(where: {$0.id == questionId})!
        return question.getAnswers()
    }
    
    
    func getFriendAnswer(questionId: Int, occupationEnum: OccupationEnum) -> ReadableAnswer {
        let question = gameSessionModel.getQuestions().first(where: {$0.id == questionId})!
        
        if question.occupationEnum == occupationEnum {
            let trueAnswer = question.getAnswers().first(where: {$0.getIsTrue() == true })
            return trueAnswer!
        } else {
            let answers = question.getAnswers()
            let rand = Int.random(in: 0...answers.count-1)
            return answers[rand]
        }
    }
}


//MARK:- user activity

extension GameSessionService {
    
    public func setLevel(levelEnum: LevelEnum) {
        gameSessionModel.setLevel(levelEnum: levelEnum)
    }
    
    public func setUsedFriendHint(enabled: Bool) {
        gameSessionModel.setUsedFriendHint(enabled: enabled)
    }
    
    public func setUsedAuditoryHint(enabled: Bool) {
        gameSessionModel.setUsedAuditoryHint(enabled: enabled)
    }
    
    public func setUsedFiftyHint(enabled: Bool) {
        gameSessionModel.setUsedFiftyHint(enabled: enabled)
    }
}
