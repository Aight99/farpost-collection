//
//  ImageCollection.swift
//  FarpostCollection
//
//  Created by ios_developer on 17.02.2023.
//

import UIKit

protocol ImageCollectionDelegate: AnyObject {
    func removeImageCellView(at: Int)
}

final class ImageCollection: NSObject {
    
    weak var delegate: ImageCollectionDelegate?
    private let imageProvider: ImageProvider = ImageProvider()
    let initialImageCells: [ImageCell]
    private(set) var imageCells: [ImageCell]
    
    init(imageCells: [ImageCell]) {
        self.initialImageCells = imageCells
        self.imageCells = imageCells
    }
    
    override init() {
        self.initialImageCells = []
        self.imageCells = []
    }
    
    func dropImage(index: Int) {
        imageCells.remove(at: index)
        delegate?.removeImageCellView(at: index)
    }
    
    func resetCollection() {
        imageCells = initialImageCells
    }
}


extension ImageCollection: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellView.reuseID, for: indexPath) as? ImageCellView else { fatalError("Cannot dequeue valid cell") }
        
        cell.configure()
        let imageUrl = imageCells[indexPath.row].imageUrl
        imageProvider.getImage(url: imageUrl) { [weak cell] image in
            cell?.setImage(image: image)
        }
        
        return cell
    }
}
