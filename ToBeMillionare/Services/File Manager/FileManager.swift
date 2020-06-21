//
//  FileManager.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 19.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

class FilesManager {
    
    enum Error: Swift.Error {
        case fileAlreadyExists
        case invalidDirectory
        case writtingFailed
        case fileNotExists
        case readingFailed
    }
    
    var fileManager: FileManager!
    
    private init(){
        fileManager = FileManager()
        fileManager = .default
    }
        
    static let shared: FilesManager = FilesManager()
    
    func save(fileNamed: String, data: Data) throws {
        guard let url = makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }
        if fileManager.fileExists(atPath: url.absoluteString) {
            throw Error.fileAlreadyExists
        }
        do {
            print(url)
            try data.write(to: url)
        } catch {
            debugPrint(error)
            throw Error.writtingFailed
        }
    }
    
    private func makeURL(forFileNamed fileName: String) -> URL? {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(fileName)
    }
    
    
    func read(fileNamed: String) throws -> Data {
        guard let url = makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }
        //  guard fileManager.fileExists(atPath: url.absoluteString) else {
        //     throw Error.fileNotExists
        //  }
        print(url)
        do {
            return try Data(contentsOf: url)
        } catch {
            debugPrint(error)
            throw Error.readingFailed
        }
    }
}


//MARK:- History
extension FilesManager {
    
    func saveHistory(gameModeEnum: GameModeEnum, playerId: Int, histories: [HistoryModel]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(histories)
            try save(fileNamed: "history_\(gameModeEnum.rawValue)_\(playerId)", data: data)
        } catch let err {
            print(err)
        }
    }
    
    
    func loadHistories(gameModeEnum: GameModeEnum, playerId: Int) -> [HistoryModel]? {
        do {
            let data = try read(fileNamed: "history_\(gameModeEnum.rawValue)_\(playerId)")
            let decoder = JSONDecoder()
            let histories = try decoder.decode([HistoryModel].self, from: data)
            return histories
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

