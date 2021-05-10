//
//  Photos.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 9/05/21.
//

import Foundation

//{
//    "albumId": 1,
//    "id": 1,
//    "title": "accusamus beatae ad facilis cum similique qui sunt",
//    "url": "https://via.placeholder.com/600/92c952",
//    "thumbnailUrl": "https://via.placeholder.com/150/92c952"
//  },

struct Photo: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
