//
//  MovieCollectionView.swift
//  Filmio
//
//  Created by Andrej Broncek on 10/31/16.
//  Copyright © 2016 Andrej Broncek. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "movieCellId"
    let noMovieCellId = "noMovieCellId"
    
    var searchController = SearchViewController()
    
    var moviesArray = [MovieModel]()
    
    var itemSize: CGSize? {
        didSet {
            let layout = PageCollectionLayout(itemSize: itemSize!)
            collectionView.setCollectionViewLayout(layout, animated: false)
            collectionView.reloadData()
        }
    }
    
    var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(NoMovieCell.self, forCellWithReuseIdentifier: noMovieCellId)
        
        self.addSubview(collectionView)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(50, 0, 50, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if moviesArray.count == 0 {
            return 1
        } else {
            return moviesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: itemSize!.width, height: itemSize!.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if moviesArray.count == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: noMovieCellId, for: indexPath) as! NoMovieCell
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCell
            
            let imageUrl = moviesArray[indexPath.row].imageURL
            let url = URL(string: imageUrl)
            
            if url != nil && url?.path != "N/A" {
                cell.posterImageView.sd_setImage(with: url)
                cell.noImageLabel.isHidden = true
            } else {
                cell.posterImageView.image = nil
                cell.posterImageView.contentMode = .scaleAspectFit
                cell.posterImageView.backgroundColor = UIColor.white
                cell.noImageLabel.isHidden = false
            }
            
            let movieTitle = moviesArray[indexPath.row].title
            let movieYear = "(" + moviesArray[indexPath.row].year + ")"
            
            let movieString = "\(movieTitle) \(movieYear)" as NSString
            var movieMutableString = NSMutableAttributedString()
            
            let style = NSMutableParagraphStyle()
            style.alignment = NSTextAlignment.center
            
            movieMutableString = NSMutableAttributedString(string: movieString as String, attributes: nil)
            movieMutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor.black, range: movieString.range(of: movieTitle))
            movieMutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor.movieGray(), range: movieString.range(of: movieYear))
            movieMutableString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: movieString.range(of: movieString as String))
            movieMutableString.addAttribute(NSParagraphStyleAttributeName, value: style, range: movieString.range(of: movieString as String))
            
            cell.titleTextView.attributedText = movieMutableString
            
            let movieImdbRating = moviesArray[indexPath.row].imdbRating
            cell.imdbTextLabel.text = movieImdbRating
            
            let movieMetascoreRating = moviesArray[indexPath.row].metascoreRating
            cell.metascoreTextLabel.text = movieMetascoreRating
            
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.1
            cell.layer.shadowRadius = 10
            cell.layer.shadowOffset = CGSize(width: 0, height: 5)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView.cellForItem(at: indexPath)?.isKind(of: MovieCell.self))!{
            let detailView = DetailViewController()
            detailView.movie = moviesArray[indexPath.row]
            
            self.searchController.navigationController?.pushViewController(detailView, animated: true)
        }
    }
    
    func setupConstraints() {
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
