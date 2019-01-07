//
//  FavouritesViewController.swift
//  EnaqelTask
//
//  Created by unitlabs on 1/4/19.
//  Copyright © 2019 BestOffer. All rights reserved.
//

import UIKit
import Realm
import  RealmSwift

class FavouritesViewController: UIViewController {

    var movieList : Results<Movie>?;
    var reuseIdentifier = "FavouritesTableViewCell";
    @IBOutlet weak var resultTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

         resultTableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        let realm = try! Realm()
        movieList = realm.objects(Movie.self);
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(loadFav), name: Notification.Name("OpenFav"), object: nil)
        
    }
    
    @objc func loadFav(){
        let realm = try! Realm()
        movieList = realm.objects(Movie.self);
        self.resultTableView.reloadData();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true);
      
    }
    
    func showAlert(message : String){
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}
extension FavouritesViewController :  UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList!.count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FavouritesTableViewCell
        cell.title_movie.text = movieList![indexPath.row].Title;
        cell.date_label.text = movieList![indexPath.row].Released;
        var pictureUrl =  URL(string: movieList![indexPath.row].Poster);
        cell.movieImageView.sd_setImage(with: pictureUrl, placeholderImage: UIImage(named: "lory"));
        if( movieList![indexPath.row].imdbRating != "N/A"){
          cell.ratingBar.rating = Double(movieList![indexPath.row].imdbRating)!
        }
        cell.shareBtn.tag  = indexPath.row;
        
        cell.shareBtn.addTarget(self, action: #selector(FavouritesViewController.shareMovie(sender:)), for: .touchUpInside);
        
        cell.deleteBtn.tag  = indexPath.row;
        
        cell.deleteBtn.addTarget(self, action: #selector(FavouritesViewController.deleteMovie(sender:)), for: .touchUpInside);
        return cell;
   }
    
    @objc func deleteMovie(sender: UIButton){
        // delete this movie from db
        let realm = try! Realm();
        let movieObject = realm.objects(Movie.self).filter("Title = '" + self.movieList![sender.tag].Title + "'")
        
        try! realm.write {
            realm.delete(movieObject)
            
        }
        DispatchQueue.main.async {
            // self.movieList[sender.tag].isFav = true;
            self.showAlert(message: "This Movie deleted from favourite sucessfully");
            
            self.resultTableView.reloadData()
        }
    }
    
    @objc func shareMovie(sender: UIButton){
        
        let firstActivityItem = movieList![sender.tag].Title
        let secondActivityItem  = "Movie Release Date " +  movieList![sender.tag].Released;
        // If you want to put an image
        var posterImage : UIImageView = UIImageView.init(image: UIImage(named: "lory"));
        
        var pictureUrl =  URL(string: movieList![sender.tag].Poster);
        posterImage.sd_setImage(with: pictureUrl, placeholderImage: UIImage(named: "lory"));
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, posterImage], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.unknown
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            // delete this movie from db
            let realm = try! Realm();
             let movieObject = realm.objects(Movie.self).filter("Title = '" + self.movieList![indexPath.row].Title + "'")
            
                try! realm.write {
                    realm.delete(movieObject)
                
            }
            DispatchQueue.main.async {
                // self.movieList[sender.tag].isFav = true;
                self.showAlert(message: "This Movie deleted from favourite sucessfully");
                
                self.resultTableView.reloadData()
            }
            
        }
    }
}
