//
//  DetailViewController.swift
//  Filmio
//
//  Created by Andrej Broncek on 11/15/16.
//  Copyright © 2016 Andrej Broncek. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    var movie = MovieModel().self
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = UIColor.clear
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let detailsBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    let ratingBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    let imdbTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.text = "IMDb Rating"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imdbTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.movieGray()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let metascoreTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.text = "Metascore"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let metascoreTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.movieGray()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genreTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.text = "Genre"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genreTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.movieGray()
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseDateTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.text = "Released"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseDateTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.movieGray()
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let runtimeTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.text = "Runtime"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let runtimeTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.movieGray()
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.text = "Rated"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.movieGray()
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countryTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.text = "Country"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countryTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.movieGray()
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let directorTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.text = "Director"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let directorTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.movieGray()
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let plotTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.text = "Plot"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let plotTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.movieGray()
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let actorsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.text = "Actors"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let actorsTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.movieGray()
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let writersTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.text = "Writers"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let writersTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.movieGray()
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let awardsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.text = "Awards"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let awardsTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.movieGray()
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imdbButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 15
        button.setTitle("Go to IMDb.com", for: .normal)
        button.addTarget(self, action: #selector(loadImdbWebsite), for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let verticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.movieLightGray()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.movieLightGray()
        
        self.scrollView.delegate = self
        self.scrollView.bounces = false
        self.scrollView.showsVerticalScrollIndicator = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIView(frame: CGRect(x: 0, y: 0, width: 57, height: 30)))
        
        let label = UILabel(frame: CGRect(x:0, y:0, width:400, height:50))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = movie.title
        self.navigationItem.titleView = label
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.1
        self.navigationController?.navigationBar.layer.shadowRadius = 10
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        let url = URL(string: movie.imageURL)
        posterImageView.sd_setImage(with: url)
        
        imdbTextLabel.text = movie.imdbRating
        metascoreTextLabel.text = movie.metascoreRating
        genreTextLabel.text = movie.genre
        releaseDateTextLabel.text = movie.released
        runtimeTextLabel.text = movie.runtime
        ratingTextLabel.text = movie.rated
        countryTextLabel.text = movie.country
        directorTextLabel.text = movie.director
        plotTextLabel.text = movie.plot
        actorsTextLabel.text = movie.actors
        writersTextLabel.text = movie.writers
        awardsTextLabel.text = movie.awards
        
        self.view.addSubview(scrollView)
        
        self.scrollView.addSubview(containerView)
        
        self.containerView.addSubview(posterImageView)
        self.containerView.addSubview(detailsBackgroundView)
        
        detailsBackgroundView.addSubview(ratingBackgroundView)
        
        ratingBackgroundView.addSubview(verticalLine)
        ratingBackgroundView.addSubview(imdbTitleLabel)
        ratingBackgroundView.addSubview(imdbTextLabel)
        ratingBackgroundView.addSubview(metascoreTitleLabel)
        ratingBackgroundView.addSubview(metascoreTextLabel)
        
        detailsBackgroundView.addSubview(genreTitleLabel)
        detailsBackgroundView.addSubview(genreTextLabel)
        detailsBackgroundView.addSubview(releaseDateTitleLabel)
        detailsBackgroundView.addSubview(releaseDateTextLabel)
        detailsBackgroundView.addSubview(runtimeTitleLabel)
        detailsBackgroundView.addSubview(runtimeTextLabel)
        detailsBackgroundView.addSubview(ratingTitleLabel)
        detailsBackgroundView.addSubview(ratingTextLabel)
        detailsBackgroundView.addSubview(countryTitleLabel)
        detailsBackgroundView.addSubview(countryTextLabel)
        detailsBackgroundView.addSubview(directorTitleLabel)
        detailsBackgroundView.addSubview(directorTextLabel)
        
        containerView.addSubview(plotTitleLabel)
        containerView.addSubview(plotTextLabel)
        containerView.addSubview(actorsTitleLabel)
        containerView.addSubview(actorsTextLabel)
        containerView.addSubview(writersTitleLabel)
        containerView.addSubview(writersTextLabel)
        containerView.addSubview(awardsTitleLabel)
        containerView.addSubview(awardsTextLabel)
        
        scrollView.addSubview(imdbButton)
        
        setupConstraints()
        
        view.setNeedsLayout()
        view.layoutIfNeeded()

        self.scrollView.contentSize = CGSize(width: view.frame.size.width, height: imdbButton.frame.origin.y + imdbButton.frame.size.height + 24)
    }
    
    func setupConstraints() {
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        
        posterImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        posterImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        detailsBackgroundView.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor).isActive = true
        detailsBackgroundView.centerYAnchor.constraint(equalTo: posterImageView.bottomAnchor).isActive = true
        detailsBackgroundView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        detailsBackgroundView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        detailsBackgroundView.bottomAnchor.constraint(equalTo: directorTitleLabel.bottomAnchor, constant: 16).isActive = true
        
        ratingBackgroundView.topAnchor.constraint(equalTo: detailsBackgroundView.topAnchor).isActive = true
        ratingBackgroundView.centerXAnchor.constraint(equalTo: detailsBackgroundView.centerXAnchor).isActive = true
        ratingBackgroundView.widthAnchor.constraint(equalTo: detailsBackgroundView.widthAnchor).isActive = true
        ratingBackgroundView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        verticalLine.centerXAnchor.constraint(equalTo: ratingBackgroundView.centerXAnchor).isActive = true
        verticalLine.bottomAnchor.constraint(equalTo: ratingBackgroundView.bottomAnchor, constant: -4).isActive = true
        verticalLine.widthAnchor.constraint(equalToConstant: 2).isActive = true
        verticalLine.topAnchor.constraint(equalTo: ratingBackgroundView.topAnchor, constant: 4).isActive = true
        
        imdbTitleLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor).isActive = true
        imdbTitleLabel.rightAnchor.constraint(equalTo: verticalLine.leftAnchor).isActive = true
        imdbTitleLabel.topAnchor.constraint(equalTo: verticalLine.topAnchor).isActive = true
        imdbTitleLabel.bottomAnchor.constraint(equalTo: verticalLine.centerYAnchor, constant: -2).isActive = true
        
        imdbTextLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor).isActive = true
        imdbTextLabel.rightAnchor.constraint(equalTo: verticalLine.leftAnchor).isActive = true
        imdbTextLabel.topAnchor.constraint(equalTo: imdbTitleLabel.bottomAnchor).isActive = true
        imdbTextLabel.bottomAnchor.constraint(equalTo: verticalLine.bottomAnchor, constant: -2).isActive = true
        
        metascoreTitleLabel.leftAnchor.constraint(equalTo: verticalLine.rightAnchor).isActive = true
        metascoreTitleLabel.rightAnchor.constraint(equalTo: detailsBackgroundView.rightAnchor).isActive = true
        metascoreTitleLabel.topAnchor.constraint(equalTo: verticalLine.topAnchor).isActive = true
        metascoreTitleLabel.bottomAnchor.constraint(equalTo: verticalLine.centerYAnchor, constant: -2).isActive = true
        
        metascoreTextLabel.leftAnchor.constraint(equalTo: verticalLine.rightAnchor).isActive = true
        metascoreTextLabel.rightAnchor.constraint(equalTo: detailsBackgroundView.rightAnchor).isActive = true
        metascoreTextLabel.topAnchor.constraint(equalTo: imdbTitleLabel.bottomAnchor).isActive = true
        metascoreTextLabel.bottomAnchor.constraint(equalTo: verticalLine.bottomAnchor, constant: -2).isActive = true
        
        genreTitleLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor, constant: 16).isActive = true
        genreTitleLabel.topAnchor.constraint(equalTo: ratingBackgroundView.bottomAnchor, constant: 16).isActive = true
        
        genreTextLabel.rightAnchor.constraint(equalTo: detailsBackgroundView.rightAnchor, constant: -16).isActive = true
        genreTextLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor, constant: 88).isActive = true
        genreTextLabel.topAnchor.constraint(equalTo: genreTitleLabel.topAnchor).isActive = true
        
        releaseDateTitleLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor, constant: 16).isActive = true
        releaseDateTitleLabel.topAnchor.constraint(equalTo: genreTextLabel.bottomAnchor, constant: 8).isActive = true
        
        releaseDateTextLabel.rightAnchor.constraint(equalTo: detailsBackgroundView.rightAnchor, constant: -16).isActive = true
        releaseDateTextLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor, constant: 88).isActive = true
        releaseDateTextLabel.topAnchor.constraint(equalTo: releaseDateTitleLabel.topAnchor).isActive = true
        
        runtimeTitleLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor, constant: 16).isActive = true
        runtimeTitleLabel.topAnchor.constraint(equalTo: releaseDateTextLabel.bottomAnchor, constant: 8).isActive = true
        
        runtimeTextLabel.rightAnchor.constraint(equalTo: detailsBackgroundView.rightAnchor, constant: -16).isActive = true
        runtimeTextLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor, constant: 88).isActive = true
        runtimeTextLabel.topAnchor.constraint(equalTo: runtimeTitleLabel.topAnchor).isActive = true
        
        ratingTitleLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor, constant: 16).isActive = true
        ratingTitleLabel.topAnchor.constraint(equalTo: runtimeTextLabel.bottomAnchor, constant: 8).isActive = true
        
        ratingTextLabel.rightAnchor.constraint(equalTo: detailsBackgroundView.rightAnchor, constant: -16).isActive = true
        ratingTextLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor, constant: 88).isActive = true
        ratingTextLabel.topAnchor.constraint(equalTo: ratingTitleLabel.topAnchor).isActive = true
        
        countryTitleLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor, constant: 16).isActive = true
        countryTitleLabel.topAnchor.constraint(equalTo: ratingTextLabel.bottomAnchor, constant: 8).isActive = true
        
        countryTextLabel.rightAnchor.constraint(equalTo: detailsBackgroundView.rightAnchor, constant: -16).isActive = true
        countryTextLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor, constant: 88).isActive = true
        countryTextLabel.topAnchor.constraint(equalTo: countryTitleLabel.topAnchor).isActive = true
        
        directorTitleLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor, constant: 16).isActive = true
        directorTitleLabel.topAnchor.constraint(equalTo: countryTextLabel.bottomAnchor, constant: 8).isActive = true
        
        directorTextLabel.rightAnchor.constraint(equalTo: detailsBackgroundView.rightAnchor, constant: -16).isActive = true
        directorTextLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor, constant: 88).isActive = true
        directorTextLabel.topAnchor.constraint(equalTo: directorTitleLabel.topAnchor).isActive = true
        
        plotTitleLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor).isActive = true
        plotTitleLabel.rightAnchor.constraint(equalTo: detailsBackgroundView.rightAnchor).isActive = true
        plotTitleLabel.topAnchor.constraint(equalTo: detailsBackgroundView.bottomAnchor, constant: 16).isActive = true
        
        plotTextLabel.leftAnchor.constraint(equalTo: plotTitleLabel.leftAnchor).isActive = true
        plotTextLabel.rightAnchor.constraint(equalTo: plotTitleLabel.rightAnchor).isActive = true
        plotTextLabel.topAnchor.constraint(equalTo: plotTitleLabel.bottomAnchor, constant: 8).isActive = true
        
        actorsTitleLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor).isActive = true
        actorsTitleLabel.rightAnchor.constraint(equalTo: detailsBackgroundView.rightAnchor).isActive = true
        actorsTitleLabel.topAnchor.constraint(equalTo: plotTextLabel.bottomAnchor, constant: 16).isActive = true
        
        actorsTextLabel.leftAnchor.constraint(equalTo: actorsTitleLabel.leftAnchor).isActive = true
        actorsTextLabel.rightAnchor.constraint(equalTo: actorsTitleLabel.rightAnchor).isActive = true
        actorsTextLabel.topAnchor.constraint(equalTo: actorsTitleLabel.bottomAnchor, constant: 8).isActive = true
        
        writersTitleLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor).isActive = true
        writersTitleLabel.rightAnchor.constraint(equalTo: detailsBackgroundView.rightAnchor).isActive = true
        writersTitleLabel.topAnchor.constraint(equalTo: actorsTextLabel.bottomAnchor, constant: 16).isActive = true
        
        writersTextLabel.leftAnchor.constraint(equalTo: writersTitleLabel.leftAnchor).isActive = true
        writersTextLabel.rightAnchor.constraint(equalTo: writersTitleLabel.rightAnchor).isActive = true
        writersTextLabel.topAnchor.constraint(equalTo: writersTitleLabel.bottomAnchor, constant: 8).isActive = true
        
        awardsTitleLabel.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor).isActive = true
        awardsTitleLabel.rightAnchor.constraint(equalTo: detailsBackgroundView.rightAnchor).isActive = true
        awardsTitleLabel.topAnchor.constraint(equalTo: writersTextLabel.bottomAnchor, constant: 16).isActive = true
        
        awardsTextLabel.leftAnchor.constraint(equalTo: awardsTitleLabel.leftAnchor).isActive = true
        awardsTextLabel.rightAnchor.constraint(equalTo: awardsTitleLabel.rightAnchor).isActive = true
        awardsTextLabel.topAnchor.constraint(equalTo: awardsTitleLabel.bottomAnchor, constant: 8).isActive = true
        
        imdbButton.topAnchor.constraint(equalTo: awardsTextLabel.bottomAnchor, constant: 24).isActive = true
        imdbButton.leftAnchor.constraint(equalTo: detailsBackgroundView.leftAnchor).isActive = true
        imdbButton.rightAnchor.constraint(equalTo: detailsBackgroundView.rightAnchor).isActive = true
        imdbButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
    }
    
    func loadImdbWebsite() {
        let urlString = "http://www.imdb.com/title/" + movie.imdbId
        UIApplication.shared.openURL(URL(string: urlString) as URL!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0
        self.navigationController?.navigationBar.layer.shadowRadius = 0
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
