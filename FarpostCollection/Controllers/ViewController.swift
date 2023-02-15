//
//  ViewController.swift
//  FarpostCollection
//
//  Created by ios_developer on 15.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let numberOfCells = 6
    let cellBoundsInset: CGFloat = 10
    private(set) var ImageCells: [ImageCell]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCellView.self, forCellWithReuseIdentifier: ImageCellView.reuseID)
        return collectionView
    }()
    
    init(ImageCells: [ImageCell]) {
        self.ImageCells = ImageCells
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.ImageCells = []
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FarPost"
        view.backgroundColor = .white
        setup()
        collectionView.delegate = self
        collectionView.dataSource = self
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

extension ViewController {
    convenience init() {
        let images = [
            ImageCell(),
            ImageCell(),
            ImageCell(),
            ImageCell(),
            ImageCell(),
            ImageCell(),
        ]
        self.init(ImageCells: images)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    // TODO: Нормально впихнуть numberOfCells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ImageCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellView.reuseID, for: indexPath) as? ImageCellView else { fatalError("Cannot dequeue valid cell") }
        cell.configure()
        return cell
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
}
