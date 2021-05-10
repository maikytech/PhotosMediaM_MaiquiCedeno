//
//  PhotosViewController.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 9/05/21.
//

import UIKit
import SVProgressHUD

class PhotosViewController: UIViewController {

    //MARK: - IBOulets
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    //MARK: - Private vars
    private let photoCellWith = UIScreen.main.bounds.width  / 2
    private var dataSourcePhotos = [Photo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        
        getPhotos()
        photosCollectionView.register(UINib(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.photosCollectionView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    private func getPhotos() {
        NetworkingProvider.shared.getPhotosResponse{ (photos) in
            self.dataSourcePhotos = photos
            print(self.dataSourcePhotos)
        } failure: { (error) in
            print(error.debugDescription)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return dataSourcePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotosCollectionViewCell
        
        cell!.photoTitleLabel.text = dataSourcePhotos[indexPath.row].title
        cell!.photoIDLabel.text = String(dataSourcePhotos[indexPath.row].id)
        
        return cell!
    }
}

//MARK: - UICollectionViewDelegate
extension PhotosViewController: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: photoCellWith, height: photoCellWith)
    }
}

