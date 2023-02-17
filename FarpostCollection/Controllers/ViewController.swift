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
        let layout = RightAnimationFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCellView.self, forCellWithReuseIdentifier: ImageCellView.reuseID)
        return collectionView
    }()
    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        return refresh
    }()
    
    init(imageCells: [ImageCell]) {
        self.imageCollection = ImageCollection(imageCells: imageCells)
        super.init(nibName: nil, bundle: nil)
        imageCollection.delegate = self
    }
    
    required init?(coder: NSCoder) {
        self.imageCollection = ImageCollection()
        super.init(coder: coder)
        imageCollection.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        collectionView.delegate = self
        collectionView.dataSource = imageCollection
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshCollection(sender:)), for: .valueChanged)
    }
    
    private func setup() {
        title = "FarPost"
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        if let layout = collectionView.collectionViewLayout as? RightAnimationFlowLayout {
            layout.boundsView = view
        }
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc private func refreshCollection(sender: UIRefreshControl) {
        imageCollection.resetCollection()
        collectionView.reloadData()
        sender.endRefreshing()
    }
}


extension ViewController: ImageCollectionDelegate {
    
    func removeImageCellView(at: Int) {
        let indexPath = IndexPath(row: at, section: 0)
        collectionView.deleteItems(at: [indexPath])
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
        imageCollection.dropImage(index: indexPath.row)
        if let layout = collectionView.collectionViewLayout as? RightAnimationFlowLayout {
            layout.lastIndexPath = indexPath
        }
    }
}


extension ViewController {
    convenience init(collectionSize: Int = 6) {
        var images: [ImageCell] = []
        images.reserveCapacity(collectionSize)
        for _ in 0..<collectionSize {
            images.append(ImageCell())
        }
        self.init(imageCells: images)
    }
}
