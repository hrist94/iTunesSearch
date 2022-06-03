//
//  AlbumModel.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 03.06.2022.
//

import Foundation


struct Albums: Decodable, Equatable {
    let results: [Album]
}

struct Album: Decodable, Equatable {
    let artistName: String
    let collectionName: String
    let collectionId: Int
    let artworkUrl100: String?
    let trackCount: Int
    let releaseDate: String }

struct Songs: Decodable {
    let results: [Song]
}

struct Song: Decodable {
    let trackName: String?
}
