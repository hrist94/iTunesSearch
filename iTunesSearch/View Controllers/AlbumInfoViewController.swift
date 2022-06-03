//
//  AlbumInfoViewController.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 03.06.2022.
//

import UIKit

class AlbumInfoViewController: UIViewController {
//MARK: - Properties
    
    var album: Album?
    var songs = [Song]()
    
//MARK: - Outlets
    @IBOutlet var imageAlbum: UIImageView!
    @IBOutlet var albumName: UILabel!
    @IBOutlet var artistName: UILabel!
    @IBOutlet var yearAlbum: UILabel!
    @IBOutlet var songsTableView: UITableView!
    
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setView(album: album)
        fetchSongs(album: album)
    }
//MARK: - Private funcs
    private func setView(album: Album?) {
        guard let album = album else { return }
        NetworkManager.shared.fetchImage(album: album, imageView: imageAlbum)
        albumName.text = album.collectionName
        artistName.text = album.artistName
        let index = album.releaseDate.firstIndex(of: "T") ?? album.releaseDate.endIndex
        let date = album.releaseDate[..<index]
        yearAlbum.text = String(date)
    }
    private func fetchSongs(album: Album?) {
        guard let album = album else { return }
        let id = album.collectionId
        let urlSongs = "https://itunes.apple.com/lookup?id=\(id)&entity=song"
        NetworkManager.shared.fetchSongs(urlSongs) { [weak self] songsData, error in
            if error == nil {
                guard let songData = songsData else { return }
                self?.songs = songData.results
                self?.songsTableView.reloadData()
            } else {
                print(error?.localizedDescription ?? "")
            }
        }

    }
}
//MARK: - Extensions

extension AlbumInfoViewController: UITableViewDataSource, UICollectionViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TrackTableViewCell
        let song = songs[indexPath.row]
        cell.configure(song: song)
        return cell
    }
}
