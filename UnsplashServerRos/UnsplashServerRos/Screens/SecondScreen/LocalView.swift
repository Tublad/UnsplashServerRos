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
    func getContent(_ picture: Picture)
}


final class LocalView: UIView {
    
    //MARK: - Private properties
    private var presenter: LocalViewAction?
    private var savePicture: Picture?
    private var buttonRow: Int = 0
    private var saveIndexPath: IndexPath = IndexPath()
    private var myCounter = 0
    private var myTimer : Timer = Timer()
    
    private var screenSize: CGRect!
    private var screenWidth: CGFloat!
    private var screenHeight: CGFloat!
    private var sourceView: UIView?
    
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
        collectionView.allowsMultipleSelection = true
        collectionView.isUserInteractionEnabled = true 
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(LocalCollectionViewCell.nib, forCellWithReuseIdentifier: LocalCollectionViewCell.reuseId)
        
        self.addSubview(collectionView)
        return collectionView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Save"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 100)
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 1.5, height: 1.5)
        label.alpha = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    }
    
    private func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        collectionView.addSubview(title)
        
        title.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
    }
    
    private func getContentForGalleryView() {
        guard let listImage = savePicture,
            let view = sourceView else { return }
        self.presenter?.sourceView(view: view, picture: listImage, count: buttonRow)
    }
    
    @objc func deleteImage(_ sender: UIButton) {
        guard let imageList = savePicture else { return }
        var count = 0
        print("Столько прошли, чтоб можно было удалить фотографию нашу\(count)")
        print("По этому значению нужно удалить кнопку \(sender.tag)")
        for value in imageList {
            if value.id == savePicture?[sender.tag].id {
                DispatchQueue.main.async {
                    self.savePicture?.remove(at: count)
                    self.collectionView.reloadData()
                }
                return
            } else {
                count += 1
            }
        }
    }
    
    @objc func savePhotoInPhone(_ sender: UIButton) {
        
        guard let fullImage = savePicture?[sender.tag].urls.full,
            let id = savePicture?[sender.tag].id,
            let url = URL(string: fullImage) else { return }
        
        DataProvider.shared.downloadImageUrl(id: id, url: url) { [weak self] (image) in
            if image != nil {
                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                self?.title.alpha = 1
                UIView.animate(withDuration: 0.5, animations: {
                    self?.title.alpha = 0
                }, completion: nil)
            }
        }
    }
}

extension LocalView: LocalViewImpl {
    
    func setPresenter(_ presenter: LocalViewAction) {
        self.presenter = presenter
    }
    
    func getContent(_ picture: Picture) {
        self.savePicture = picture
    }
    
    @objc func imageTapped(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            return
        }
        let imageView = sender.view as! UIImageView
        let oldFrame = sender.location(in: self)
        
        let newImageView = UIImageView(image: imageView.image)
        newImageView.alpha = 0
        newImageView.frame = CGRect(x: oldFrame.x, y: oldFrame.y, width: imageView.frame.width, height: imageView.frame.height)
        
        UIView.animate(withDuration: 0.5,
                       animations: {
                        
                        newImageView.transform = .identity
                        newImageView.alpha = 1
                        newImageView.frame = UIScreen.main.bounds
                        newImageView.backgroundColor = .black
                        newImageView.contentMode = .scaleAspectFit
                        newImageView.isUserInteractionEnabled = true
                        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullscreenImage))
                        newImageView.addGestureRecognizer(tap)
                        self.addSubview(newImageView)
                        
        }, completion: nil)
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
}

//MARK: - CollectionDelegate
extension LocalView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        buttonRow = indexPath.row
    }
    
}

//MARK: - CollectionDataSource
extension LocalView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        savePicture?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocalCollectionViewCell.reuseId, for: indexPath) as? LocalCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let smallImage = savePicture?[indexPath.row].urls.small,
            let id = savePicture?[indexPath.row].id,
            let url = URL(string: smallImage) {
            DataProvider.shared.downloadImageUrl(id: id, url: url) { [weak self] (image) in
                if id == id {
                    cell.imageView.image = image
                }
            }
        }
        
        cell.deleteImageButton.tag = indexPath.row
        cell.deleteImageButton.addTarget(self, action: #selector(deleteImage), for: .touchUpInside)
        
        cell.saveImageButton.tag = indexPath.row
        cell.saveImageButton.addTarget(self, action: #selector(savePhotoInPhone), for: .touchUpInside)
        
        
        cell.imageClicked = { [weak self] image in
            self?.sourceView = image
            self?.getContentForGalleryView()
        }
        
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(imageTapped))
        longTap.minimumPressDuration = 0.5
        cell.imageView.addGestureRecognizer(longTap)
        
        return cell
    }
}

