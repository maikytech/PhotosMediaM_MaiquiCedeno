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
    
    
    func getAlbumsResponse(sucess: @escaping(_ albums: [Album])->(), failure: @escaping(_ error: Error?)->()) {
        
        let url = "\(kBaseUrl)albums"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOK).responseDecodable (of: [Album].self) { response  in
            
            if let albums = response.value {
                sucess(albums)
            }else {
                failure(response.error)
                
            }
        }
    }
    
    func getPhotosResponse(sucess: @escaping(_ photos: [Photo])->(), failure: @escaping(_ error: Error?)->()) {
        
        let url = "\(kBaseUrl)photos"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOK).responseDecodable (of: [Photo].self) { response  in
            
            if let photos = response.value {
                sucess(photos)
            }else {
                failure(response.error)
            }
        }
    }
}
    
