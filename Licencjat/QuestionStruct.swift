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
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case text
        case forCount
        case againstCount
        
    }
    
    init() {
        self.id = ""
        self.title = ""
        self.text = ""
        self.forCount = -1
        self.againstCount = -1
    }
}

 enum Result<Value> {
    case success(Value)
    case failure(Error)
}
