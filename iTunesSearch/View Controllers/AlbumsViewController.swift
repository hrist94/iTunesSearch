//
//  AlbumsViewController.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 01.06.2022.
//

import UIKit

class AlbumsViewController: UITableViewController {

//MARK: - Properties
    
    var albums: [Album] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
//MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 124
        setSearchBar()
    }
    
// MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AlbumsTableViewCell
        let album = albums[indexPath.row]
        cell.configureCell(album: album)
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let album = albums[indexPath.row]
        let albumInfoVC = segue.destination as! AlbumInfoViewController
        albumInfoVC.album = album
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        
        UserDefaults.standard.setValue(false, forKey: "isLogin")
                let storyboard = UIStoryboard(name: "AlbumsView", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "logInVC")
        viewController.modalPresentationStyle = .overFullScreen
                present(viewController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
//MARK: - Private funcs
    private func setSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    
    private func fetchAlbum(_ name: String) {
        
        let url = "https://itunes.apple.com/search?term=\(name)&entity=album&attribute=albumTerm"
        print(url)
        
        NetworkManager.shared.fetchAlbums(url) { [weak self] albumsData, error in
            if error == nil {
                guard let album = albumsData else { return }
                let sortedAlbums = album.results.sorted { first, second in
                    return first.collectionName.compare(second.collectionName) == ComparisonResult.orderedAscending
                }
                self?.albums = sortedAlbums
                self?.tableView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
    }

}
//MARK: - Extensions
extension AlbumsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if text != "" {
            fetchAlbum(text!)
        }
    }
}
