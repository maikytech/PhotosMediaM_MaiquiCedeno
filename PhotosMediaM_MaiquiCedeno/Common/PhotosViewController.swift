//
//  PhotosViewController.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 9/05/21.
//

import UIKit
import SVProgressHUD
import Kingfisher

class PhotosViewController: UIViewController {

    //MARK: - IBOulets
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    //MARK: - Private vars
    private let photoCellWith = UIScreen.main.bounds.width  / 2
    private var dataSourcePhotos = [Photo]()
    private var photosByAlbum = [Photo]()
    
    public var albumID:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        
        getPhotos()
        
        photosCollectionView.register(UINib(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.photosCollectionView.reloadData()
            self.photosInEachAlbum()
            SVProgressHUD.dismiss()
        }
        
        print("El valor de albumID es: \(albumID)")
    }
    
    private func getPhotos() {
        NetworkingProvider.shared.getPhotosResponse{ (photos) in
            self.dataSourcePhotos = photos
        } failure: { (error) in
            print(error.debugDescription)
        }
    }
    
    private func photosInEachAlbum() {
        
        print("La cantidad de pothos es : \(dataSourcePhotos.count)")
        print("El albumID de dataSourcePhotos[0] es: \(dataSourcePhotos[0].albumId)")
        for i in 0..<dataSourcePhotos.count {
            if(dataSourcePhotos[i].albumId == 1) {
                photosByAlbum.append(dataSourcePhotos[i])
            }
        }
        
        print("La cantidad de photos en este album es: \(photosByAlbum.count)")
    }
}

//MARK: - UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return photosByAlbum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotosCollectionViewCell
        
        cell!.photoTitleLabel.text = photosByAlbum[indexPath.row].title
        cell!.photoIDLabel.text = String(photosByAlbum[indexPath.row].id)
        cell!.setupCellWithImage(url: photosByAlbum[indexPath.row].thumbnailUrl)
        
        return cell!
    }
}

//MARK: - UICollectionViewDelegate
extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Se selecciono una foto")
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: photoCellWith, height: photoCellWith)
    }
}

