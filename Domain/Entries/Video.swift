//
//  Video.swift
//  Domain
//
//  Created by Tarık Taha Uygun on 1.08.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation

public struct Video: Decodable {
    public let id: String
    public let name: String
    public let key: String

    enum CodingKeys: String, CodingKey {
        case id, name, key
    }
}
