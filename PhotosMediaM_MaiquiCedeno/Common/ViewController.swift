//
//  ViewController.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 8/05/21.
//

import UIKit
import RevealingSplashView

class ViewController: UIViewController {
    
    //MARK: - IBOulets
    @IBOutlet weak var albumsCollectionView: UICollectionView!
    
    //MARK: - Private vars
    private let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "Logo_PosetoStudio")!, iconInitialSize: CGSize(width: 128, height: 128), backgroundColor: UIColor.white)
    private let albumCellWith = UIScreen.main.bounds.width  / 2
    private var dataSource = [Album]()
    private var dataSourcePhotos = [Photo]()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.launchScreenConfig(revealingSplashView: revealingSplashView)

        albumsCollectionView.dataSource = self
        albumsCollectionView.delegate = self
        getAlbums()
        albumsCollectionView.register(UINib(nibName: "AlbumsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "albumCell")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.albumsCollectionView.reloadData()
        }
    }
    
    //MARK: - Private Methods
    private func launchScreenConfig(revealingSplashView: RevealingSplashView) {
        
        self.view.addSubview(revealingSplashView)
        self.revealingSplashView.animationType = SplashAnimationType.popAndZoomOut
        self.revealingSplashView.startAnimation()
    }
    
    private func getAlbums() {
        NetworkingProvider.shared.getAlbumsResponse{ (albums) in
            self.dataSource = albums
        } failure: { (error) in
            print(error.debugDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPhotos" {
            if let vCDestiny = segue.destination as? PhotosViewController {
                if let index = sender as? Int {
                    let value = dataSource[index].id
                    vCDestiny.albumID = value
                }
            }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToPhotos", sender: indexPath.item)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: albumCellWith, height: albumCellWith)
    }
}
