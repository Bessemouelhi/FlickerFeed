//
//  FlikrImageCollectionViewController.swift
//  FlikrFeed
//
//  Created by Apple on 24/03/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

private let reuseIdentifier = "image_cell"

class FlickrImageCollectionViewController: UICollectionViewController {
    
    let queue1 = DispatchQueue(label: "com.mycompany.app.myqueue.1", qos: .userInitiated)
    let queue2 = DispatchQueue(label: "com.mycompany.app.myqueue.2", qos: .background)
    
    var flickrPhotos: [Photo] = []
    var urlArray: [String] = []
    var urlArraySmall: [String] = []
    var tag: String?
    var number: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FlickrService.sharedInstance.getPhotos(forTag: tag!, forNumber: number!) {
            (photos: [Photo]) in
            DispatchQueue.main.async {
                self.flickrPhotos = photos
                self.collectionView!.reloadData()
                
                for img in self.flickrPhotos {
                    //print("********* url *********", img.getUrl_small())
                    self.urlArraySmall.append(img.getUrl_small())
                    self.urlArray.append(img.getUrl(size: "c"))
                    
                }
                print("queue 1 : done")
            }
        }
        
        
        print(self.flickrPhotos)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "image_detail_segue" {
            if let imageDetailController = segue.destination as? ImageDetailViewController {
                
                guard let cell = sender as? ImageCollectionViewCell else {
                    print("error")
                    return
                }
                
                //imageDetailController.image = cell.imageView.image!
                imageDetailController.url = cell.url
            }
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return flickrPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        let urlString = URL(string: self.urlArraySmall[indexPath.row])
        
        if let url = urlString {
            let urlTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error ?? "error urlTask")
                } else {
                    if let usableData = data {
                        DispatchQueue.main.async {
                            cell.imageView.image = UIImage(data: usableData)
                            cell.lblTitle.text = self.flickrPhotos[indexPath.row].title
                            cell.url = self.urlArray[indexPath.row]
                            
                            print("queue 2 . \(indexPath.row) : done")
                        }
                    }
                }
            }
            urlTask.resume()
        }
        
        
        
        //let url = URLSession(string: self.urlArraySmall[indexPath.row])
        
        
        //let data = try? Data(contentsOf: url!)
        
        
        
        //}
        
        //print(image ?? "error")
        //print("usableData \(usableData)")
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
