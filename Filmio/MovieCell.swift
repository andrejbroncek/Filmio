//
//  MovieCell.swift
//  Filmio
//
//  Created by Andrej Broncek on 10/31/16.
//  Copyright © 2016 Andrej Broncek. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.backgroundColor = UIColor.clear
        textView.textAlignment = .center
        textView.contentInset = UIEdgeInsetsMake(-6,0,0,0);
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        return textView
    }()
    
    let imdbTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 11)
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
        label.font = UIFont.boldSystemFont(ofSize: 11)
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
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let noImageLabel: UILabel = {
        let label = UILabel()
        label.text = "No poster found"
        label.textColor = UIColor.movieGray()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    let verticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.movieLightGray()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(posterImageView)
        posterImageView.addSubview(noImageLabel)
        
        addSubview(textBackgroundView)
        addSubview(titleTextView)
        addSubview(verticalLine)
        addSubview(imdbTitleLabel)
        addSubview(imdbTextLabel)
        addSubview(metascoreTitleLabel)
        addSubview(metascoreTextLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        posterImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        posterImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75).isActive = true
        
        noImageLabel.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor).isActive = true
        noImageLabel.widthAnchor.constraint(equalTo: posterImageView.widthAnchor).isActive = true
        noImageLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        textBackgroundView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8).isActive = true
        textBackgroundView.leftAnchor.constraint(equalTo: posterImageView.leftAnchor).isActive = true
        textBackgroundView.rightAnchor.constraint(equalTo: posterImageView.rightAnchor).isActive = true
        textBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        titleTextView.topAnchor.constraint(equalTo: textBackgroundView.topAnchor, constant: 8).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: textBackgroundView.leftAnchor).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: textBackgroundView.rightAnchor).isActive = true
        titleTextView.bottomAnchor.constraint(equalTo: textBackgroundView.centerYAnchor, constant: -4).isActive = true
        
        verticalLine.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        verticalLine.bottomAnchor.constraint(equalTo: textBackgroundView.bottomAnchor, constant: -8).isActive = true
        verticalLine.widthAnchor.constraint(equalToConstant: 2).isActive = true
        verticalLine.topAnchor.constraint(equalTo: textBackgroundView.centerYAnchor, constant: 4).isActive = true
        
        imdbTitleLabel.leftAnchor.constraint(equalTo: textBackgroundView.leftAnchor).isActive = true
        imdbTitleLabel.rightAnchor.constraint(equalTo: verticalLine.leftAnchor).isActive = true
        imdbTitleLabel.topAnchor.constraint(equalTo: verticalLine.topAnchor).isActive = true
        imdbTitleLabel.bottomAnchor.constraint(equalTo: verticalLine.centerYAnchor).isActive = true
        
        imdbTextLabel.leftAnchor.constraint(equalTo: textBackgroundView.leftAnchor).isActive = true
        imdbTextLabel.rightAnchor.constraint(equalTo: verticalLine.leftAnchor).isActive = true
        imdbTextLabel.topAnchor.constraint(equalTo: imdbTitleLabel.bottomAnchor).isActive = true
        imdbTextLabel.bottomAnchor.constraint(equalTo: verticalLine.bottomAnchor).isActive = true
        
        metascoreTitleLabel.leftAnchor.constraint(equalTo: verticalLine.rightAnchor).isActive = true
        metascoreTitleLabel.rightAnchor.constraint(equalTo: textBackgroundView.rightAnchor).isActive = true
        metascoreTitleLabel.topAnchor.constraint(equalTo: verticalLine.topAnchor).isActive = true
        metascoreTitleLabel.bottomAnchor.constraint(equalTo: verticalLine.centerYAnchor).isActive = true
        
        metascoreTextLabel.leftAnchor.constraint(equalTo: verticalLine.rightAnchor).isActive = true
        metascoreTextLabel.rightAnchor.constraint(equalTo: textBackgroundView.rightAnchor).isActive = true
        metascoreTextLabel.topAnchor.constraint(equalTo: imdbTitleLabel.bottomAnchor).isActive = true
        metascoreTextLabel.bottomAnchor.constraint(equalTo: verticalLine.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
