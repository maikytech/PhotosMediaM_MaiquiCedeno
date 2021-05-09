//
//  ViewController.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 8/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var dataSource = [Album]()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func getAlbumAction(_ sender: Any) {
        NetworkingProvider.shared.getAlbum { (albums) in
            self.dataSource = albums
            print(self.dataSource)
        } failure: { (error) in
            print(error.debugDescription)
        }
    }
}

