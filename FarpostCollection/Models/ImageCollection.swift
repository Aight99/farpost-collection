//
//  ImageCollection.swift
//  FarpostCollection
//
//  Created by ios_developer on 17.02.2023.
//

import UIKit

final class ImageCollection: NSObject {
    
    private let imageProvider: ImageProvider = ImageProvider()
    private(set) var imageCells: [ImageCell]
    
    init(imageCells: [ImageCell]) {
        self.imageCells = imageCells
    }
    
    override init() {
        self.imageCells = []
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
        imageProvider.fetchImage(url: imageUrl) { [weak cell] image in
            cell?.setImage(image: image)
        }
        
        return cell
    }
}
