//
//  Application.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 12.04.2021.
//

import UIKit

class Application{
    static let shared = Application()
    private let endpoint: Endpoint
    
    private init() {
        self.endpoint = EndpointImp()
    }
    
    func configureMainInterface(in window:UIWindow){
        let listWireframe = ListWireframe(endpoint:endpoint)
        window.rootViewController = listWireframe.builder()
    }
}
