//
//  MDApi.swift
//  NetworkPlatform
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import Moya

enum MDApi {
    // Movie
    case movieTopRated
    case movieNowPlaying
    case moviePopular
    case movieDetail(id: String)
    case movieCredits(id: String)
    // TV Show
    case tvShowTopRated
    case tvShowPopular
    case tvShowDetail(id: String)
    case tvShowCredits(id: String)
}

extension MDApi: TargetType, PluginType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }

    var path: String {
        switch self {
        case .movieTopRated:
            return "/movie/top_rated"
        case .movieNowPlaying:
            return "/movie/now_playing"
        case .moviePopular:
            return "/movie/popular"
        case .movieDetail(let id):
            return "/movie/\(id)"
        case .movieCredits(let id):
            return "/movie/\(id)/credits"
        case .tvShowTopRated:
            return "/tv/top_rated"
        case .tvShowPopular:
            return "/tv/popular"
        case .tvShowDetail(let id):
            return "/tv/\(id)"
        case .tvShowCredits(let id):
            return "/tv/\(id)/credits"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Moya.Data {
        let sample = ""
        return sample.data(using: .utf8)!
    }

    var task: Moya.Task {
        return .requestParameters(parameters: ["api_key": ""], encoding: URLEncoding.queryString)
    }

    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }

    var parameterEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }
}
