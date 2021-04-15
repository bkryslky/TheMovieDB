//
//  ListViewController.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 13.04.2021.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var upComingTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var presenter:ListViewToPresenter?
    private var nowPlayingMovies = [Movie]()
    private var upComingMovies = [Movie]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupCollectionView()
        setupTableView()
       
        presenter?.viewDidload()

    }
    
    private func setupSearchBar(){
        searchBar.placeholder = "Search"
        searchBar.delegate = self
    }
    
    private func setupCollectionView(){
        
        nowPlayingCollectionView.register(type: NowPlayingCollectionViewCell.self)
        nowPlayingCollectionView.dataSource = self
        nowPlayingCollectionView.delegate = self
        
        let w:CGFloat = UIScreen.main.bounds.width
        let h:CGFloat = 180
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: w, height: h)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        
        nowPlayingCollectionView.collectionViewLayout = layout
        
    }

    private func setupTableView(){
        upComingTableView.register(type: UpComingTableViewCell.self)
        upComingTableView.dataSource = self
        upComingTableView.delegate = self
        let h:CGFloat = 120
        upComingTableView.rowHeight = h
        
    }
    

    @IBAction func pageChanged(_ sender: UIPageControl) {
        self.nowPlayingCollectionView.scrollToItem(at: IndexPath(row:sender.currentPage, section: 0), at:.init(), animated: true)

    }
    

}

extension ListViewController:ListPresenterToView{
    func displayNowPlayings(movies: [Movie]) {
        self.nowPlayingMovies = movies
        self.pageControl.numberOfPages = movies.count
        self.nowPlayingCollectionView.reloadData()
    }
    
    func displayUpcomings(movies: [Movie]) {
        self.upComingMovies = movies
        self.upComingTableView.reloadData()
    }
    
    func displayError(error: APIError) {
        print(error)
    }
    
    func displayLoading(status: Bool) {
        self.loading(status: status)
    }
    
}

extension ListViewController:UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        presenter?.router?.openSearch()
        searchBar.resignFirstResponder()
    }
}
extension ListViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType:NowPlayingCollectionViewCell.self, at: indexPath)
        cell.configureCell(model: self.nowPlayingMovies[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.router?.goToDetail(from: self, movie: nowPlayingMovies[indexPath.row])
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == nowPlayingCollectionView{
            let visibleRect = CGRect(origin: self.nowPlayingCollectionView.contentOffset, size: self.nowPlayingCollectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = self.nowPlayingCollectionView.indexPathForItem(at: visiblePoint) {
                self.pageControl.currentPage = visibleIndexPath.row
            }
        }
    }
}
    

extension ListViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.upComingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: UpComingTableViewCell.self, at: indexPath)
        cell.configureCell(model: self.upComingMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.router?.goToDetail(from: self, movie: upComingMovies[indexPath.row])
    }
    
}
