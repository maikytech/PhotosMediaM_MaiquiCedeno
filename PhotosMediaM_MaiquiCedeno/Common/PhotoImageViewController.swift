//
//  PhotoImageViewController.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 10/05/21.
//

import UIKit
import SVProgressHUD
import Kingfisher

class PhotoImageViewController: UIViewController {
    
    //MARK: - IBOulets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoIdLabel: UILabel!
    
    //MARK: - Public vars
    public var photoID:Int = 0
    
    //MARK: - Private vars
    private var url = ""
    private var dataSourcePhotos = [Photo]()
    private var photoSelected = [Photo]()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        getPhotos()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.findPhoto()
            self.setupUI()
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
    
    private func findPhoto() {
        for i in 0..<dataSourcePhotos.count {
            if(dataSourcePhotos[i].id == photoID) {
                photoSelected.append(dataSourcePhotos[i])
            }
        }
    }
    
    func setupUI() {
        let url = photoSelected[0].url
        photoImageView.kf.setImage(with: URL(string: url ))
        photoTitleLabel.text = photoSelected[0].title
        photoIdLabel.text = String(photoSelected[0].id)
    }
}

