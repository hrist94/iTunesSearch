//
//  TrackTableViewCell.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 03.06.2022.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet var trackLabel: UILabel!
    
    
    func configure(song: Song) {
            trackLabel.text = song.trackName
    }
}
