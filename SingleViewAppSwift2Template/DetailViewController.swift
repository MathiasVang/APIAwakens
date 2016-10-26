//
//  DetailViewController.swift
//  TheAPIAwakens
//
//  Created by Mathias Vang Rasmussen on 9/19/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    lazy var swapiClient = StarwarsAPIClient()
    var objects: [AnyObject]?
    var unwrapObjects = [AnyObject]()
    var countOfObjects = 1
    var nameArr = [String]()
    var descrArr = [[String: AnyObject]]()
    var selectedTypeInPickerWheel: Int = 0 {
        didSet {
            tableView.reloadData()
            storedCurrency = 0
        }
    }
    
    var typeListKeys: [String] {
        get {
            return Array(descrArr[selectedTypeInPickerWheel].keys)
        }
    }
    var storedCurrency = 0
    var storedSmallSize: Int? = nil
    var storedLargeSize: Int? = nil
    var moreDataText = [String]()
    
    func setupView() {
        
        if let obj = objects {
            unwrapObjects = obj
        }
        
        countOfObjects = unwrapObjects.count
        
        for i in 0 ..< countOfObjects {
            if let names = unwrapObjects[i] as? DataProtocol {
                nameArr.append(names.name)
            }
            var tempDict = [String: AnyObject]()
            if let type = unwrapObjects.first as? DataProtocol {
                if let check = type.type as? StarWarsType {
                    switch check {
                    case .character:
                        let person = unwrapObjects[i] as! StarWarsCharacter
                        tempDict["Born"] = person.yearOfBirth
                        tempDict["Height"] = person.height
                        if let u = Int(person.height) {
                            populateQuickFacts(u, count: i)
                        }
                        tempDict["Eyes"] = person.eyes
                        tempDict["Hair"] = person.hair
                        tempDict["More"] = ""
                    case .vehicle:
                        let vehicle = unwrapObjects[i] as! StarWarsVehicle
                        tempDict["Make"] = vehicle.make
                        tempDict["Cost"] = vehicle.cost
                        tempDict["Length"] = vehicle.length
                        if let u = Int(vehicle.length) {
                            populateQuickFacts(u, count: i)
                        }
                        tempDict["Crew"] = vehicle.crew
                    case .starship:
                        let starship = unwrapObjects[i] as! StarWarsStarship
                        tempDict["Make"] = starship.make
                        tempDict["Cost"] = starship.cost
                        tempDict["Length"] = starship.length
                        if let u = Int(starship.length) {
                            populateQuickFacts(u, count: i)
                        }
                        tempDict["Crew"] = starship.crew
                    }
                    descrArr.append(tempDict)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        // Setup delegates
        tableView.delegate = self
        tableView.dataSource = self
        pickerView.delegate = self
        pickerView.dataSource = self
        navigationController?.delegate = self
        
        tableView.separatorColor = UIColor(red: 106/255.0, green: 196/255.0, blue: 255/255.0, alpha: 1)
        tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10)
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        nameLabel.text = nameArr[0]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - PickerView
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countOfObjects
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = nameArr[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        return myTitle
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameLabel.text = nameArr[row]
        selectedTypeInPickerWheel = row
    }
    
    // MARK: - TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descrArr[0].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ObjectCell", forIndexPath: indexPath) as! ObjectCell
        
        cell.button1.hidden = true
        cell.button2.hidden = true
        
        // Get the keys from the dictionary and list them as the category
        let rowKey = typeListKeys[indexPath.row]
        cell.descLabel.text = rowKey
        
        // Using the keys get the corrosponding value
        let rowValue = descrArr[selectedTypeInPickerWheel][rowKey] as? String
        
        // Assign buttons
        if rowKey == "Cost" {
            
            cell.userInteractionEnabled = true
            cell.button1.setTitle("USD", forState: .Normal)
            cell.button2.setTitle("Credits", forState: .Normal)
            cell.button1.hidden = false
            cell.button2.hidden = false
            textField.hidden = false
            currencyLabel.hidden = false
            
        } else if rowKey == "Height" || rowKey == "Length" {
            cell.userInteractionEnabled = true
            cell.button1.setTitle("English", forState: .Normal)
            cell.button2.setTitle("Metric", forState: .Normal)
            cell.button1.hidden = false
            cell.button2.hidden = false
        }
        
        // Check value and then assign it
        if let value = rowValue {
            cell.valueLabel.text = value
        } else {
            cell.valueLabel.text = "Something did not work"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // MARK: - Segues
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if let controller = viewController as? HomeViewController {
            controller.charactersButton.enabled = true
            controller.vehiclesButton.enabled = true
            controller.starshipsButton.enabled = true
        }
    }
    
    // MARK: - Helper Methods
    
    func convertMetrics(sender: Int) {
        if let height = descrArr[selectedTypeInPickerWheel]["Height"] as? String {
            if let int = Double(height) {
                if sender == 1 {
                    descrArr[selectedTypeInPickerWheel].updateValue("\(Double(int) * 3.280840)", forKey: "Height")
                } else if sender == 2 {
                    descrArr[selectedTypeInPickerWheel].updateValue("\(Double(int) / 3.280840)", forKey: "Height")
                }
            }
        } else if let length = descrArr[selectedTypeInPickerWheel]["Length"] as? String {
            if let int = Double(length) {
                if sender == 1 {
                    descrArr[selectedTypeInPickerWheel].updateValue("\(Double(int) * 3.280840)", forKey: "Length")
                } else if sender == 2 {
                    descrArr[selectedTypeInPickerWheel].updateValue("\(Double(int) / 3.280840)", forKey: "Length")
                }
            }
        }
        tableView.reloadData()
    }
    
    func convertCurrency(sender: Int) throws {
        if let currency = descrArr[selectedTypeInPickerWheel]["Cost"] as? String {
            if storedCurrency == 0 {
                if let int = Int(currency) {
                    storedCurrency = int
                }
            }
        }
        
        if sender == 1 {
            var value = Int()
            if let textInput = textField.text {
                guard let inputInt = Int(textInput) else {
                    throw Errors.InvalidInt
                }
                if inputInt == 0 || inputInt < 0 {
                    throw Errors.ZeroInput
                }
                value = inputInt
            } else {
                value = 100
            }
            let val = (storedCurrency / value) * 100
            descrArr[selectedTypeInPickerWheel].updateValue("\(val)", forKey: "Cost")
        } else if sender == 2 {
            descrArr[selectedTypeInPickerWheel].updateValue("\(storedCurrency)", forKey: "Cost")
        }
        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String?, style: UIAlertControllerStyle = .Alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let dismissAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(dismissAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func noDataAlert() {
        let alertController = UIAlertController(title: "No Data", message: "Something went horribly wrong. Please try again.", preferredStyle: .Alert)
        let dismissAction = UIAlertAction(title: "OK", style: .Default) { handler in
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        alertController.addAction(dismissAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func setupTextField() {
        let color = UIColor(red: 106/255.0, green: 196/255.0, blue: 255/255.0, alpha: 1)
        textField.text = "100"
        textField.textColor = color
        textField.backgroundColor = UIColor.clearColor()
        textField.attributedPlaceholder = NSAttributedString(string:"100", attributes: [NSForegroundColorAttributeName: color])
    }
    
    func populateQuickFacts(size: Int, count: Int) {
        if storedSmallSize == nil {
            storedSmallSize = size
        } else if storedLargeSize == nil {
            storedLargeSize = size
        }
        
        if size >= storedLargeSize {
            storedLargeSize = size
            largestLabel.text = nameArr[count]
        } else if size <= storedSmallSize {
            storedSmallSize = size
            smallestLabel.text = nameArr[count]
        }
    }
    
    func fetchData(data: StarWars, customUrl: NSURLRequest) {
        swapiClient.fetchSingleData(customUrl, forType: data) { [weak self] result in
            if let strongSelf = self {
                switch result {
                case .Success(let successData):
                    switch data {
                    case .Vehicles:
                        strongSelf.moreDataText.append((successData as! StarWarsVehicle).name)
                    case .Starships:
                        strongSelf.moreDataText.append((successData as! StarWarsStarship).name)
                    default:
                        break
                    }
                case .Failure(let error as NSError):
                    strongSelf.showAlert("Unable to retrieve data", message: error.localizedDescription)
                default: break
                }
            }
        }
    }
}









