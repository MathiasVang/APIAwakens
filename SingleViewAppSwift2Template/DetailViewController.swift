//
//  DetailViewController.swift
//  TheAPIAwakens
//
//  Created by Mathias Vang Rasmussen on 17/10/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var objectPicker: UIPickerView!
    
    @IBOutlet weak var objectName: UILabel!
    
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var smallestValueLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    @IBOutlet weak var largetsValueLabel: UILabel!
    
    let pickerData = ["Mozzarella","Gorgonzola","Provolone","Brie","Maytag Blue","Sharp Cheddar","Monterrey Jack","Stilton","Gouda","Goat Cheese", "Asiago"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        objectPicker.dataSource = self
        objectPicker.delegate = self
        
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ObjectCell", forIndexPath: indexPath)
        
        
        
        return cell
    }
    
    // MARK: Delegates and data sources
        // MARK: Data Sources
        func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
            return 1
        }
    
        func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerData.count
        }
    
        // MARK: Delegates
        func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerData[row]
        }
    
        func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            objectName.text = pickerData[row]
        }
}

