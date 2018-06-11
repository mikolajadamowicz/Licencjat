//
//  UsersStruct.swift
//  Licencjat
//
//  Created by Mikolaj Adamowicz on 11.06.2018.
//  Copyright © 2018 Mikolaj Adamowicz. All rights reserved.
//

import Foundation

public struct Users: Codable {
    var id: String
    var students: [String]
    var teachers: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case students
        case teachers
    }
    
    init() {
        self.id = ""
        self.students = [String]()
        self.teachers = [String]()
    }
}

