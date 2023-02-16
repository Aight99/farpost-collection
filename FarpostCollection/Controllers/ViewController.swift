//
//  ViewController.swift
//  FarpostCollection
//
//  Created by ios_developer on 15.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let cellBoundsInset: CGFloat = 10
    private let imageCollection: ImageCollection
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCellView.self, forCellWithReuseIdentifier: ImageCellView.reuseID)
        return collectionView
    }()
    
    init(imageCells: [ImageCell]) {
        self.imageCollection = ImageCollection(imageCells: imageCells)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.imageCollection = ImageCollection()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FarPost"
        view.backgroundColor = .white
        setup()
        collectionView.delegate = self
        collectionView.dataSource = imageCollection
    }
    
    @objc private func nextScreen() {
        navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    private func setup() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: self.cellBoundsInset,
            left: self.cellBoundsInset,
            bottom: self.cellBoundsInset,
            right: self.cellBoundsInset
        )
    }
    
    // TODO: Питаю сомнения, потому что будет очень большой при горизонтальной лопате
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = view.frame.width - 2 * self.cellBoundsInset
        return CGSize(width: availableWidth, height: availableWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Clicked \(indexPath.row) = \(imageCollection.imageCells[indexPath.row].imageUrl)")
    }
}


extension ViewController {
    convenience init(collectionSize: Int = 15) {
        var images: [ImageCell] = []
        images.reserveCapacity(collectionSize)
        for _ in 0..<collectionSize {
            images.append(ImageCell())
        }
        self.init(imageCells: images)
    }
}
