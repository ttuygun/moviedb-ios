//
//  TVShowDetail.swift
//  Domain
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation

public struct TVShowDetail: Decodable {
    public let backdropPath: String
    let createdBy: [CreatedBy]
    let episodeRunTime: [Int]
    let firstAirDate: String
    let genres: [Genre]
    let homepage: String
    public let id: Int
    let inProduction: Bool
    let languages: [String]
    let lastAirDate: String
    let lastEpisodeToAir: EpisodeToAir
    let name: String
    let nextEpisodeToAir: EpisodeToAir?
    let networks: [Network]
    let numberOfEpisodes, numberOfSeasons: Int
    let originCountry: [String]
    let originalLanguage, originalName, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [Network]
    let seasons: [Season]
    let status, type: String
    public let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres, homepage, id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
        case nextEpisodeToAir = "next_episode_to_air"
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case seasons, status, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - CreatedBy
struct CreatedBy: Decodable {
    let id: Int
    let creditID, name: String
    let gender: Int
    let profilePath: String

    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name, gender
        case profilePath = "profile_path"
    }
}


// MARK: - LastEpisodeToAir
struct EpisodeToAir: Decodable {
    let airDate: String
    let episodeNumber, id: Int
    let name, overview, productionCode: String
    let seasonNumber, showID: Int
    let stillPath: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case id, name, overview
        case productionCode = "production_code"
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Network
struct Network: Decodable {
    let name: String
    let id: Int
    let logoPath: String?
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case name, id
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

// MARK: - Season
struct Season: Decodable {
    let airDate: String
    let episodeCount, id: Int
    let name, overview, posterPath: String
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}
