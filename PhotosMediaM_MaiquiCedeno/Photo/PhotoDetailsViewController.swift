//
//  PhotoDetailsViewController.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 10/05/21.
//

import UIKit
import SVProgressHUD

class PhotoDetailsViewController: UIViewController {
    @IBOutlet weak var photoTableView: UITableView!
    
    private var dataSourcePhotos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        photoTableView.dataSource = self
        getPhotos()
//        photoTableView.register(UINib(nibName: "PhotoDetailsTableViewCell", bundle: nil), forCellWithReuseIdentifier: "photoDetailsCell")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.photoTableView.reloadData()
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

extension PhotoDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCellDetails", for: indexPath) as? PhotoDetailsTableViewCell
        
        cell!.photoTitleLabel.text = dataSourcePhotos[indexPath.row].title
        cell!.photoIDLabel.text = String(dataSourcePhotos[indexPath.row].id)
        cell!.setupCellWithImage(url: dataSourcePhotos[indexPath.row].url)
        
        return cell!
    }
    
    
}
