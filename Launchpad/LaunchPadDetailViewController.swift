//
//  LaunchPadDetailViewController.swift
//  Launchpad
//
//  Created by Carter Borchetta on 7/6/20.
//  Copyright © 2020 Carter Borchetta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class LaunchPadDetailViewController: UIViewController {
    
    @IBOutlet weak var launchPadMapView: MKMapView!
    
    @IBOutlet weak var panelUIView1: UIView!
    @IBOutlet weak var panelUIView2: UIView!
    @IBOutlet weak var panelUIView3: UIView!
    @IBOutlet weak var falcon1Label: UILabel!
    @IBOutlet weak var falcon9Label: UILabel!
    @IBOutlet weak var falconHeavyLabel: UILabel!
    @IBOutlet weak var launchPadNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var wikiButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var successesLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    
    

    var launchPadID = "stls"
    let apiURL = "https://api.spacexdata.com/v3/launchpads"
    var launchPad = Launchpad()
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        getLaunchPadData {
            print("Got launch pad data")
            self.populateUI()
        }


    }
    
    
    func getLaunchPadData(completed: @escaping () -> ()) {
        
        Alamofire.request(apiURL).responseJSON { (response) in
            print("*** JSON = \(response)")
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let numberOfPads = json.count
                print(numberOfPads)
                for index in 0..<numberOfPads {
                    let ID = json[index]["site_id"].stringValue
                    if ID == self.launchPadID {
                        // Populate landing pad struct
                        let fullName = json[index]["name"].stringValue
                        let status = json[index]["status"].stringValue
                        let location = json[index]["location"]["name"].stringValue
                        let region = json[index]["location"]["region"].stringValue
                        let lat = json[index]["location"]["latitude"].floatValue
                        let long = json[index]["location"]["longitude"].floatValue
                        let attempts = json[index]["attempted_launches"].intValue
                        let success = json[index]["successful_launches"].intValue
                        let wiki = json[index]["wikipedia"].stringValue
                        let desc = json[index]["details"].stringValue
                        
                        let vehiclesLaunched: [String] = []
                        let vehicleCount = json[index]["vehicles_launched"].count
                        print(vehicleCount, "v count")
                        print(json[index]["vehicles_launched"])
                        print(json[index]["site_id"].stringValue)
                        
                        self.launchPad.fullName = fullName
                        self.launchPad.status = status
                        self.launchPad.location = location
                        self.launchPad.region = region
                        self.launchPad.lat = lat
                        self.launchPad.long = long
                        //self.launchPad.vehiclesLaunched =
                        self.launchPad.attempts = attempts
                        self.launchPad.success = success
                        self.launchPad.wiki = wiki
                        self.launchPad.description = desc
                        
                        
                    }
                        
                    
                }
            case.failure(let error):
                print("Error: failed to get data from url \(self.apiURL), error: \(error.localizedDescription)")
            }
            completed()
        }
        
    }
    
    func populateUI() {
        attemptsLabel.text = "\(launchPad.attempts)"
        successesLabel.text = "\(launchPad.success)"
        
        //let percent = round( Float(launchPad.success)/Float(launchPad.attempts) * 100)
        let percent = Int(launchPad.success / launchPad.attempts * 100)
        
        percentLabel.text = "\(percent)" + "%"
        
    }



}
