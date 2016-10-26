//
//  HomeViewController.swift
//  TheAPIAwakens
//
//  Created by Mathias Vang Rasmussen on 26/10/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var charactersButton: UIButton!
    @IBOutlet weak var vehiclesButton: UIButton!
    @IBOutlet weak var starshipsButton: UIButton!
    
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
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
    
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func characterTapped(sender: AnyObject) {
        
        if characterClicked == false {
            holderData = nil
        }
        
        if sender as! UIButton == charactersButton {
            if holderData == nil && characterClicked == false {
                activityIndicator.startAnimating()
                characterClicked = true
                fetchData(StarWars.People, customUrl: nil)
            } else {
                performSegueWithIdentifier("showDetail", sender: sender)
            }
        }
    }
    
    @IBAction func vehicleTapped(sender: AnyObject) {
        
        if vehicleClicked == false {
            holderData = nil
        }
        
        if sender as! UIButton == vehiclesButton {
            if holderData == nil && vehicleClicked == false {
                activityIndicator.startAnimating()
                vehicleClicked = true
                fetchData(StarWars.Vehicles, customUrl: nil)
            } else {
                performSegueWithIdentifier("showDetail", sender: sender)
            }
        }
    }

    @IBAction func starshipTapped(sender: AnyObject) {
        
        if starshipClicked == false {
            holderData = nil
        }
        
        if sender as! UIButton == starshipsButton {
            if holderData == nil && starshipsButton == false {
                activityIndicator.startAnimating()
                starshipClicked = true
                fetchData(StarWars.Starships, customUrl: nil)
            } else {
                performSegueWithIdentifier("showDetail", sender: sender)
            }
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            do {
                
                if Reachability.isConnectedToNetwork() == true {
                    let controller = segue.destinationViewController as! DetailViewController
                    
//                    if characterClicked == false {
//                        holderData = nil
//                    } else if vehicleClicked == false {
//                        holderData = nil
//                    } else if starshipClicked == false {
//                        holderData = nil
//                    }
//                    
//                    if sender as! UIButton == charactersButton {
//                        if holderData == nil && characterClicked == false {
//                            activityIndicator.startAnimating()
//                            characterClicked = true
//                            fetchData(StarWars.People, customUrl: nil)
//                        } else {
//                            performSegueWithIdentifier("showDetail", sender: sender)
//                        }
//                    } else if sender as! UIButton == vehiclesButton {
//                        if holderData == nil && vehicleClicked == false {
//                            activityIndicator.startAnimating()
//                            vehicleClicked = true
//                            fetchData(StarWars.Vehicles, customUrl: nil)
//                        } else {
//                            performSegueWithIdentifier("showDetail", sender: sender)
//                        }
//                    } else if sender as! UIButton == starshipsButton {
//                        if holderData == nil && starshipClicked == false {
//                            activityIndicator.startAnimating()
//                            starshipClicked = true
//                            fetchData(StarWars.Starships, customUrl: nil)
//                        } else {
//                            performSegueWithIdentifier("showDetail", sender: sender)
//                        }
//                    }
                    
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
                strongSelf.currentPage += 1
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
            
            if (strongSelf.holderData?.next != nil) {
                strongSelf.fetchData(data, customUrl: NSURLRequest(URL: NSURL(string: (strongSelf.holderData?.next)!)!))
            } else {
                strongSelf.currentPage = 0
                strongSelf.activityIndicator.stopAnimating()
                strongSelf.performSegueWithIdentifier("showDetail", sender: data.rawValue)
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

