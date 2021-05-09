//
//  NetworkingProvider.swift
//  PhotosMediaM_MaiquiCedeno
//
//  Created by Maiqui Cedeño on 8/05/21.
//

import Foundation
import Alamofire

final class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    
    //MARK: - Keys
    private let kBaseUrl = "https://jsonplaceholder.typicode.com/"
    private let kStatusOK = 200...300
    
    func getAlbum(id: Int) {
        
        let url = "\(kBaseUrl)albums/\(id)"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOK).responseDecodable (of: Album.self) { response  in
            
            if let album = response.value {
                print(album)
            }else {
                print(response.error ?? "No error")
            }
        }
    }
}
    
