//
//  CellViewModelType.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import Foundation
protocol CellViewModelType{
    associatedtype T
    func configureCell(model:T)
}
