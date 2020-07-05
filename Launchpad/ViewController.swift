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
    
    

    var launches = Launches()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        loadLaunches()
        
    }
    
    func loadLaunches() {
        launches.getLaunches() {
            print("Done")
            self.tableView.reloadData()
        }
        
    }
    

    
    



}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.launchArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath) as! LaunchCell
        
        cell.setCell(flightNumber: "#\(launches.launchArray[indexPath.row].flightNumber)", name: "\(launches.launchArray[indexPath.row].missionName)", description: "\(launches.launchArray[indexPath.row].missionDetails)", date: "\(launches.launchArray[indexPath.row].launchDateLocal)", year: "\(launches.launchArray[indexPath.row].launchYear)", time: "\(launches.launchArray[indexPath.row].launchTime)", timeZone: "\(launches.launchArray[indexPath.row].timeZone)", pad: "\(launches.launchArray[indexPath.row].padName)", padLocation: "\(launches.launchArray[indexPath.row].siteName)", temperature: "Plaecholder", conditions: "Placeholder")
        cell.configureUIViews()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    



}

