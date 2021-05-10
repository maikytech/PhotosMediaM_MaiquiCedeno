//
//  AlbumsCollectionViewCell.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 9/05/21.
//

import UIKit

class AlbumsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumLogoImage: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .white
        albumTitleLabel.font = .boldSystemFont(ofSize: 12)
        albumTitleLabel.textColor = .blue
        albumIDLabel.font = .boldSystemFont(ofSize: 16)
        albumIDLabel.textColor = .black
        
    }

}
