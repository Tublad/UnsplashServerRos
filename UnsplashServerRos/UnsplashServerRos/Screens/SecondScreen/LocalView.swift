//
//  LocalView.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 04.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

protocol LocalViewImpl {
    //функции типа, покажи данные
    func setPresenter(_ presenter: LocalViewAction)
}


final class LocalView: UIView {
    
    var pictures: Picture?
    
    //MARK: - Private properties
    private var presenter: LocalViewAction?
    
    private var screenSize: CGRect!
    private var screenWidth: CGFloat!
    private var screenHeight: CGFloat!
    
    lazy var collectionView: UICollectionView = {
        // setting size
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: screenWidth / 4, height: screenWidth / 4)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MainCollectionViewCell.nib, forCellWithReuseIdentifier: MainCollectionViewCell.reuseId)
        
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
        setupCollectionView()
     // to do ...
    }
    
    private func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension LocalView: LocalViewImpl {
    
    func setPresenter(_ presenter: LocalViewAction) {
        self.presenter = presenter
    }
    
}

//MARK: - CollectionDelegate
extension LocalView: UICollectionViewDelegate {
    // to do выбор ячейки для выделения, в общий массив и сохранение фотографий на локальный диск списком
}

//MARK: - CollectionDataSource
extension LocalView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictures?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseId, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let size = screenWidth / 4
        cell.configurationCell(size)
        
        if let smallImage = pictures?[indexPath.row].urls.small,
            let url = URL(string: smallImage) {
            DataProvider.shared.downloadImageUrl(url: url) { (image) in
                cell.imageView.image = image
            }
        }
        
        return cell
    }
}


