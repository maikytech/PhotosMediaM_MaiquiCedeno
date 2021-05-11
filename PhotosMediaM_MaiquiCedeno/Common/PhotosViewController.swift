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
    
    //MARK: - Public varS
    public var albumID:Int = 0
    
    //MARK: - Private vars
    private let photoCellWith = UIScreen.main.bounds.width  / 2
    private var dataSourcePhotos = [Photo]()
    private var photosByAlbum = [Photo]()
    
    //MARK: - viewDidLoad
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
    }
    
    //MARK: - Private Methods
    private func getPhotos() {
        NetworkingProvider.shared.getPhotosResponse{ (photos) in
            self.dataSourcePhotos = photos
        } failure: { (error) in
            print(error.debugDescription)
        }
    }
    
    private func photosInEachAlbum() {
        for i in 0..<dataSourcePhotos.count {
            if(dataSourcePhotos[i].albumId == albumID) {
                photosByAlbum.append(dataSourcePhotos[i])
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPhotoImage" {
            if let vCDestiny = segue.destination as? PhotoImageViewController {
                if let index = sender as? Int {
                    let value = photosByAlbum[index].id
                    vCDestiny.photoID = value
                }
            }
        }
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
        
        performSegue(withIdentifier: "goToPhotoImage", sender: indexPath.item)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: photoCellWith, height: photoCellWith)
    }
}

