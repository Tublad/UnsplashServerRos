
import UIKit


protocol MainViewImpl {
    //функции типа, покажи данные
    func setPresenter(_ presenter: MainViewAction)
    func getContent(_ content: Picture)
    func saveListImage()
    func savePictureInLocal()
}

final class MainView: UIView {
    
    //MARK: - Open properties
    var pictures: Picture?
    
    //MARK: - Private properties
    private var presenter: MainViewAction?
    private var saveCountImage: Picture = Picture()
    private var buttonRow: Int = 0
    private var sourceView: UIView?
    private var pageCount: Int = 1
    private var sectionIndexes = IndexPath()
    private var reloadSectionIndex = [IndexPath]()
    private var searchTexting = String()
    private var previewRow: Int = 0
    
    private var screenSize: CGRect!
    private var screenWidth: CGFloat!
    private var screenHeight: CGFloat!
    
    private lazy var collectionView: UICollectionView = {
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: screenWidth / 4 , height: screenWidth / 4 )
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black
        collectionView.allowsMultipleSelection = true
        collectionView.isPagingEnabled = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MainCollectionViewCell.nib, forCellWithReuseIdentifier: MainCollectionViewCell.reuseId)
        
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
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .prominent
        searchBar.delegate = self
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        return recognizer
    }()
    
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
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
        setupSearchBar()
        setupCollectionView()
    }
    
    private func setupSearchBar() {
        self.addSubview(searchBar)
        
        searchBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        collectionView.addSubview(title)
        
        title.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
    }
    
    // MARK: - saveImage in list
    private func saveImage(index: Int) {
        if let picture = pictures?[index] {
            if saveCountImage.count == 0 {
                saveCountImage.append(picture)
            } else {
                var count = 0
                saveCountImage.contains { (value) -> Bool in
                    if value.id == picture.id {
                        count += 1
                        return true
                    } else {
                        return false
                    }
                }
                if count <= 0 {
                    saveCountImage.append(picture)
                }
            }
        }
    }
    // MARK: - delete Image in list
    private func deleteImage(index: Int) {
        if saveCountImage.count > 0 {
            if let picture = pictures?[index] {
                var count = 0
                for value in saveCountImage {
                    count += 1
                    if value.id == picture.id {
                        count -= 1
                        saveCountImage.remove(at: count)
                        if saveCountImage.isEmpty {
                            presenter?.deleteButtonSave()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Check image save in memory
    private func checkImageInLocalMemory(indexPath: IndexPath) -> Bool {
        var answer: Bool = false
        if saveCountImage.count == 0 {
        } else {
            if let id = pictures?[indexPath.row].id {
                for image in saveCountImage {
                    if id == image.id {
                        answer = true
                    }
                }
            }
        }
        return answer
    }
    
    private func getContentForGalleryView() {
        guard let listImage = pictures,
            let view = sourceView else { return }
        self.presenter?.sourceView(view: view, picture: listImage, count: buttonRow)
    }
    
    private func showNewPage(indexPath: IndexPath) {
        if indexPath.row != 0 && indexPath.row % 27 == 0 && indexPath.row + pageCount == pictures?.count {
            pageCount += 1
            UnsplashServer.getImageUnsplashServerForShow(pageCount) { [weak self] (pictureList, error) in
                if error != nil,
                    let error = error {
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self?.pictures?.append(contentsOf: pictureList)
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    private func showNewPageInSearch(indexPath: IndexPath) {
        if indexPath.row != 0 && indexPath.row % 27 == 0 && indexPath.row + pageCount == pictures?.count {
            pageCount += 1
            UnsplashServer.searchImageInUnsplashServer(pageCount, searchTexting) { [weak self] (pictureList, error) in
                if error != nil,
                    let error = error {
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self?.pictures?.append(contentsOf: pictureList.results)
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
}

extension MainView: MainViewImpl {
    
    func savePictureInLocal() {
        self.presenter?.showLocalViewController(picture: saveCountImage)
    }
    
    func saveListImage() {
        title.alpha = 1
        
        UIView.animate(withDuration: 2, animations: {
            self.title.alpha = 0
            self.collectionView.reloadItems(at: self.reloadSectionIndex)
            self.reloadSectionIndex = [IndexPath]()
            self.collectionView.reloadData()
        }, completion: nil)
        
        presenter?.deleteButtonSave()
    }
    
    func getContent(_ content: Picture) {
        self.pictures = content
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setPresenter(_ presenter: MainViewAction) {
        self.presenter = presenter
    }
    
    @objc func savePictureLocalMemory(_ sender: UIButton) {
        buttonRow = sender.tag
        saveImage(index: buttonRow)
        
        sender.setImage(UIImage(systemName:"checkmark"), for: .normal)
        sender.tintColor = .marineColor
        sender.isEnabled = false
        
        title.alpha = 1
        
        UIView.animate(withDuration: 2, animations: {
            self.title.alpha = 0
        })
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
extension MainView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.getButtonForSaveList()
        buttonRow = indexPath.row
        saveImage(index: indexPath.row)
        reloadSectionIndex.append(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        deleteImage(index: indexPath.row)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchTexting.isEmpty ? showNewPage(indexPath: sectionIndexes) : showNewPageInSearch(indexPath: sectionIndexes)
    }
    
}

//MARK: - CollectionDataSource
extension MainView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictures?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseId, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row % 27 == 0 {
            sectionIndexes = indexPath
        }
        
        if checkImageInLocalMemory(indexPath: indexPath) {
            cell.saveImageButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            cell.saveImageButton.isEnabled = false
        } else {
            cell.saveImageButton.tag = indexPath.row
            cell.saveImageButton.addTarget(self, action: #selector(savePictureLocalMemory), for: .touchUpInside)
        }
        
        if let smallImage = pictures?[indexPath.row].urls.small,
            let id = pictures?[indexPath.row].id,
            let url = URL(string: smallImage) {
            DataProvider.shared.downloadImageUrl(id: id, url: url) { [weak self] (image) in
                if id == id {
                    cell.imageView.image = image
                }
            }
        }
        
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

extension MainView: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchTexting = ""
            pageCount = 1
            self.presenter?.getImage()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        pageCount = 1
        self.presenter?.searchText(searchText)
        searchTexting = searchText
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.removeGestureRecognizer(tapRecognizer)
    }
}




