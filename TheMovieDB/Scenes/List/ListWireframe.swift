//
//  ListWireframe.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 14.04.2021.
//

import UIKit

class ListWireframe:ListPresenterToWireFrame{
 
    private let endpoint:Endpoint

    init(endpoint:Endpoint) {
        self.endpoint = endpoint
    }
    func builder() -> UIViewController {
        let view = ListViewController.loadFromNib()
        
        var presenter : ListViewToPresenter & ListInteractorToPresenter = ListPresenter()
        var interactor: ListPresenterToInteractor = ListInteractor(endpoint: endpoint)
        let router: ListPresenterToWireFrame = ListWireframe(endpoint: endpoint)
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        
        return view
    }
    
    func goToDetail(from view:ListPresenterToView,movie:Movie) {
        let detailWireframe = DetailWireframe(endpoint: endpoint)
        let vc = detailWireframe.builder() as! DetailViewController
        vc.movie = movie
        (view as? UIViewController)?.present(vc, animated:false)
    }
    
    func openSearch() {
        
        let searchWireframe = SearchWireframe(endpoint: endpoint)
        let vc = searchWireframe.builder()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: false)
    }
}
