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
}


final class PhotoGalleryView: UIView {
    
    //MARK: - Open properties
    var picture: Picture?
    
    //MARK: - Private properties
    private var presenter: PhotoGalleryViewAction?
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
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
}

extension PhotoGalleryView: PhotoGalleryViewImpl {
    
    func setPresenter(_ presenter: PhotoGalleryViewAction) {
        self.presenter = presenter
    }
    
}

//MARK: - CollectionDelegate

extension PhotoGalleryView: UICollectionViewDelegate {
    
}

//MARK: - CollectionDataSource

extension PhotoGalleryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryViewCell.reuseId, for: indexPath) as? PhotoGalleryViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    
}

