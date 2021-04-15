//
//  EndpointImp.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 14.04.2021.
//

import Foundation

class EndpointImp: Endpoint {

   
    func getNowPlayings(completionHandler: @escaping (Result<BaseResponse<[Movie]>, APIError>) -> Void) {
        let method = EndpointRequestable.nowPlaying
        method.asURLRequest().perform { data in
            completionHandler(data)
        }
        
    }
    
    func getUpComings(completionHandler: @escaping (Result<BaseResponse<[Movie]>, APIError>) -> Void) {
        let method = EndpointRequestable.upcoming
        method.asURLRequest().perform { data in
            completionHandler(data)
        }
        
    }
    func searchMovies(search text: String, completionHandler: @escaping (Result<BaseResponse<[Movie]>, APIError>) -> Void) {
        let method = EndpointRequestable.search(SearchRequest(query: text))
        method.asURLRequest().perform { data in
            completionHandler(data)
        }
    }
    
    func getMovieDetail(movie id: Int, completionHandler: @escaping (Result<MovieDetail, APIError>) -> Void) {
        let method = EndpointRequestable.movieDetail(id)
        method.asURLRequest().perform { data in
            completionHandler(data)
        }
        print(method.asURLRequest().urlRequest)
    }
    
    func getSimilarMovies(movie id: Int, completionHandler: @escaping (Result<BaseResponse<[Movie]>, APIError>) -> Void) {
        let method = EndpointRequestable.similar(id)
        method.asURLRequest().perform { data in
            completionHandler(data)
        }
        
    }
    

}
