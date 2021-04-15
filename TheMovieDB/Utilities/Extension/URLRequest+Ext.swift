//
//  URLRequest+Ext.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 13.04.2021.
//

import Foundation
import Alamofire

extension URLRequest {
  
    func perform<T>(completionHandler:@escaping(Result<T,APIError>)->Void)  where T: Decodable {
    return AF.request(self).seralize { data in
        completionHandler(data)
    }
  }
  
}
