//
//  TableViewCelld.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 03.06.2022.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet var trackLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(song: Song) {
        trackLabel.text = song.trackName
    }
}
