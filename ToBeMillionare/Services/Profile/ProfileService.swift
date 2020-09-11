//
//  ProfileService.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 19.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import Foundation

final class ProfileService {
    
    private static var selected: ProfileModel?
    private static var profiles: [ProfileModel] = []
    
    public static var achievementService: AchievementService!
    public static var bonusService: BonusService!
    
    public static func getProfiles() -> [ProfileModel] {
        
        if profiles.isEmpty == false {
            return profiles
        }
        guard let profiles = FilesManager.shared.loadProfiles()
        else {
            createTemplateProfile()
            return self.profiles
        }
        
        self.profiles = profiles
        return self.profiles
    }
    
    
    internal static func saveProfiles(profiles: [ProfileModel]) {
        FilesManager.shared.saveProfiles(profiles: profiles)
    }
    
    
    internal static func createTemplateProfile() {
        let profile = ProfileModel(id: 0, name: "Новый Пользователь", fakeProfile: true, age: 0, ava: URL(string: "unknown-ava")!)
        profiles.append(profile)
        saveProfiles(profiles: profiles)
    }
    
    
    public static func saveNewProfile(created: ProfileModel) {
        var id = 0
        if let profiles = FilesManager.shared.loadProfiles(),
            let lastProfile = profiles.sorted(by: {$0.getId() < $1.getId()}).last {
            id = lastProfile.getId() + 1
            self.profiles = profiles
        }
        created.setId(id: id)
        selected = created
        profiles.append(created)
        saveProfiles(profiles: profiles)
    }
    
    private static func updateProfile() {
        saveProfiles(profiles: profiles)
    }
    
    public static func setAchievement(achievementEnum: AchievementEnum) {
        selected?.setAchievement(achievementEnum: achievementEnum)
        saveProfiles(profiles: profiles)
    }
    
    public static func getSelected() -> ProfileModel? {
        return selected
    }
    
    public static func getForcedSelected() -> ProfileModel {
        return selected!
    }

    
    public static func getCurrencySymbol() -> String {
        let stage = selected!.getStage()
        let currencyEnum = CurrencyEnum.getCurrency(stage: stage)
        return CurrencyEnum.getCurrencySymbol(currencyEnum: currencyEnum)
    }
    
    public static func setSelected(row: Int) {
        selected = profiles[row]
        guard let sel = selected else { return }
        achievementService = AchievementService(histories: getHistories())
        bonusService = BonusService(playerId: sel.getId())
    }
    
    public static func getHistories() -> [ReadableHistory]? {
        return  HistoryService.getHistories(gameModeEnum: getForcedSelected().getGameMode(), playerId: getForcedSelected().getId())
    }
    
    public static func deselect() {
        selected = nil
    }
    
    public static func setDepo(amount: Double) {
        guard let selected = selected else { return }
        let depo = selected.getDepo()
        let newDepo = depo + amount
        selected.setDepo(depo: newDepo)
        updateProfile()
    }
    
    public static func setNextStage(initialDepo: Double) {
        selected?.setNextStage()
        selected?.setDepo(depo: initialDepo)
        updateProfile()
    }
    
    public static func setUsedTipRenewFireproof() {
        selected?.setUsedTipRenewFireproof()
        updateProfile()
    }
}
