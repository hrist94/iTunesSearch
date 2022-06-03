//
//  NetworkManager.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 02.06.2022.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(_ url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
    func fetchAlbums(_ url: String, response: @escaping (Albums?, Error?) -> Void) {
        NetworkManager.shared.fetchData(url) { result in
            switch result {
            case .success(let data):
                do {
                    let albums = try JSONDecoder().decode(Albums.self, from: data)
                    response(albums, nil)
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                response(nil, error)
            }
        }
    }
    
    func fetchImage(album: Album, imageView: UIImageView) {
        guard let url = album.artworkUrl100 else { return }
        NetworkManager.shared.fetchData(url) { result in
            switch result {
            case .success(let data):
                imageView.image = UIImage(data: data)
            case .failure(let error):
                imageView.image = nil
                print(error.localizedDescription)
            }
        }
    }
 
    func fetchSongs(_ url: String, response: @escaping (Songs?, Error?) -> Void) {
        NetworkManager.shared.fetchData(url) { result in
            switch result {
            case .success(let data):
                do {
                    let songs = try JSONDecoder().decode(Songs.self, from: data)
                    response(songs, nil)
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                response(nil, error)
            }
        }
    }
}

