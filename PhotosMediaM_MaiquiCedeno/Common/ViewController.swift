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
    private var dataSource = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumsCollectionView.dataSource = self
        
    }

    //MARK: - IBActions
    @IBAction func getAlbumAction(_ sender: Any) {
        NetworkingProvider.shared.getAlbum { (albums) in
            self.dataSource = albums
            print(self.dataSource)
        } failure: { (error) in
            print(error.debugDescription)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath)
    }
    
    
}

