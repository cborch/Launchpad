//
//  LaunchCell.swift
//  Launchpad
//
//  Created by Carter Borchetta on 7/4/20.
//  Copyright © 2020 Carter Borchetta. All rights reserved.
//
//
import UIKit
import SDWebImage

class LaunchCell: UITableViewCell {

    @IBOutlet weak var flightNumberLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateYear: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeZoneLabel: UILabel!
    @IBOutlet weak var padLabel: UILabel!
    @IBOutlet weak var padLocationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var missionImageView: UIImageView!
    
    @IBOutlet weak var largeUIView: UIView!
    @IBOutlet weak var smallUIView1: UIView!
    @IBOutlet weak var smallUIView2: UIView!
    @IBOutlet weak var smallUIView3: UIView!
    @IBOutlet weak var smallUIView4: UIView!
    
    let placeHolderImage = UIImage(named: "placeholder")
    
    
    func setCell(flightNumber: String, name: String, description: String, date: String, year: String, time: String, timeZone: String, pad: String, padLocation: String, temperature: String, conditions: String, patchURL: String) {
        flightNumberLabel.text = flightNumber
        nameLabel.text = name
        descriptionLabel.text = description
        dateLabel.text = date
        dateYear.text = year
        timeLabel.text = time
        timeZoneLabel.text = timeZone
        padLabel.text = pad
        padLocationLabel.text = padLocation
        temperatureLabel.text = temperature
        conditionsLabel.text = conditions
  
        let remoteImageURL = URL(string: patchURL)
        missionImageView.sd_setImage(with: remoteImageURL, placeholderImage: placeHolderImage, options: SDWebImageOptions.highPriority, context: nil, progress: nil) { downloadedImage, downloadException, cacheType, downloadURL in
            
            if let downloadException = downloadException {
                print("Problem downloading the image \(downloadException.localizedDescription)")
            } else {
                print("Success")
            }
            
        }
        
        
//        if let url = URL(string: patchURL) {
//
//            do {
//                let data = try Data(contentsOf: url)
//                missionImageView.image = UIImage(data: data)
//
//            } catch let err {
//                print("Error: \(err.localizedDescription)")
//            }
//        }

        

    }
    
    func configureUIViews() {
        largeUIView.layer.cornerRadius = 10
        smallUIView1.layer.cornerRadius = 10
        smallUIView2.layer.cornerRadius = 10
        smallUIView3.layer.cornerRadius = 10
        smallUIView4.layer.cornerRadius = 10
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
