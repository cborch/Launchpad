//
//  LaunchDetailViewController.swift
//  Launchpad
//
//  Created by Carter Borchetta on 7/5/20.
//  Copyright © 2020 Carter Borchetta. All rights reserved.
//

import UIKit

class LaunchDetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailCountDownLabel: UILabel!
    @IBOutlet weak var vehicleLabel: UILabel!
    @IBOutlet weak var blockLabel: UILabel!
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var reusedLabel: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var orbitLabel: UILabel!
    @IBOutlet weak var payloadLabel: UILabel!
    @IBOutlet weak var padLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var landingVehicleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var attemptLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flightNumberDetailLabel: UILabel!
    
    
    @IBOutlet weak var countdownUIView: UIView!
    @IBOutlet weak var vehicleUIView: UIView!
    @IBOutlet weak var payloadUIView: UIView!
    @IBOutlet weak var launchUIView: UIView!
    @IBOutlet weak var landingUIView: UIView!
    @IBOutlet weak var detailsUIView: UIView!
    
    
    
    var launch: Launch!
    var timer = Timer()
    var timeToLaunch = 0.0
    let currentUnixTime = NSDate().timeIntervalSince1970

    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateUI()
        configureUIViews()
        timeToLaunch = launch.launchDateUnix - currentUnixTime
        runTimer()

        // Do any additional setup after loading the view.
    }
    
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timeToLaunch -= 1     //This will decrement(count down)the seconds.
        detailCountDownLabel.text = timeString(time: TimeInterval(timeToLaunch)) //This will update the label.
    }
    
    func timeString(time:TimeInterval) -> String {
        let days = Int(time) / 86400
        let hours = Int(time) % 86400 / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i:%02i", days, hours, minutes, seconds)
    }
    
    func populateUI() {
        vehicleLabel.text = launch.rocketType
        blockLabel.text = "\(launch.vehicleBlock)"
        serialLabel.text = launch.serial
        flightNumberLabel.text = "#\(launch.flightNumber)"
        reusedLabel.text = launch.reused == true ? "Yes" : "No"
        padLabel.text = launch.padName
        locationLabel.text = launch.siteNameLong
        landingVehicleLabel.text = launch.landingVehicle
        typeLabel.text = launch.landingType
        attemptLabel.text = launch.reused == true ? "Yes" : "No"
        detailsLabel.text = launch.missionDetails
        nameLabel.text = launch.missionName
        flightNumberDetailLabel.text = "\(launch.flightNumber)"
        
        
        //successLabel.text = launch.success
        
        // Need to deal with attributes inside the payload array so it can handle multiple
        //customerLabel.text = launch.payloadArray
        
        
    }
    
    func configureUIViews() {
        countdownUIView.layer.cornerRadius = 15
        vehicleUIView.layer.cornerRadius = 15
        payloadUIView.layer.cornerRadius = 15
        launchUIView.layer.cornerRadius = 15
        landingUIView.layer.cornerRadius = 15
        landingUIView.layer.cornerRadius = 15
        detailsUIView.layer.cornerRadius = 15
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
