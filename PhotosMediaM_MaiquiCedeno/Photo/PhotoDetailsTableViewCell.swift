//
//  PhotoDetailsTableViewCell.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 10/05/21.
//

import UIKit

class PhotoDetailsTableViewCell: UITableViewCell {
  
  
    @IBOutlet weak var photoImageView: UIImageView!
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
        photoImageView.kf.setImage(with: URL(string: url))
    }
}
