//
//  FlickrService.swift
//  FlikrFeed
//
//  Created by Apple on 30/03/2017.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation

private let API_KEY = "18dfedb92a573089afd432d36ce4e7fa"

enum FlickrServiceError: Error {
    case apiMethodCall
    case noDataFound
    //case insufficientFunds(coinsNeeded: Int)
    case jsonDeserialization
    case invalidData
}


class FlickrService {
    
    static let sharedInstance: FlickrService = FlickrService()
    
    var session = URLSession.shared
    var myFlickrPhotos: [Photo]
    let queue1 = DispatchQueue(label: "com.mycompany.app.myqueue.1", qos: .userInitiated)
    
    
    private init() {
        myFlickrPhotos = []
    }
    
    /*
     FlickrService.sharedInstance.connectTo(url: TabPicture[indexPath.row].getURLMini()){
    (data : Data) in
    DispatchQueue.main.async {
    cell.imageView.image = UIImage(data: data)
    }
    
    func connectTo(url : String, callback: @escaping (_ data: Data)-> Void){
     */
    
    func getPhotos(apiKey: String, forTag tag: String, forNumber number: Int, callback: @escaping (_ photos: [Photo]) -> Void) {
        
        //let api_key = "79b0d968c81ad7b36523226844a4d110"
        //let auth_token = "72157681966582195-5bfb7b61ef92190f"//\(auth_token)
        var search: String = "all"
        if tag != "" {
            search = tag
        }
        
        let urlString = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&tags=\(search)&per_page=\(number)&page=3&format=json&nojsoncallback=1")
        
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error ?? "error feed")
                } else {
                    if let usableData = data {
                        let json = try? JSONSerialization.jsonObject(with: usableData, options: []) as! [String : Any]
                        //print("********* json ********* : \(json)")
                        
                        guard let photos = json?["photos"] as? [String: Any] else {
                            print("error no photos")
                            return
                        }
                        
                        //print("********* images ********* : \(photos)")
                        
                        guard let photo = photos["photo"] as? [[String: Any]] else {
                            print("error no images")
                            return
                        }
                        
                        //print("*** image *** : \(photo)")
                        
                        let myFlickrPhotos = photo.map {
                            Photo(
                                farm: $0["farm"] as! Int,
                                id: $0["id"] as! String,
                                isfamily: $0["isfamily"] as! Bool,
                                isfriend: $0["isfriend"] as! Bool,
                                ispublic: $0["ispublic"] as! Bool,
                                owner: $0["owner"] as! String,
                                secret: $0["secret"] as! String,
                                server: $0["server"] as! String,
                                title: $0["title"] as! String)
                        }
                        
                        callback(myFlickrPhotos)
                        
                        //print("********* flickrPhotos *********", self.myFlickrPhotos)
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    /*func getCollectionPhoto(nbPhoto: Int) -> [Photo] {
        getPhotos()
        
        if nbPhoto == 60 {
            print("********* self.flickrPhotos *********", self.myFlickrPhotos)
            
            return self.myFlickrPhotos
        }
        else {
            return []
        }
        
        
        
    }*/
    
    private func urlBuilder(query: [String:String]) -> URL {
        var requestURL = "https://api.flickr.com/services/rest/?format=json&nojsoncallback=1&api_key=\(API_KEY)"
        
        for (param,value) in query {
            requestURL += "&" + param + "=" + value
        }
        
        print(requestURL)
        return URL(string: requestURL)!
    }
}

