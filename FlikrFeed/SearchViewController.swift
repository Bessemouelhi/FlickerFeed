//
//  SearchViewController.swift
//  FlikrFeed
//
//  Created by Apple on 30/03/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var numberStepper: UIStepper!
    
    var tag: String?
    var number: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberField.keyboardType = UIKeyboardType.numberPad
        numberStepper.wraps = true
        numberStepper.autorepeat = true
        numberStepper.maximumValue = 500
        
        // Initialize value of stepper
        let value = numberField.text!
        numberStepper.value = Double(value)!

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onNumberStepper(_ sender: UIStepper) {
        numberField.text = String(Int(sender.value))
    }

    @IBAction func onChangedValueNumber(_ sender: UITextField) {
        var value = sender.text!
        if value == "0" {
            value = "1"
            numberField.text = value
            numberField.reloadInputViews()
        }
        numberStepper.value = Double(value)!
    }
    
    @IBAction func onSearchButton(_ sender: Any) {
        tag = searchField.text
        number = Int(numberField.text!)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search_images_segue" {
            if let imagesCollectionController = segue.destination as? FlickrImageCollectionViewController {
                imagesCollectionController.tag = tag!
                imagesCollectionController.number = number!
            }
        }

    }
    

}
