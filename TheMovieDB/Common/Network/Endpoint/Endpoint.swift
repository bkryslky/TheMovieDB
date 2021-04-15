//
//  Endpoint.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 13.04.2021.
//

import Foundation

protocol Endpoint {
    func getNowPlayings(completionHandler:@escaping (Result<BaseResponse<[Movie]>,APIError>)->Void)
    func getUpComings(completionHandler:@escaping (Result<BaseResponse<[Movie]>,APIError>)->Void)
    func searchMovies(search text:String,completionHandler:@escaping (Result<BaseResponse<[Movie]>,APIError>)->Void)
    func getMovieDetail(movie id:Int,completionHandler:@escaping (Result<MovieDetail,APIError>)->Void)
    func getSimilarMovies(movie id:Int,completionHandler:@escaping (Result<BaseResponse<[Movie]>,APIError>)->Void)
}
