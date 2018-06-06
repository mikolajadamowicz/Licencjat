//
//  QuestionStruct.swift
//  Licencjat
//
//  Created by Mikolaj Adamowicz on 01.05.2018.
//  Copyright © 2018 Mikolaj Adamowicz. All rights reserved.
//

import Foundation

public struct Question: Codable {
    var id: String
//    var albumId: String
    var title: String
    var text: String
    var forCount: Int
    var againstCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
//        case albumId
        case title
        case text
        case forCount
        case againstCount
    }
    
    init(text: String) {
        self.id = ""
//        self.albumId = "123"
        self.title = "tytul roboczy"
        self.text = text
        self.forCount = -1
        self.againstCount = -1
    }
}



