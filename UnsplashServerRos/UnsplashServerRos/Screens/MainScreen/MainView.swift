
import UIKit


protocol MainViewImpl {
    //функции типа, покажи данные
    func setPresenter(_ presenter: MainViewAction)
    func getContent(_ content: Picture)
}


final class MainView: UIView {
    
    var pictures: Picture?
    
    //MARK: - Private properties
    private var presenter: MainViewAction?
    
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
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .prominent
        searchBar.delegate = self
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
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
        setupSearchBar()
        setupCollectionView()
     // to do ...
    }
    
    private func setupSearchBar() {
        self.addSubview(searchBar)
        
        searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    private func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 2).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension MainView: MainViewImpl {
    
    func getContent(_ content: Picture) {
        self.pictures = content
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }  
    }
    
    func setPresenter(_ presenter: MainViewAction) {
        self.presenter = presenter
    }
    
    @objc func savePictureInDatabase(_ sender: UIButton) {
        print("Пытаюсь сохранить изображение")
    }
}

//MARK: - CollectionDelegate
extension MainView: UICollectionViewDelegate {
    
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
        
        let size = screenWidth / 4
        cell.configurationCell(size)
        
        if let smallImage = pictures?[indexPath.row].urls.small,
            let url = URL(string: smallImage) {
            ImageLoader.image(for: url) { (image) in
                cell.imageView.image = image
            }
        }
        
        cell.saveImageButton.addTarget(self, action: #selector(savePictureInDatabase), for: .touchDown)
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
        // to do get image in searhText
        print("to do")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.endEditing(true)
    }
}
