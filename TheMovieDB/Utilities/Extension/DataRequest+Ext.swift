//
//  DataRequest+Ext.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 13.04.2021.
//

import Foundation
import Alamofire

extension DataRequest {
    
    @discardableResult
    public func seralize<T: Decodable>(completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self {
    
        return self.responseDecodable(completionHandler: completionHandler)
    }
    
    func seralize<T: Decodable>(completionHandler:@escaping (Result<T,APIError>) ->Void)  {
        _ = self.validate().seralize { (data: AFDataResponse<T>) in
            
            switch data.result{
            case.success(let payload):
                completionHandler(.success(payload))
            case .failure(let error):
                completionHandler(.failure(error as? APIError ?? .generalResponseError))
            }
        
        }
    }
    
    func validate() -> Self {
            return self.validate { _, response, data -> Request.ValidationResult in
                guard (400...599) ~= response.statusCode else { return .success(()) }
                guard let _ = data else { return .failure(APIError.generalResponseError) }

                switch response.statusCode {
                case  401:
                    return .failure(APIError.unauthorizedAccessError)
                case 404:
                    return .failure(APIError.notFoundError)
                case 502 :
                    return .failure(APIError.serviceError)
                default :
                    return .failure(APIError.generalResponseError)
                }
            }
        }
}
