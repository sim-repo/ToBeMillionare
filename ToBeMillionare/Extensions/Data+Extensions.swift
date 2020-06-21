//
//  Data+Extensions.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 20.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

extension Data {
    func append(to fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        }
        else {
            try write(to: fileURL, options: .atomic)
        }
    }
}
