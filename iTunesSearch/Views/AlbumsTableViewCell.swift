//
//  AlbumsTableViewCell.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 03.06.2022.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {

    @IBOutlet var imageAlbum: UIImageView!
    @IBOutlet var albumNameLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var numberOfTracks: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(album: Album) {
        albumNameLabel.text = album.collectionName
        artistNameLabel.text = album.artistName
        numberOfTracks.text = String(album.trackCount) + " tracks"
        NetworkManager.shared.fetchImage(album: album, imageView: imageAlbum)
        
    }
}
