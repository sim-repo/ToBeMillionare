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
    internal var profile: ReadableProfile
    internal var curQuestionId: Int = 0
    
    internal var historyService: HistoryService!
    
    init(profile: ReadableProfile) {
        gameSessionModel = GameSessionModel()
        self.profile = profile
        
        historyService = HistoryService()
        historyService.createHistory(gameModeEnum: profile.getGameMode(), playerId: profile.getId())
        
        let questions = RealmService.loadQuestions(profile.getGameMode())
        setQuestions(questions)
    }
}


//MARK:- functions using static data
extension GameSessionService {
    
    private func isIncluding(curLevel: LevelEnum, minLevelEnum: LevelEnum, maxLevelEnum: LevelEnum) -> Bool {
        
        let curLevelInt = Int(curLevel.rawValue.replacingOccurrences(of: " ", with: ""))!
        
       // print(" \(curLevel) in [\(minLevelEnum)...\(maxLevelEnum)] - \(Int(minLevelEnum.rawValue.replacingOccurrences(of: " ", with: ""))!...Int(maxLevelEnum.rawValue.replacingOccurrences(of: " ", with: ""))! ~= curLevelInt)")
        return
            Int(minLevelEnum.rawValue.replacingOccurrences(of: " ", with: ""))!...Int(maxLevelEnum.rawValue.replacingOccurrences(of: " ", with: ""))! ~= curLevelInt
    }
    
    
    public func setQuestions(_ questions: [QuestionModel]) {
        gameSessionModel.setQuestions(questions)
    }
    
    
    public func getQuestion(curLevel: LevelEnum) -> ReadableQuestion {
        
        
        let questions = gameSessionModel.getQuestions()
            .filter{ isIncluding(curLevel: curLevel, minLevelEnum: $0.minLevelEnum, maxLevelEnum: $0.maxLevelEnum) }
        
        
        if let passedIds = historyService.getPassedQuestionIds(gameModeEnum: profile.getGameMode(), playerId: profile.getId(), orderBy: .asc) {
            
            var set1 = Set<Int>()
            for id in passedIds {
                if let passedQuestion = gameSessionModel.getQuestions().first(where: { $0.id == id }) {
                    if isIncluding(curLevel: curLevel, minLevelEnum: passedQuestion.getMinLevelEnum(), maxLevelEnum: passedQuestion.getMaxLevelEnum()) {
                        set1.insert(id)
                    }
                }
            }
            
            var set2 = Set<Int>()
            for q in questions {
                set2.insert(q.id)
            }
            
            let diff = set2.subtracting(set1)
            if diff.capacity > 0,
                let id = diff.first {
                curQuestionId = id
                return gameSessionModel.getQuestions().first(where: {$0.id == id})!
            }
            
            let count = passedIds.count
            var num = Int(Double(count) * 0.3)
            num = num == 0 ? 1 : num
            let idx = Int.random(in: 0...num - 1)
            let id = passedIds[idx]
            curQuestionId = id
            return gameSessionModel.getQuestions().first(where: {$0.id == id})!
        }
        let id = Int.random(in: 0...questions.count-1)
        curQuestionId = id
        return questions[id]
    }
    
    
    public func getRightAnswerId(questionId: Int) -> String {
        let question = gameSessionModel.getQuestions().first(where: {$0.id == questionId})!
        let rightAnswerId = question.answers.first(where: { $0.getIsTrue() == true })!
        return rightAnswerId.getAnswerId()
    }
    
    
    public func getAnswers(questionId: Int) -> [ReadableAnswer] {
        let question = gameSessionModel.getQuestions().first(where: {$0.id == questionId})!
        return question.getAnswers()
    }
    
}


//MARK:- user activity

extension GameSessionService {
    
    public func setFinishSession() {
        guard getLevel() != .level1 else { return }
        historyService.setLevel(levelEnum: getLevel(offset: -1))
        historyService.saveHistory(gameModeEnum: profile.getGameMode(), playerId: profile.getId())
    }
    
    
    public func setNextLevel() {
        if let idx = gameSessionModel.getLevel().index {
            let nextIdx = idx + 1
            let level = LevelEnum.allCases[nextIdx]
            gameSessionModel.setLevel(levelEnum: level)
            historyService.setPassedQuestion(questionId: curQuestionId)
        }
    }
    
    
    public func getLevel(offset: Int = 0) -> LevelEnum {
        if offset == 0 {
            return gameSessionModel.getLevel()
        }
        let idx = gameSessionModel.getLevel().index!
        let nextIdx = idx + offset
        guard nextIdx >= 0 else { return .level1 }
        let level = LevelEnum.allCases[nextIdx]
        return level
    }
    
    
    
    public func getAward() -> String {
        if let idx = getLevel().index {
            let prevIdx = idx - 1
            guard prevIdx >= 0 else { return "" }
            let passedLevel = LevelEnum.allCases[prevIdx]
            return LevelEnum.getAward(levelEnum: passedLevel)
        }
        return ""
    }
    
    // friend hit:
    public func isUsedFriendHint() -> Bool {
        return gameSessionModel.getUsedFriendHint()
    }
    
    
    public func getFriendAnswer(occupationEnum: OccupationEnum) -> ReadableAnswer {
        gameSessionModel.setUsedFriendHint(enabled: true)
        historyService.setUsedFriendHint(enabled: true)
        let question = gameSessionModel.getQuestions().first(where: {$0.id == curQuestionId})!
        
        if question.occupationEnum == occupationEnum {
            let trueAnswer = question.getAnswers().first(where: {$0.getIsTrue() == true })
            return trueAnswer!
        } else {
            let answers = question.getAnswers()
            let rand = Int.random(in: 0...answers.count-1)
            return answers[rand]
        }
    }
    
    // auditory hit:
    public func isUsedAuditoryHint() -> Bool {
        return gameSessionModel.getUsedAuditoryHint()
    }
    
    
    public func getAuditoryHint() -> [Double] {
        
        gameSessionModel.setUsedAuditoryHint(enabled: true)
        historyService.setUsedAuditoryHint(enabled: true)
        
        let question = gameSessionModel.getQuestions().first(where: {$0.id == curQuestionId})!
        let trueAnswer = question.getAnswers().first(where: {$0.getIsTrue() == true })
        
        let distribution: Int = Int.random(in: 0...2)
        var percentOfTrue: Int = 0
        var percentOfWrong1: Int = 0
        switch distribution {
        case 0:
            percentOfTrue = 30
            percentOfWrong1 = 30
        case 1:
            percentOfTrue = 40
            percentOfWrong1 = 30
        case 2:
            percentOfTrue = 50
            percentOfWrong1 = 20
        default:
            break
        }
        
        let percentOfWrong2 = Int.random(in: 0...100 - percentOfTrue - percentOfWrong1)
        let percentOfWrong3 = Int.random(in: 0...100 - percentOfTrue - percentOfWrong1 - percentOfWrong2 )
        
        let trueIdx = trueAnswer?.getAnswerId()
        
        var wrongs: [Int] = [percentOfWrong1, percentOfWrong2, percentOfWrong3]
        wrongs.shuffle()
        
        print(Double(percentOfTrue)/100)
        
        switch trueIdx {
        case "A":
            return [Double(percentOfTrue)/100, Double(wrongs[0])/100, Double(wrongs[1])/100, Double(wrongs[2])/100]
        case "B":
          return [Double(wrongs[0])/100, Double(percentOfTrue)/100, Double(wrongs[1])/100, Double(wrongs[2])/100]
        case "C":
          return [Double(wrongs[0])/100, Double(wrongs[1])/100, Double(percentOfTrue)/100, Double(wrongs[2])/100]
        case "D":
          return [Double(wrongs[0])/100, Double(wrongs[1])/100, Double(wrongs[2])/100, Double(percentOfTrue)/100]
        default:
            break
        }
        return [0,0,0,0]
    }
    
    
    // fifty hit:
    public func isUsedFiftyHint() -> Bool {
        return gameSessionModel.getUsedFiftyHint()
    }
    
    public func getFiftyHintWrongIds() -> [String] {
        gameSessionModel.setUsedFiftyHint(enabled: true)
        historyService.setUsedFiftyHint(enabled: true)
        let question = gameSessionModel.getQuestions().first(where: {$0.id == curQuestionId})!
        let wrongFirst = question.answers.first(where: { $0.getIsTrue() == false })!
        let wrongSecond = question.answers.last(where: { $0.getIsTrue() == false })!
        return [wrongFirst.getAnswerId(), wrongSecond.getAnswerId()]
    }
    
    
    
    
    public func setLevel(levelEnum: LevelEnum) {
        gameSessionModel.setLevel(levelEnum: levelEnum)
        historyService.setLevel(levelEnum: levelEnum)
    }

}
