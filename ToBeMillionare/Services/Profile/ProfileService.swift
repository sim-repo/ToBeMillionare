//
//  ProfileService.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 19.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//


import Foundation

final class ProfileService {
    
    public static func loadProfiles() -> [ProfileModel] {
        let profiles = RealmService.loadProfiles()
        return profiles
    }
    
    
    public static func saveProfile(profile: ProfileModel) {
        RealmService.saveProfile(profile)
    }
    
    
    public static func createProfile(created: ProfileModel) {
        var id = 0
        let profiles = RealmService.loadProfiles()
        if let lastProfile = profiles.sorted(by: {$0.getId() < $1.getId()}).last {
            id = lastProfile.getId() + 1
        }
        created.setId(id: id)
        RealmService.saveProfile(created)
    }
}
