//
//  ViewController.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 8/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOulets
    @IBOutlet weak var albumsCollectionView: UICollectionView!
    
    //MARK: - Private vars
    private let albumCellWith = UIScreen.main.bounds.width  / 2
    private var dataSource = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        albumsCollectionView.dataSource = self
        albumsCollectionView.delegate = self
        
        getAlbums()
        albumsCollectionView.register(UINib(nibName: "AlbumsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "albumCell")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.albumsCollectionView.reloadData()
        }
    }
    
    private func getAlbums() {
        NetworkingProvider.shared.getAlbumsResponse{ (albums) in
            self.dataSource = albums
        } failure: { (error) in
            print(error.debugDescription)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as? AlbumsCollectionViewCell
        
        cell!.albumTitleLabel.text = dataSource[indexPath.row].title
        cell!.albumIDLabel.text = String(dataSource[indexPath.row].id)
        
        return cell!
    }
}

//MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: albumCellWith, height: albumCellWith)
    }
}
