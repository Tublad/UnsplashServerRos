//
//  PhotoGalleryView.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 07.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

protocol PhotoGalleryViewImpl {
    //функции типа, покажи данные
    func setPresenter(_ presenter: PhotoGalleryViewAction)
    func getContent(picture: Picture, count: Int)
}


final class PhotoGalleryView: UIView {
    
    //MARK: - Open properties
    var picture: Picture?
    var count: Int?
    var newPicture: Picture?
    
    //MARK: - Private properties
    private var presenter: PhotoGalleryViewAction?
    
    lazy var collectionView: UICollectionView = {
        let size = UIScreen.main.bounds
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: size.width, height: size.height / 1.5)
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = true
        collectionView.isUserInteractionEnabled = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotoGalleryViewCell.nib, forCellWithReuseIdentifier: PhotoGalleryViewCell.reuseId)
        
        self.addSubview(collectionView)
        return collectionView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    //MARK: - Private metods
    fileprivate func setupUI() {
        self.backgroundColor = .white
        setupCollectionView()
     // to do ...
    }
    
    private func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func checkIndex() {
        var array: Picture = []
        guard let maxCount = picture?.count,
            let needIndex = count,
            let unwrapPicture = picture else { return }
        var count = 0
        for value in 0..<maxCount {
            if needIndex >= value {
                array.append(unwrapPicture[needIndex - value])
            } else if needIndex == value {
                count = value
            } else {
                count += 1
                array.append(unwrapPicture[count])
            }
        }
        self.newPicture = array
    }
}

extension PhotoGalleryView: PhotoGalleryViewImpl {
    
    func getContent(picture: Picture, count: Int) {
        // deleta
        self.picture = nil
        self.count = 0
        self.newPicture = nil
        // new value
        self.picture = picture
        self.count = count
        checkIndex()
    }
    
    func setPresenter(_ presenter: PhotoGalleryViewAction) {
        self.presenter = presenter
    }
}

//MARK: - CollectionDelegate

extension PhotoGalleryView: UICollectionViewDelegate {
    // to do
    
}

//MARK: - CollectionDataSource

extension PhotoGalleryView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newPicture?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryViewCell.reuseId, for: indexPath) as? PhotoGalleryViewCell else {
            return UICollectionViewCell()
        }
        
        if let fullImage = newPicture?[indexPath.row],
            let url = URL(string: fullImage.urls.full){
            DataProvider.shared.downloadImageUrl(id: fullImage.id, url: url) { (image) in
                cell.imageView.image = image
            }
        }
        
        if let fullCount = newPicture?.count {
            cell.countLabel.text = "\(indexPath.row + 1) из \(fullCount)"
        }
        
        return cell
    }
    
}


