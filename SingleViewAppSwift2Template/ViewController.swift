//
//  ViewController.swift
//  SingleViewAppSwift2Template
//
//  Created by Treehouse on 9/19/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var charactersButton: UIButton!
    @IBOutlet weak var vehiclesButton: UIButton!
    @IBOutlet weak var starshipsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func vehiclesButton(sender: UIButton) {
        performSegueWithIdentifier("showDetail", sender: sender)
    }
    
    @IBAction func starshipsButton(sender: UIButton) {
        performSegueWithIdentifier("showDetail", sender: sender)
    }
    
    @IBAction func charactersButton(sender: UIButton) {
        performSegueWithIdentifier("showDetail", sender: sender)
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            do {
            
                if Reachability.isConnectedToNetwork() == true {
                    let controller = segue.destinationViewController as! DetailViewController
                
                        if sender as! UIButton == charactersButton {
                            controller
                        } else if sender as! UIButton == vehiclesButton {
                            controller
                        } else if sender as! UIButton == starshipsButton {
                            controller
                        }
                    
                    } else {
                    throw Errors.missingInternetConnection
                }
            } catch Errors.missingInternetConnection {
                let alertController = UIAlertController(title: "No Internet Connection", message: "Please make sure you are connected to the internet", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(action)
            } catch let error {
                fatalError("\(error)")
            }
        }
    }
}

