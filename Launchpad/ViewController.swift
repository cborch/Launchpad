//
//  ViewController.swift
//  Launchpad
//
//  Created by Carter Borchetta on 7/4/20.
//  Copyright © 2020 Carter Borchetta. All rights reserved.
//
//
import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countDownLabel: UILabel!
    var timer = Timer()
    var isTimerRunning = false
    var timeToLaunch = 86400.0
    let currentUnixTime = NSDate().timeIntervalSince1970
    

    var launches = Launches()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        loadLaunches()
        print(timeToLaunch)
        runTimer()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let destination = segue.destination as? LaunchDetailViewController{
                destination.launch = launches.launchArray[tableView.indexPathForSelectedRow!.row]
            }
        } else {
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timeToLaunch -= 1     //This will decrement(count down)the seconds.
        countDownLabel.text = timeString(time: TimeInterval(timeToLaunch)) //This will update the label.
    }
    
    func timeString(time:TimeInterval) -> String {
        let days = Int(time) / 86400
        let hours = Int(time) % 86400 / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i:%02i", days, hours, minutes, seconds)
    }
    
    func loadLaunches() {
        launches.getLaunches() {
            print("Done")
            self.tableView.reloadData()
            print(self.launches.launchArray)
            self.timeToLaunch = self.launches.launchArray[0].launchDateUnix - self.currentUnixTime
        }
        
        
    }
    

    
    



}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.launchArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath) as! LaunchCell
        
        cell.setCell(flightNumber: "#\(launches.launchArray[indexPath.row].flightNumber)", name: "\(launches.launchArray[indexPath.row].missionName)", description: "\(launches.launchArray[indexPath.row].missionDetails)", date: "\(launches.launchArray[indexPath.row].launchDateLocal)", year: "\(launches.launchArray[indexPath.row].launchYear)", time: "\(launches.launchArray[indexPath.row].launchTime)", timeZone: "\(launches.launchArray[indexPath.row].timeZone)", pad: "\(launches.launchArray[indexPath.row].padName)", padLocation: "\(launches.launchArray[indexPath.row].siteName)", temperature: "Plaecholder", conditions: "Placeholder", patchURL: launches.launchArray[indexPath.row].missionPatchLink)
        cell.configureUIViews()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    



}

