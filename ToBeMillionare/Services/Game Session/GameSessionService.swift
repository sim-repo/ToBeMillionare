//
//  GameSessionPresentor.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 19.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

final class GameSessionService {

    internal var historyService: HistoryService!
    
    private var accumulatedResponseTime: Int = 0
    private var curQuestionId: Int = 0
    private var questions: [QuestionModel] = []
    private var curRoundEnum: RoundEnum = .round1
    private var passedRoundEnum: RoundEnum = .none
    private var usedFriendHint: Bool = false
    private var usedAuditoryHint: Bool = false
    private var usedFiftyHint: Bool = false
    private var betPercentOfDepo: Double = 0
    private var betAward: Double = 0
    
    private let initialDepo: Double = 100
    
    
    private var renewedFireproofRound: RoundEnum = .none  // #0001
    
    
    internal var achievementService: AchievementService {  // #0003
        return ProfileService.achievementService
    }
    
    internal var profile: ReadableProfile {
        return ProfileService.getForcedSelected()
    }
    
    public func setup() {
        historyService = HistoryService()
        historyService.createHistory(gameModeEnum: profile.getGameMode(), playerId: profile.getId())
        
        let questions = RealmService.loadQuestions(profile.getGameMode())
        setQuestions(questions)
    }
}


//MARK:- functions using static data
extension GameSessionService {
    
    private func isIncluding(_ curRound: RoundEnum, _ minRoundEnum: RoundEnum, _ maxRoundEnum: RoundEnum) -> Bool {
        let curRoundInt = curRound.rawValue
        return
            minRoundEnum.rawValue...maxRoundEnum.rawValue ~= curRoundInt
    }
    
    
    public func setQuestions(_ questions: [QuestionModel]) {
        self.questions = questions
    }
    
    
    public func getQuestion(curRound: RoundEnum) -> ReadableQuestion {
        
        let questionsPerRound = questions
            .filter{ isIncluding(curRound, $0.minRoundEnum,  $0.maxRoundEnum) }
        
        if let passedIds = historyService.getPassedQuestionIds(gameModeEnum: profile.getGameMode(), playerId: profile.getId(), orderBy: .asc) {
            
            var set1 = Set<Int>()
            for id in passedIds {
                if let passedQuestion = questionsPerRound.first(where: { $0.id == id }) {
                    if isIncluding(curRound, passedQuestion.getMinRoundEnum(), passedQuestion.getMaxRoundEnum()) {
                        set1.insert(id)
                    }
                }
            }
            
            var set2 = Set<Int>()
            for q in questionsPerRound {
                set2.insert(q.id)
            }
            
            let diff = set2.subtracting(set1)
            if diff.capacity > 0,
                let id = diff.first {
                curQuestionId = id
                return questionsPerRound.first(where: {$0.id == id})!
            }
            
            let count = passedIds.count
            var num = Int(Double(count) * 0.3)
            num = num == 0 ? 1 : num
            let idx = Int.random(in: 0...num - 1)
            let id = passedIds[idx]
            curQuestionId = id
            return questionsPerRound.first(where: {$0.id == id})!
        }
        let id = Int.random(in: 0...questionsPerRound.count-1)
        curQuestionId = id
        return questionsPerRound[id]
    }
    
    
    public func getRightAnswerId(questionId: Int) -> String {
        let question = questions.first(where: {$0.id == questionId})!
        let rightAnswerId = question.answers.first(where: { $0.getIsTrue() == true })!
        return rightAnswerId.getAnswerId()
    }
    
    
    public func getAnswers(questionId: Int) -> [ReadableAnswer] {
        let question = questions.first(where: {$0.id == questionId})!
        return question.getAnswers()
    }
}



extension GameSessionService {
    
    public func setFinishSession() {
        calcAndSaveDepo()
        historyService.saveHistory(gameModeEnum: profile.getGameMode(), playerId: profile.getId())
    }
    
    public func isNextStage() -> Bool {
        //outcomment for test only:
        //setNextStage()
        //return true
        if getDepo() >= getStageAim() {
            setNextStage()
            return true
        }
        return false
    }
    
    public func metricSaveToCache(spentTime: Int) {
        self.accumulatedResponseTime += spentTime
        historyService.setRound(roundEnum: getRound())
        historyService.setAccumulatedResponseTime(time: accumulatedResponseTime)
        historyService.setPassedQuestion(questionId: curQuestionId)
    }
    
    public func isWinGame() -> Bool {
        let nextIdx = curRoundEnum.rawValue + 1
        return nextIdx >= RoundEnum.allCases.count - 1
    }
    
    public func setNextRound() {
        let nextIdx = curRoundEnum.rawValue + 1
        let round = RoundEnum.allCases[nextIdx-1]
        curRoundEnum = round
    }
    
    public func didPassRound() {
        passedRoundEnum = curRoundEnum
    }
    
    public func getRound() -> RoundEnum {
        return curRoundEnum
    }
    
    public func getPassedRound() -> RoundEnum {
        return passedRoundEnum
    }
}

//MARK:- Achievements
// #0003
extension GameSessionService {

    public func calcSpeed() -> AchievementEnum? {
        return ProfileService.achievementService.calcSpeed()
    }
    
    
    public func calcDegree() -> AchievementEnum? {
        return achievementService.calcDegree()
    }
    
    
    public func calcRetension() -> AchievementEnum? {
        return achievementService.calcRetension()
    }
}


//MARK:- Hints
extension GameSessionService {
    
    public func isUsedFriendHint() -> Bool {
        return usedFriendHint
    }
    
    public func isUsedFiftyHint() -> Bool {
        return usedFiftyHint
    }
    
    public func getFiftyHintWrongIds() -> [String] {
        usedFiftyHint = true
        let question = questions.first(where: {$0.id == curQuestionId})!
        let wrongFirst = question.answers.first(where: { $0.getIsTrue() == false })!
        let wrongSecond = question.answers.last(where: { $0.getIsTrue() == false })!
        return [wrongFirst.getAnswerId(), wrongSecond.getAnswerId()]
    }
    
    
    public func getFriendAnswer(occupationEnum: OccupationEnum) -> ReadableAnswer {
        usedFriendHint = true
        let question = questions.first(where: {$0.id == curQuestionId})!
        
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
        return usedAuditoryHint
    }
    
    
    public func getAuditoryHint() -> [Double] {
        
        usedAuditoryHint = true
        let question = questions.first(where: {$0.id == curQuestionId})!
        let trueAnswer = question.getAnswers().first(where: {$0.getIsTrue() == true })
        
        let distribution: Int = Int.random(in: 0...4)
        var percentOfTrue: Int = 0
        var percentOfWrong1: Int = 0
        switch distribution {
        case 0:
            percentOfTrue = 40
            percentOfWrong1 = 30
        case 1:
            percentOfTrue = 35
            percentOfWrong1 = 30
        case 2:
            percentOfTrue = 40
            percentOfWrong1 = 25
        case 3:
            percentOfTrue = 45
            percentOfWrong1 = 32
        case 4:
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
}




//MARK:- Award + Bet
extension GameSessionService {
    
    public func getStageAim() -> Double {
        return 1000
    }
    
    
    public func getDepo() -> Double {
        return ProfileService.getSelected()?.getDepo() ?? 0
    }
    
    
    
    public func setBetPercentOfDepo(betPercentOfDepo: Double) {
        self.betPercentOfDepo = betPercentOfDepo
        historyService.setBetPercentOfDepo(percent: betPercentOfDepo)
    }
    
    
    
    public func getBetSum() -> Double {
        guard let newDepo = ProfileService.getSelected()?.getDepo() else { return 0 }
        let betSum = newDepo * Double(betPercentOfDepo) / 100
        let rounded = betSum.rounded(.toNearestOrEven)
        return rounded
    }
    
    
    private func calcAndSaveDepo() {
        let fireproofRound = getFireproofRound().rawValue
        let passedRound = passedRoundEnum.rawValue
        if passedRound < fireproofRound {
            betAward = -1*getBetSum()
            setDepo(betSum: betAward)
            historyService.setBetResult(sum: -1*getBetSum())
        } else {
            betAward = calcRoundAward(winRound: passedRound)
            setDepo(betSum: betAward)
            historyService.setBetResult(sum: betAward)
        }
    }
    
    
    
    private func setDepo(betSum: Double) {
        ProfileService.setDepo(amount: betSum)
    }
    
    
    public func getMinAward() -> Double {
        return getBetSum()*2
    }
    
    public func getBetMinSum() -> Double {
        return 10
    }
    
    public func canSelectBet() -> Bool {
        return getDepo() >= 20
    }
    
    private func calcRoundAward(winRound: Int) -> Double {
        
        if getDepo() <= getBetMinSum() {
            if 6...11 ~= winRound {
                return (getBetMinSum() * Double(winRound-5)).rounded(.toNearestOrEven)
            }
        }
        
        if 20...30 ~= betPercentOfDepo {
            if 7...11 ~= winRound {
                return (getBetSum() * Double(winRound-5)).rounded(.toNearestOrEven)
            }
        }
        
        if betPercentOfDepo == 10 || 40...50 ~= betPercentOfDepo {
            if 8...11 ~= winRound {
                return (getBetSum() * Double(winRound-6)).rounded(.toNearestOrEven)
            }
        }
        
        
        if 60...80 ~= betPercentOfDepo {
            if 10...11 ~= winRound {
                return (getBetSum() * Double(winRound-8)).rounded(.toNearestOrEven)
            }
        }
        
        
        if 90...100 ~= betPercentOfDepo {
            if 9...11 ~= winRound {
                return (getBetSum() * Double(winRound-7)).rounded(.toNearestOrEven)
            }
        }
        
        if winRound == 12 {
            return 500
        }
        
        if winRound == 13 {
            return 1000
        }
        return 0
    }
    
    
    public func getFireproofRound(cachedDepo: Double? = 0) -> RoundEnum {
        
        // #0001
        if renewedFireproofRound != .none {
            return renewedFireproofRound
        }
        
        if let cached = cachedDepo,
            cached != 0,
            cached <= getBetMinSum() {
            return .round6
        }
        if getDepo() <= getBetMinSum() {
            return .round6
        }
        
        switch betPercentOfDepo {
        case 10:
            return .round10
        case 20...30:
            return .round7
        case 40...50:
            return .round8
        case 60...80:
            return .round10
        case 90...100:
            return .round9
        default:
            return .round1
        }
    }
    
    
    public func getAward() -> Double {
        return betAward
    }
}


//MARK:- renew fireproof
// #0001
extension GameSessionService {

   public func renewFireproof() {
       let idx = curRoundEnum.rawValue
       let nextRound = RoundEnum.allCases[idx-1]
       renewedFireproofRound = nextRound
   }
   
   public func canRenewFireproof() -> Bool {
       let fireproofRound = getFireproofRound().rawValue
       let passedRound = passedRoundEnum.rawValue
       print("\(passedRound)  :   \(fireproofRound)")
       return passedRound >= fireproofRound
   }
   
   // #0002
   public func usedTipRenewFireproof() -> Bool {
       return profile.getUsedTipRenewFireproof()
   }
}


//MARK:- incoming events
extension GameSessionService {
    
    // #0003
    public func didShownAchievement(achievementEnum: AchievementEnum) {
        ProfileService.setAchievement(achievementEnum: achievementEnum)
    }
    
    // #0001, #0002
    public func didUsedTipRenewFireproof() {
        ProfileService.setUsedTipRenewFireproof()
    }
}


//MARK:- Zond
extension GameSessionService {
    public func getDaysBeforeDisaster() -> Int {
        return profile.getDaysBeforeDisaster()
    }
    
    public func getStage() -> Int {
        return profile.getStage()
    }
    
    private func setNextStage() {
        ProfileService.setNextStage(initialDepo: initialDepo)
    }
}


//MARK:- Сurrency
extension GameSessionService {
    public func getActualCurrency() -> CurrencyEnum {
        let stage = getStage()
        return CurrencyEnum.getCurrency(stage: stage)
    }
}


//MARK:- Game Analytics
extension GameSessionService {
    
    public func getGamesCount() -> Int {
        return ProfileService.getHistories()?.count ?? 0
    }
    
    public func getBetAnalysis() -> BetCharacterEnum{
        
        let histories = ProfileService.getHistories()
        let betPercents = histories?.map{$0.getBetPercentOfDepo()}
        guard let percents = betPercents else { return .unknow}
        
        var countByPercents: [Double:Double] = [:]
        
        for element in percents {
            if let percent = countByPercents[element] {
                countByPercents[element] = percent + 1
            } else {
                countByPercents[element] = 1
            }
        }
        
        let sum = countByPercents.map{$1}
            .reduce(0, { x, y in
                x + y
            })
        
        var d1: Double = 0
        var expectation:Double = 0 // математическое ожидание
        var PDict: [Double:Double] = [:] // вероятности
        for (key,val) in countByPercents { // ставка - key, вероятность - P, встречается val-раз ")
            let P = val/sum // вероятность
            PDict[key] = Double(P)
            expectation += Double(key)*P
            d1 += Double(key*key)*P
        }
        
        let dispersia = d1 - expectation * expectation // дисперсия
        
        if expectation >= 35 {
            return BetCharacterEnum.agressive
        }
        
        if dispersia <= 50 && 10...19 ~= expectation {
            return BetCharacterEnum.careful
        }
        
        if dispersia <= 60 && 20...33.5 ~= expectation {
            return BetCharacterEnum.medium
        }
        
        if dispersia >= 400 && 18...35 ~= expectation {
            return BetCharacterEnum.cheat
        }
        return .unknow
    }
}
