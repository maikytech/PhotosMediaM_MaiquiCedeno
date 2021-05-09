//
//  ViewController.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 8/05/21.
//

import UIKit

class ViewController: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }

    @IBAction func getAlbumAction(_ sender: Any) {
        
    }
    
    func getData() {
        NetworkingProvider.shared.getAlbum(id: 2)
    }
    
}

