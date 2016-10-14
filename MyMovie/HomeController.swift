//
//  HomeController.swift
//  MyMovie
//
//  Created by Hung Nguyen on 10/14/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit
protocol HomeDelegate{
    func didEndGetDataFromThemoviedb(movies:[Class_Movie])
    
}
class HomeController: NSObject {
    var eventHandler: HomeDelegate?
    
    
    private func getDataFromThemoviedb(urlString:String){
       
        let url = URL(string: urlString)
        
        if let url = url {
            let request = URLRequest(
                url: url,
                cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
                timeoutInterval: 10)
            let session = URLSession(
                configuration: URLSessionConfiguration.default,
                delegate: nil,
                delegateQueue: OperationQueue.main)
            let task = session.dataTask(
                with: request,
                completionHandler: { (dataOrNil, response, error) in
                    if let data = dataOrNil {
                        if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                            print("response: \(responseDictionary)")
                            if let moviesData = responseDictionary["results"] as? [NSDictionary] {
                                self.parseDataForObjective(dictionary: moviesData)
                                
                            }
                        }
                    }
            })
            task.resume()
        }

    }
    
    public func getMoviesWithType(movieType:MovieType){
        var urlString = ""
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        switch movieType {
        case .AllList:
            urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)"
            break
        case .TopRate:
            urlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)"
            break
        default:
            break
        }
        self.getDataFromThemoviedb(urlString: urlString)
    }
    
    func parseDataForObjective(dictionary:[NSDictionary]){
        var movies:[Class_Movie] =  [Class_Movie] ()
        for dict in dictionary{
            let movie: Class_Movie = Class_Movie()
            if let  title = ( dict as! [String : AnyObject])["title"] as? String{
                movie.title = title
            }
            if let  overview = (dict as! [String : AnyObject])["overview"] as? String{
                movie.overview = overview
                
            }
            
            if let  imgUrl = (dict as! [String : AnyObject])["poster_path"] as? String{
                movie.imageUrl = "http://image.tmdb.org/t/p/w500" + imgUrl
                
            }
            
            if let  date = (dict as! [String : AnyObject])["release_date"] as? String{
                movie.date = date
                
            }
            
            movies.append(movie)
            
        }
        
        if self.eventHandler?.didEndGetDataFromThemoviedb != nil{
            self.eventHandler?.didEndGetDataFromThemoviedb(movies: movies)
        }

    }
    
}

enum MovieType:Int{
    case AllList = 1
    case TopRate = 2
}
