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
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    
    var timer = Timer()
    var isTimerRunning = false
    var timeToLaunch = 86400.0
    let currentUnixTime = NSDate().timeIntervalSince1970
    var upcomingLaunchFlightNumber = 0
    

    var launchesFull = Launches()
    var launchesSelect = Launches()


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
                destination.launch = launchesSelect.launchArray[tableView.indexPathForSelectedRow!.row]
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
        launchesFull.getLaunches() {
            print("Done")
            self.tableView.reloadData()
            print(self.launchesFull.launchArray)
            self.timeToLaunch = self.launchesFull.launchArray[0].launchDateUnix - self.currentUnixTime
            self.segmentControllChanged(nil)
        }
        
        
    }
    


    @IBAction func segmentControllChanged(_ sender: UISegmentedControl?) {
        var startIndex = 0
        var endIndex = 0
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            launchesSelect.launchArray = []
            for i in 0..<launchesFull.launchArray.count {
                if launchesFull.launchArray[i].upcoming == true {
                    startIndex = i
                    endIndex = i + 1
                    break
                }
            }
            launchesSelect.launchArray = launchesFull.launchArray
            launchesSelect.launchArray = Array(launchesSelect.launchArray[startIndex..<endIndex])
            tableView.reloadData()
        case 1:
            launchesSelect.launchArray = []
            //let startIndex = 0
            for i in 0..<launchesFull.launchArray.count {
                if launchesFull.launchArray[i].upcoming == true {
                    endIndex = i
                    break
                }
            }
            
            launchesSelect.launchArray = Array(launchesFull.launchArray[startIndex..<endIndex])
            launchesSelect.launchArray = launchesSelect.launchArray.reversed()
            tableView.reloadData()
        case 2:
            launchesSelect.launchArray = []
            //let startIndex = 0
            let endIndex = launchesFull.launchArray.count - 1
            launchesSelect.launchArray = Array(launchesFull.launchArray[startIndex..<endIndex])
            tableView.reloadData()
            
        default:
            print("nope")
        }
    }
    
    



}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchesSelect.launchArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath) as! LaunchCell
        
        // Check for the segment control index
        // Select the appropriate launches.launchArray indexes
        //print(segmentControl.selectedSegmentIndex)
        
        
        cell.setCell(flightNumber: "#\(launchesSelect.launchArray[indexPath.row].flightNumber)", name: "\(launchesSelect.launchArray[indexPath.row].missionName)", description: "\(launchesSelect.launchArray[indexPath.row].missionDetails)", date: "\(launchesSelect.launchArray[indexPath.row].launchDateLocal)", year: "\(launchesSelect.launchArray[indexPath.row].launchYear)", time: "\(launchesSelect.launchArray[indexPath.row].launchTime)", timeZone: "\(launchesSelect.launchArray[indexPath.row].timeZone)", pad: "\(launchesSelect.launchArray[indexPath.row].padName)", padLocation: "\(launchesSelect.launchArray[indexPath.row].siteName)", temperature: "Plaecholder", conditions: "Placeholder", patchURL: launchesSelect.launchArray[indexPath.row].missionPatchLink)
        cell.configureUIViews()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    



}

