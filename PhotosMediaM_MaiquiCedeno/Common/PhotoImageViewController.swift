//
//  PhotoImageViewController.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 10/05/21.
//

import UIKit
import SVProgressHUD

class PhotoImageViewController: UIViewController {
    
    //MARK: - IBOulets

    @IBOutlet weak var photoImageCollectionView: UICollectionView!
    
    //MARK: - Public vars
    public var photoID:Int = 0
    
    //MARK: - Private vars
    private let photoCellWith = UIScreen.main.bounds.width
    private var dataSourcePhotos = [Photo]()
    private var photoSelected = [Photo]()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        getPhotos()
        
        photoImageCollectionView.dataSource = self
        print("el valor de photoID es \(photoID)")

//        photoImageCollectionView.register(UINib(nibName: "PhotoDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "photoDetailsCell")
        
        photoImageCollectionView.register(UINib(nibName: "PhotoDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photoImageCell")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.photoImageCollectionView.reloadData()
            self.findPhoto()
            SVProgressHUD.dismiss()
        }
    }
    
    private func getPhotos() {
        NetworkingProvider.shared.getPhotosResponse{ (photos) in
            self.dataSourcePhotos = photos
        } failure: { (error) in
            print(error.debugDescription)
        }
    }
    
    private func findPhoto() {
        for i in 0..<dataSourcePhotos.count {
            if(dataSourcePhotos[i].id == photoID) {
                photoSelected.append(dataSourcePhotos[i])
            }
        }
        
        print(photoSelected)
        print(photoSelected.count)
    }
}

//MARK: - UITableViewDataSource
extension PhotoImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoSelected.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoImageCell", for: indexPath) as? PhotoDetailsCollectionViewCell
        
        cell!.photoTitleLabel.text = photoSelected[indexPath.row].title
        cell!.photoIDLabel.text = String(photoSelected[indexPath.row].id)
        cell!.setupCellWithImage(url: photoSelected[indexPath.row].url)
        
        return cell!
    }
}

extension PhotoImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: photoCellWith, height: photoCellWith * 1.5)
    }
}

    

    


