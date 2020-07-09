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
    

    @IBOutlet weak var payloadTableView: UITableView!
    
    
    
    
    let apiURL = "https://api.spacexdata.com/v3/payloads"
    var payloads: [Payload] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        print(payloads)
        payloadTableView.delegate = self
        payloadTableView.dataSource = self
        getPayloadData {
            print("got payload data")
            print(self.payloads)
            self.payloadTableView.reloadData()
        }
        

    }
    

    func getPayloadData(completed: @escaping () -> ()) {
        
        Alamofire.request(apiURL).responseJSON { (response) in
            //print("*** JSON = \(response)")
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let numberOfPayloads = json.count
                
                for e in 0..<self.payloads.count {
                    for index in 0..<numberOfPayloads {
                        let ID = json[index]["payload_id"].stringValue
                        if ID == self.payloads[e].name {
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
                            
                            self.payloads[e] = payload
                            
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

extension PayloadDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payloads.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PayloadCell", for: indexPath) as! PayloadTableViewCell
        
        cell.setCell(payloadImage: "", orbit: payloads[indexPath.row].orbit, periapsis: payloads[indexPath.row].periapsis, apoapsis: payloads[indexPath.row].apoapsis, earthGlyph: "", regime: payloads[indexPath.row].regime, customer: payloads[indexPath.row].customer, nationality: payloads[indexPath.row].nationality, manufacturer: payloads[indexPath.row].manufacturer, type: payloads[indexPath.row].type, mass: payloads[indexPath.row].mass, inclination: payloads[indexPath.row].inclination, period: payloads[indexPath.row].period, eccentrcity: payloads[indexPath.row].eccentricty)
        
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 705
    }
    



}
