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
    
    lazy var swapiClient = StarwarsAPIClient()
    
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
                    
                    // Check where the segue call comes from.
                    // If the data has not been fetched, the fetch closure will call the segue and send a int value to tell what button was clicked
                    if sender as? UIButton == charactersButton || sender as? Int == 1 {
                        controller.title = "Characters"
                        controller.objects = nil
                        controller.objects = downloadedCharacterData
                    } else if sender as? UIButton == vehiclesButton || sender as? Int == 2 {
                        controller.title = "Vehicles"
                        controller.objects = nil
                        controller.objects = downloadedVehicleData
                    } else if sender as? UIButton == starshipsButton || sender as? Int == 3 {
                        controller.title = "Starships"
                        controller.objects = nil
                        controller.objects = downloadedStarshipData
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
    
    func fetchData(data: StarWars, customUrl: NSURLRequest?) {
        
        // Prevent double tap
        charactersButton.enabled = false
        vehiclesButton.enabled = false
        starshipsButton.enabled = false
        
        swapiClient.fetchDataFor(data, customURL: customUrl) { [weak self] result in
            
            guard let strongSelf = self else { return }
            
            switch result {
            case .Success(let successData):
                switch data {
                case .People:
                    strongSelf.holderData = successData
                    strongSelf.downloadedCharacterData += successData.people
                    print("Person Count: \(strongSelf.downloadedCharacterData.count)")
                    strongSelf.characterDataCount = strongSelf.holderData!.count!
                    
                case .Vehicles:
                    strongSelf.holderData = successData
                    strongSelf.downloadedVehicleData += successData.vehicles
                    print("Vehicle Count: \(strongSelf.downloadedVehicleData.count)")
                    strongSelf.vehicleDataCount = strongSelf.holderData!.count!

                case .Starships:
                    strongSelf.holderData = successData
                    strongSelf.downloadedStarshipData += successData.starships
                    print("Starship Count: \(strongSelf.downloadedStarshipData.count)")
                    strongSelf.starshipDataCount = strongSelf.holderData!.count!
                    
                }
                
            case .Failure(let error as NSError):
                strongSelf.showAlert("Unable to retrieve data", message: error.localizedDescription)
            default: break
                
            }
        }
    }
    
    func showAlert(title: String, message: String?, style: UIAlertControllerStyle = .Alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let dismissAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(dismissAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
}

