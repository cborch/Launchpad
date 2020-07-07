//
//  PayloadDetailViewController.swift
//  Launchpad
//
//  Created by Carter Borchetta on 7/7/20.
//  Copyright © 2020 Carter Borchetta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PayloadDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var payload1ImageView: UIImageView!
    @IBOutlet weak var payload1Label: UILabel!
    @IBOutlet weak var customer1Label: UILabel!
    @IBOutlet weak var country1Label: UILabel!
    @IBOutlet weak var manufacturer1Label: UILabel!
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var mass1Label: UILabel!
    @IBOutlet weak var orbit1Label: UILabel!
    @IBOutlet weak var periapsis1Label: UILabel!
    @IBOutlet weak var apoapsis1Label: UILabel!
    @IBOutlet weak var eccentricity1Label: UILabel!
    @IBOutlet weak var inclination1Label: UILabel!
    @IBOutlet weak var period1Label: UILabel!
    @IBOutlet weak var lifespan1Label: UILabel!
    
    
    @IBOutlet weak var payload2ImageView: UIImageView!
    @IBOutlet weak var payload2Label: UILabel!
    @IBOutlet weak var customer2Label: UILabel!
    @IBOutlet weak var country2Label: UILabel!
    @IBOutlet weak var manufacturer2Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    @IBOutlet weak var mass2Label: UILabel!
    @IBOutlet weak var orbit2Label: UILabel!
    @IBOutlet weak var periapsis2Label: UILabel!
    @IBOutlet weak var apoapsis2Label: UILabel!
    @IBOutlet weak var eccentricity2Label: UILabel!
    @IBOutlet weak var inclination2Label: UILabel!
    @IBOutlet weak var period2Label: UILabel!
    @IBOutlet weak var lifespan2Label: UILabel!
    
    
    
    
    let apiURL = "https://api.spacexdata.com/v3/payloads"
    var payloads: [Payload] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        getPayloadData {
            print("got payload data")
            print(self.payloads)
        }
        

    }
    

    func getPayloadData(completed: @escaping () -> ()) {
        
        Alamofire.request(apiURL).responseJSON { (response) in
            print("*** JSON = \(response)")
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let numberOfPayloads = json.count
                
                for element in self.payloads {
                    for index in 0..<numberOfPayloads {
                        let ID = json[index]["payload_id"].stringValue
                        if ID == element.name {
                            let name = json[index]["payload_id"].stringValue
                            let customer = json[index]["customers"][0].stringValue
                            let nationality = json[index]["nationality"].stringValue
                            let manufacturer = json[index]["manufacturer"].stringValue
                            let type = json[index]["payload_type"].stringValue
                            let mass = json[index]["payload_mass_lbs"].floatValue
                            let orbit = json[index]["orbit"].stringValue
                            let referenceSystem = json[index]["orbit_params"]["reference_system"].stringValue
                            let regime = json[index]["orbit_params"]["regime"].stringValue
                            let periapsis = json[index]["orbit_params"]["periapsis_km"].floatValue
                            let apoapsis = json[index]["orbit_params"]["apoapsis_km"].floatValue
                            let inclination = json[index]["orbit_params"]["inclination_deg"].floatValue
                            let period = json[index]["orbit_params"]["period_min"].floatValue
                            let eccentricty = json[index]["orbit_params"]["eccentricity"].floatValue
                            
                            let payload = Payload(name: name, customer: customer, nationality: nationality, manufacturer: manufacturer, type: type, mass: mass, orbit: orbit, referenceSystem: referenceSystem, regime: regime, periapsis: periapsis, apoapsis: apoapsis, inclination: inclination, period: period, eccentricty: eccentricty)
                            
                            self.payloads.removeAll()
                            self.payloads.append(payload)
                            
                        }
                    }
                }

            case.failure(let error):
                print("Error: failed to get data from url \(self.apiURL), error: \(error.localizedDescription)")
            }
            completed()
        }
        
    }
    
    func populateUI() {
        
    }

}
