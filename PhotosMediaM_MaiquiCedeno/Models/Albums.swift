//
//  Albums.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 8/05/21.
//

import Foundation

//struct DataSource:Decodable {
//    let albums:[Album]?
//}

struct Album: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
}

