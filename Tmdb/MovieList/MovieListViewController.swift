//
//  MovieListViewController.swift
//  Tmdb
//
//  Created by Yeşim Daşdemir on 21.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieListDisplayLogic: class {
    func displayMovieList(response: GetMovieList.MovieList.Response?)
}

final class MovieListViewController: UICollectionViewController, MovieListDisplayLogic {
    var interactor: MovieListBusinessLogic?
    var router: (NSObjectProtocol & MovieListRoutingLogic & MovieListDataPassing)?
    
    let searchController = UISearchController(searchResultsController: nil)
    var movieItemList: [MovieListItem]?
    var response: GetMovieList.MovieList.Response? {
        didSet {
            guard let items = response?.results else {
                return
            }
            movieItemList = items
        }
    }
    
    var filteredMovies: [MovieListItem] = []
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = MovieListInteractor()
        let presenter = MovieListPresenter()
        let router = MovieListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "MovieList"
        collectionView.delegate = self
        collectionView.dataSource = self
        setSearchViewController()
        initCollectionView()
        
        interactor?.getMovieList()
    }
    
    // MARK: Do something
    
    func displayMovieList(response: GetMovieList.MovieList.Response?) {
        self.response = response
        collectionView.reloadData()
    }
    
    private func setSearchViewController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String,
                                    category: MovieListItem? = nil) {
        
        if let response = response, let items = response.results {
            filteredMovies = items.filter { item -> Bool in
                return (item.title?.lowercased().contains(searchText.lowercased()) ?? false)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredMovies.count
        }
        return movieItemList?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell {
            if isFiltering {
                
                let viewModel = filteredMovies.map({ item -> SingleItemViewModel in
                    return SingleItemViewModel(title: item.title,
                                               subTitle: item.releaseDate,
                                               imageWidth: "200",
                                               posterPath: item.posterPath)
                })
                
                cell.configure(with: viewModel[indexPath.row])
                
            } else {
                if let movieItemList = movieItemList {
                    
                    let viewModel = movieItemList.map({ item -> SingleItemViewModel in
                        return SingleItemViewModel(title: item.title,
                                                   subTitle: item.releaseDate,
                                                   imageWidth: "200",
                                                   posterPath: item.posterPath)
                    })
                    
                    cell.configure(with: viewModel[indexPath.row])
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isFiltering {
            if let selectedId = filteredMovies[indexPath.row].id {
                router?.routeToMovieDetail(selectedMovieId: selectedId)
            }
        } else {
            if let movieItemList = movieItemList, let selectedId: Int = movieItemList[indexPath.row].id {
                router?.routeToMovieDetail(selectedMovieId: selectedId)
            }
        }
    }
    
    private func initCollectionView() {
        let nibName = String(describing: CustomCollectionViewCell.self)
        collectionView.register(UINib(nibName: nibName, bundle: Bundle(for: Self.self)), forCellWithReuseIdentifier: nibName)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
        collectionView.reloadData()
    }
}
