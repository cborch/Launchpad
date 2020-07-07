//
//  LandingDetailViewController.swift
//  Launchpad
//
//  Created by Carter Borchetta on 7/6/20.
//  Copyright © 2020 Carter Borchetta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LandingDetailViewController: UIViewController {
    
    
    @IBOutlet weak var padImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var wikiButon: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var panelView1: UIView!
    @IBOutlet weak var panelView2: UIView!
    @IBOutlet weak var panelView3: UIView!
    @IBOutlet weak var padNameLabel: UILabel!
    
    var landingPadID = "LZ-45"
    let apiURL = "https://api.spacexdata.com/v3/landpads"
    var landingPad = LandingPad()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(landingPadID)
        getLandingPadData {
            print("Got landing pad data")
            self.populateUI()
        }


    }
    
    func getLandingPadData(completed: @escaping () -> ()) {
        
        Alamofire.request(apiURL).responseJSON { (response) in
            print("*** JSON = \(response)")
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let numberOfPads = json.count
                print(numberOfPads)
                for index in 0..<numberOfPads {
                    let ID = json[index]["id"].stringValue
                    if ID == self.landingPadID {
                        // Populate landing pad struct
                        let fullName = json[index]["full_name"].stringValue
                        let status = json[index]["status"].stringValue
                        let location = json[index]["location"]["name"].stringValue
                        let region = json[index]["location"]["region"].stringValue
                        let lat = json[index]["location"]["latitude"].floatValue
                        let long = json[index]["location"]["longitude"].floatValue
                        let attemps = json[index]["attempted_landings"].intValue
                        let success = json[index]["successful_landings"].intValue
                        let wiki = json[index]["wikipedia"].stringValue
                        let desc = json[index]["details"].stringValue
                        
                        self.landingPad.fullName = fullName
                        self.landingPad.status = status
                        self.landingPad.location = location
                        self.landingPad.region = region
                        self.landingPad.wikiLink = wiki
                        self.landingPad.description = desc
                        self.landingPad.attemptedLandings = attemps
                        self.landingPad.succesfulLandings = success
                        self.landingPad.lat = lat
                        self.landingPad.long = long
                    }
                        
                    
                }
            case.failure(let error):
                print("Error: failed to get data from url \(self.apiURL), error: \(error.localizedDescription)")
            }
            completed()
        }
        
    }
    
    func populateUI() {
        padNameLabel.text = landingPad.fullName
        locationLabel.text = landingPad.location + ", " + landingPad.region
        statusLabel.text = landingPad.status
        
        switch landingPad.status {
        case "active":
            statusLabel.textColor = UIColor.green
        case "retired":
            statusLabel.textColor = UIColor.red
        default:
            statusLabel.textColor = UIColor.yellow
        }
        
        descriptionLabel.text = landingPad.description
    }
    



}
