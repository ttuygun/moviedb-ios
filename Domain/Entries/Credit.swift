//
//  Credits.swift
//  Domain
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation

public struct Credit: Codable {
    let id: Int?
    public let cast: [CastCrew]
    public let crew: [CastCrew]
}

public struct CastCrew: Codable {
    let castID: Int?
    let character, creditID: String?
    let gender, id: Int?
    public let name: String?
    let order: Int?
    public let profilePath: String?
    let department: String?
    public let job: String?

    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case creditID = "credit_id"
        case profilePath = "profile_path"
        case gender, id, name, order, department, character, job
    }
}
