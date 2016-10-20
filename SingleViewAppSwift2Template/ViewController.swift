//
//  ViewController.swift
//  TheAPIAwakens
//
//  Created by Mathias Vang Rasmussen on 9/19/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var charactersButton: UIButton!
    @IBOutlet weak var vehiclesButton: UIButton!
    @IBOutlet weak var starshipsButton: UIButton!
    
    lazy var swapiClient = StarwarsAPIClient.self
    var holderData: StarWarsHold?
    var characterDataCount = 0
    var vehicleDataCount = 0
    var starshipDataCount = 0
    var downloadedCharacterData = [StarWarsCharacter]()
    var downloadedVehicleData = [StarWarsVehicle]()
    var downloadedStarshipData = [StarWarsStarship]()
    var characterClicked = false
    var vehicleClicked = false
    var starshipClicked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func charactersButton(sender: UIButton) {
        performSegueWithIdentifier("showDetail", sender: sender)
    }
    
    @IBAction func vehiclesButton(sender: UIButton) {
        performSegueWithIdentifier("showDetail", sender: sender)
    }
    
    @IBAction func starshipsButton(sender: UIButton) {
        performSegueWithIdentifier("showDetail", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            do {
            
                if Reachability.isConnectedToNetwork() == true {
                    let controller = segue.destinationViewController as! DetailViewController
                
                        if sender as? UIButton == charactersButton {
                            characterClicked = true
                            StarwarsAPIClient.fetchData(self)
                        } else if sender as? UIButton == vehiclesButton {
                            print("Fuck af")
                            controller
                        } else if sender as? UIButton == starshipsButton {
                            controller
                        }
                    
                    } else {
                    throw Errors.missingInternetConnection
                }
            } catch Errors.missingInternetConnection {
                let alertController = UIAlertController(title: "No Internet Connection", message: "Please make sure you are connected to the internet", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(action)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            } catch let error {
                fatalError("\(error)")
            }
        }
    }
    
    func fetchData(data: StarwarsAPIClient, customURL: NSURLRequest?) {
        
        charactersButton.enabled = false
        vehiclesButton.enabled = false
        starshipsButton.enabled = false
        
        swapiClient.fetchDataFor(data, customURL: customURL) { [weak self] Result in
            
            if let strongSelf = self {
                
                switch result {
                case .Success(let successData):
                    strongSelf.currentPage += 1
                    switch data {
                        case .StarWarsCharacter:
                        strongSelf.holderData = successData
                        strongSelf.downloadedPersonData += successData.people
                        print("Person Count: \(strongSelf.downloadedPersonData.count)")
                        strongSelf.personDataCount = strongSelf.holderData!.count!
                    }
                }
            }
        }
    }
}

