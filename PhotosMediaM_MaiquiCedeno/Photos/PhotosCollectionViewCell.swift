//
//  PhotosCollectionViewCell.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 9/05/21.
//

import UIKit
import Kingfisher

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .white
        photoTitleLabel.font = .boldSystemFont(ofSize: 12)
        photoTitleLabel.textColor = .blue
        photoIDLabel.font = .boldSystemFont(ofSize: 16)
        photoIDLabel.textColor = .black
        
    }
    
    func setupCellWithImage(url: String) {
        photoImage.kf.setImage(with: URL(string: url))
    }

}
