//
//  WeatherDetailsTableViewController.swift
//  WeatherSnapshot
//
//  Created by Austin Becton on 8/24/21.
//

import UIKit
import Foundation

class WeatherDetailsTableViewController: UITableViewController {
    
    
    var displayItemsCount = 10
    var weatherReport: WeatherReport?
    var weatherReportItems: [WeatherReportItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherReport = WeatherReport()
        weatherReportItems = weatherReport!.provideWeatherItems()
        tableView.backgroundView = UIImageView(image: UIImage(named: "standardWeatherBackground"))
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayItemsCount;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherDetailCellPrototype", for: indexPath) as! WeatherDetailsTableCellView
        
        print("DetailsViewTable: " + weatherReportItems![0].getType())
        cell.infoTypeLabel.text = weatherReportItems![indexPath.row].getType()
        cell.dataLabel.text = weatherReportItems![indexPath.row].getData()
        
        
        
        //let note = notes[indexPath.row]
        //cell.noteTitleLabel.text = note.title
        
        
        //cell.noteModificationTimeLabel.text = note.modificationTime?.convertToString() ?? "unknown"
        ////cell.textLabel?.text = "Cell row: \(indexPath.row) Section: \(indexPath.section)"
        
        return cell
    }
    
}
