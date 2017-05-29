//
//  NoMovieCell.swift
//  Filmio
//
//  Created by Andrej Broncek on 11/14/16.
//  Copyright © 2016 Andrej Broncek. All rights reserved.
//

import UIKit

class NoMovieCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.text = "No search yet?"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.movieDarkGray()
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.text = "You can search for movies or series by their title."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "movie_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        
        containerView.addSubview(posterImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: posterImageView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        
        posterImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        posterImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
