//
//  EndpointRequestable.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 13.04.2021.
//

import Foundation
import Alamofire

enum EndpointRequestable: Requestable {
  
    case nowPlaying
    case upcoming
    case search(SearchRequest)
    case movieDetail(Int)
    case similar(Int)

}

extension EndpointRequestable {
  var method: HTTPMethod {
    switch self {
    case .nowPlaying: return .get
    case .upcoming: return .get
    case .search: return .get
    case .movieDetail: return .get
    case .similar: return .get

    }
  }
  
  var path: String {
    switch self {
    case .nowPlaying : return "/movie/now_playing"
    case .upcoming : return "/movie/upcoming"
    case .search: return "/search/movie"
    case .movieDetail(let movieId): return "/movie/\(movieId)"
    case .similar(let movieId) : return "/movie/\(movieId)/similar"
    }
  }
  
  func asURLRequest() -> URLRequest {
    var request = URLRequest(url: urlComponents.url!)
    
    for (key, value) in headers {
      request.setValue(key, forHTTPHeaderField: value)
    }
    
    switch self {
    case let .search(parameters):
        request = try! URLEncodedFormParameterEncoder().encode(parameters, into: request)
        break
    default:
      break
    }
    
    return request
  }
  
  var extraParams: [String : Any]?  {
    switch self {
    case .movieDetail:
      return ["append_to_response": "videos,images"]

    default:
      return nil
    }
  }
 
}
