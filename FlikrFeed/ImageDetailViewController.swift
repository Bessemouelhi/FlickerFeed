//
//  ImageDetailViewController.swift
//  FlikrFeed
//
//  Created by Apple on 24/03/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit


class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        //imageView.image = image
        let url = URL(string: self.url!)
        
        let data = try? Data(contentsOf: url!)
        imageView.image = UIImage(data: data!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
