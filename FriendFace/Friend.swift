//
//  Friend.swift
//  FriendFace
//
//  Created by Zach Mommaerts on 10/28/23.
//

import Foundation

struct Friend: Codable {
    
    enum CodingKeys: CodingKey {
        case id, name
    }
    
    var id = ""
    var name = ""
    
    init() {    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .id)
    }
}
