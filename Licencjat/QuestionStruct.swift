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
    var title: String
    var text: String
    var forCount: Int
    var againstCount: Int
    var answered: [String]
    
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case text
        case forCount
        case againstCount
        case answered
    }
    
    init(text: String, title: String) {
        self.id = ""
        self.title = title
        self.text = text
        self.forCount = 0
        self.againstCount = 0
        self.answered = [String]()
    }
}



