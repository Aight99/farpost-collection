//
//  ImageCellView.swift
//  FarpostCollection
//
//  Created by ios_developer on 15.02.2023.
//

import UIKit

class ImageCellView: UICollectionViewCell {
    
    static let reuseID = "ImageCell"
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    public func configure() {
        setup()
    }
    
    public func setImage(image: UIImage) {
        imageView.image = image
    }
    
    private func setup() {
        backgroundColor = .systemYellow
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
