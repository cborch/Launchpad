//
//  ViewController.swift
//  Launchpad
//
//  Created by Carter Borchetta on 7/4/20.
//  Copyright © 2020 Carter Borchetta. All rights reserved.
//
//
import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    
    
    var tempLauchArray = ["L1", "L2", "L3"]
    var launchArray: [Launch] = []
    var apiURL = "https://api.spacexdata.com/v3/launches"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        getLaunches() {
            print("Done")
            
        }
        
    }
    

    
    
    func getLaunches(completed: @escaping () -> ()) {
        var upcomingIndex = 1000000
        
        Alamofire.request(apiURL).responseJSON { (response) in
            print("*** JSON = \(response)")
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let totalLaunches = json.count
                print(totalLaunches)
                for index in 0..<totalLaunches {
                    let upcoming = json[index]["upcoming"].boolValue
                    if upcoming {
                        upcomingIndex = index
                    }
                    if index >= upcomingIndex {
                        let flightNumber = json[index]["flight_number"].intValue
                        let missionName = json[index]["mission_name"].stringValue
                        
                        let launchYear = json[index]["launch_year"].stringValue
                        // Will not work properly if a vehicle has more than one core
                        let vehicleBlock = json[index]["rocket"]["first_stage"]["cores"][0]["block"].intValue
                        let launchDateUnix = json[index]["launch_date_unix"].intValue
                        let launchDateLocal = json[index]["launch_date_local"].stringValue
                        let rocketType = json[index]["rocket"]["rocket_name"].stringValue
                        // Will not work properly if a rocket has more than one core
                        let serial = json[index]["rocket"]["first_stage"]["cores"][0]["core_serial"].stringValue
                        // Will not work properly if a rocket has more than one core
                        // -1 issue when API returns null
                        let previousFlights = json[index]["rocket"]["first_stage"]["cores"][0]["flight"].intValue - 1
                        // Will not work properly if a rocket has more than one core
                        let reused = json[index]["rocket"]["first_stage"]["cores"][0]["reused"].boolValue
                        // Will not work properly if a rocket has more than one core
                        let landingIntent = json[index]["rocket"]["first_stage"]["cores"][0]["landing_intent"].boolValue
                        // Will not work properly if a rocket has more than one core
                        let landingType = json[index]["rocket"]["first_stage"]["cores"][0]["landing_type"].stringValue
                        // Will not work properly if a rocket has more than one core
                        let landingVehicle = json[index]["rocket"]["first_stage"]["cores"][0]["landing_vehicle"].stringValue
                        let siteName = json[index]["launch_site"]["site_name"].stringValue
                        let siteNameLong = json[index]["launch_site"]["site_name_long"].stringValue
                        let missionDetails = json[index]["details"].stringValue
                        let link = json[index]["links"]["video_link"].stringValue
                        
                        let payloadCount = json[index]["rocket"]["second_stage"]["payloads"].count
                        
                        var launch = Launch(flightNumber: flightNumber, missionName: missionName, launchYear: launchYear, vehicleBlock: vehicleBlock, launchDateUnix: launchDateUnix, launchDateLocal: launchDateLocal, rocketType: rocketType, serial: serial, previousFlights: previousFlights, reused: reused, landingIntent: landingIntent, landingType: landingType, landingVehicle: landingVehicle, payloadArray: [], siteName: siteName, siteNameLong: siteNameLong, missionDetails: missionDetails, link: link, upcoming: upcoming)
                        
                        
                        for j in 0..<payloadCount {
                            let payloadName = json[index]["rocket"]["second_stage"]["payloads"][j]["payload_id"].stringValue
                            let customer = json[index]["rocket"]["second_stage"]["payloads"][j]["customers"][0].stringValue
                            let nationality = json[index]["rocket"]["second_stage"]["payloads"][j]["nationality"].stringValue
                            let manufacturer = json[index]["rocket"]["second_stage"]["payloads"][j]["manufacturer"].stringValue
                            let type = json[index]["rocket"]["second_stage"]["payloads"][j]["payload_type"].stringValue
                            let mass = json[index]["rocket"]["second_stage"]["payloads"][j]["payload_mass_lbs"].floatValue
                            let orbit = json[index]["rocket"]["second_stage"]["payloads"][j]["orbit"].stringValue
                            var payload = Payload(name: payloadName, customer: customer, nationality: nationality, manufacturer: manufacturer, type: type, mass: mass, orbit: orbit)
                            
                            launch.payloadArray.append(payload)
                        }
                        
                        
                        self.launchArray.append(launch)
                       // print("appended a launch")
                       // if launch.payloadArray.count >= 2 {
                         //   print(launch.payloadArray[1])
                        //}
                        //print(launch.flightNumber, launch.missionName, launch.launchYear, launch.vehicleBlock, launch.launchDateUnix, launch.launchDateLocal, launch.rocketType, launch.serial, launch.previousFlights, launch.reused, launch.landingIntent, launch.landingType, launch.landingVehicle, launch.siteName, launch.missionDetails)
                    }
                    
                    
                    let url = json["results"][index]["url"].stringValue
                    //self.pokeArray.append(PokeData(name: name, url: url))
                    //print("\(index) \(name) \(url)")
                    
                }
            case.failure(let error):
                print("Error: failed to get data from url \(self.apiURL), error: \(error.localizedDescription)")
            }
            completed()
        }
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 112
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath) as! LaunchCell
        
        cell.setCell(flightNumber: "11", name: "11", description: "11", date: "11", year: "11", time: "11", timeZone: "11", pad: "11", padLocation: "11", temperature: "11", conditions: "11")
        cell.configureUIViews()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    



}

