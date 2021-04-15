//
//  APIError.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 13.04.2021.
//

import Foundation
import Alamofire
enum APIError:Error{

    case unauthorizedAccessError
    case notFoundError
    case serviceError
    case generalResponseError
}
