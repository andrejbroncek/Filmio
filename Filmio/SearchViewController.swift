//
//  SearchViewController.swift
//  Filmio
//
//  Created by Andrej Broncek on 10/31/16.
//  Copyright © 2016 Andrej Broncek. All rights reserved.
//

import UIKit
import PKHUD

private let reuseIdentifier = "movieCellId"

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter movie title..."
        sb.barStyle = UIBarStyle.blackOpaque
        return sb
    }()
    
    let segmentedBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var movieCollectionView: MovieCollectionView = {
        let collectionView = MovieCollectionView(frame: CGRect())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.itemSize = CGSize(width: self.view.frame.size.width - 100, height: self.view.frame.size.height - 150)
        return collectionView
    }()
    
    lazy var typeSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Movie", "Series"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.black
        sc.layer.borderColor = UIColor.clear.cgColor
        sc.selectedSegmentIndex = 0
        sc.layer.masksToBounds = true
        sc.addTarget(self, action: #selector(searchMovie), for:.valueChanged)
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieCollectionView.searchController = self
        
        self.view.backgroundColor = UIColor.movieLightGray()
        
        self.searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        self.view.addSubview(segmentedBackgroundView)
        self.view.addSubview(movieCollectionView)
        self.view.addSubview(typeSegmentedControl)
        
        setupConstraints()
        
        let indexSet = IndexSet(integer: 0)
        self.movieCollectionView.collectionView.reloadSections(indexSet)
        
    }
    
    func searchMovie() {
        
        let text = searchBar.text
        let type = typeSegmentedControl.titleForSegment(at: typeSegmentedControl.selectedSegmentIndex)?.lowercased()
        
        if !text!.isEmpty && type != nil {
            
            HUD.show(.progress)
            
            DataManager.sharedInstance.searchMovies(name: text!, type: type!, page: 1,  completionHandler: { moviesArray in
                
                if ((moviesArray.1) == nil) {
                    
                    HUD.flash(.success, delay: 0.3)
                    
                    self.movieCollectionView.moviesArray = [MovieModel]()
                    
                    for movie in moviesArray.0 {
                        self.movieCollectionView.moviesArray.append(movie!)
                    }
                    
                    // reload with animation
                    self.movieCollectionView.collectionView.performBatchUpdates({
                        let indexSet = IndexSet(integer: 0)
                        self.movieCollectionView.collectionView.reloadSections(indexSet)
                    }, completion: nil)
                    
                    let indexPath = NSIndexPath(row: 0, section: 0)
                    self.movieCollectionView.collectionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
                    
                } else {
                    HUD.flash(.labeledError(title: "No Results", subtitle: "Please try different search term."), delay: 1)
                }
            })
        }
    }
    
    func setupConstraints() {
        
        segmentedBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        segmentedBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        segmentedBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        segmentedBackgroundView.heightAnchor.constraint(equalTo: typeSegmentedControl.heightAnchor, constant: 8).isActive = true
        
        typeSegmentedControl.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        typeSegmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        typeSegmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        
        movieCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        movieCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        movieCollectionView.topAnchor.constraint(equalTo: self.segmentedBackgroundView.bottomAnchor).isActive = true
        movieCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchMovie()
        searchBar.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
