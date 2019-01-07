//
//  SearchViewController.swift
//  EnaqelTask
//
//  Created by unitlabs on 1/4/19.
//  Copyright © 2019 BestOffer. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SDWebImage
import RealmSwift
import SVProgressHUD


class SearchViewController: UIViewController {
    
    @IBOutlet weak var edtSearch: UITextField!
    
    
    @IBOutlet weak var resultTableView: UITableView!
    var searchUrl = "";
    var searchText = "";
    var movieList : [Movie] = [];
    var reuseIdentifier = "SearchTableViewCell";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
   
    
   
    @IBAction func SearchMovieByName(_ sender: UIButton) {
        if(edtSearch.text != ""){
           
            searchText = edtSearch.text!
            searchUrl = "http://www.omdbapi.com/?t=" + searchText + "&apikey=a204dcd3";
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.gradient)
            SVProgressHUD.show();
            searchMovieByName(title : edtSearch.text!);
        }
        else{
           
        }
    }
    
    func searchMovieByName(title : String){
        print(searchUrl);
    
        Alamofire.request(searchUrl).responseObject { (response: DataResponse<Movie>) in
            
            let movieResponse = response.result.value
            print(movieResponse?.Title);
            self.movieList = [];
            self.movieList.append(movieResponse!);
            SVProgressHUD.dismiss();
            self.resultTableView.reloadData();
           
        }
    }
    
    func showAlert(message : String){
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}


extension SearchViewController :  UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movieList.count;
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchTableViewCell
        cell.movie_title.text = movieList[indexPath.row].Title;
        cell.movie_date.text = movieList[indexPath.row].Released;
        var pictureUrl =  URL(string: movieList[indexPath.row].Poster);
        cell.movieImageView.sd_setImage(with: pictureUrl, placeholderImage: UIImage(named: "lory"));
        //cell.rating.text = movieList[indexPath.row].imdbRating;
        if( movieList[indexPath.row].imdbRating != "N/A"){
          cell.ratingBar.rating = Double(movieList[indexPath.row].imdbRating)!
         
        }
        if(movieList[indexPath.row].isFav){
             cell.addToFavBtn.setImage(UIImage(named: "icons8-star-filled-50"), for: .normal)
        }else{
            cell.addToFavBtn.setImage(UIImage(named: "icons8-star-filled-48"), for: .normal)

        }
        cell.addToFavBtn.tag = indexPath.row
        
        cell.addToFavBtn.addTarget(self, action: #selector(SearchViewController.AddToFav(sender:)), for: .touchUpInside)
        
        cell.shareBtn.tag  = indexPath.row;
        
        cell.shareBtn.addTarget(self, action: #selector(SearchViewController.shareMovie(sender:)), for: .touchUpInside);
        return cell;
    }
    
    @objc func shareMovie(sender: UIButton){
        let firstActivityItem = movieList[sender.tag].Title
        let secondActivityItem  = "Movie Release Date " +  movieList[sender.tag].Released;
        // If you want to put an image
       var posterImage : UIImageView = UIImageView.init(image: UIImage(named: "lory"));
        let pictureUrl =  URL(string: movieList[sender.tag].Poster);
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
    @objc func AddToFav(sender: UIButton){
        var movie = movieList[0];
        movie.Title = movieList[0].Title;
        movie.Actors = movieList[0].Actors;
        movie.Released = movieList[0].Released;
        movie.imdbRating = movieList[0].imdbRating;
        movie.Poster = movieList[0].Poster;
        print(movie.Title);

        let realm = try! Realm()
       var  favMovieList = realm.objects(Movie.self);
        var isExist = false;
        for item in favMovieList{
            if(item.Title == movie.Title){
                //exist before
                isExist = true;
                self.showAlert(message: "This Movie already favourite");
                break;
            }}
        if(!isExist)
        {
                try! realm.write() {
                    realm.add(movie);
                    self.movieList[sender.tag].isFav = true;

                }
            DispatchQueue.main.async {
               // self.movieList[sender.tag].isFav = true;
                self.showAlert(message: "This Movie added to favourite sucessfully");

                self.resultTableView.reloadData()
            }
       
            

            }
        
      
    }
    
}
