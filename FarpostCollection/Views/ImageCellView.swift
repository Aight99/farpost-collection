//
//  ImageCellView.swift
//  FarpostCollection
//
//  Created by ios_developer on 15.02.2023.
//

import UIKit

class ImageCellView: UICollectionViewCell {
    
    static let reuseID = "ImageCell"
    
    public func configure() {
        setup()
    }
    
    private func setup() {
        backgroundColor = .systemYellow
    }
}
