//
//  TracksCollectionViewCell.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 03.06.2022.
//

import UIKit

class TracksCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var trackLabel: UILabel!
    
    func config(song: Song) {
        trackLabel.text = song.trackName
    }
}
