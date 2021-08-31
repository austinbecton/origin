//
//  WeatherDetailsTableViewDelegate.swift
//  WeatherSnapshot
//
//  Created by Austin Becton on 8/17/21.
//

import Foundation
import UIKit

class WeatherDetailsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder:aDecoder)
            self.delegate = self
            self.dataSource = self
        }
    
        override func didMoveToSuperview() {
            self.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = self.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = ["Manny", "Moe", "Jack"][indexPath.row]
            return cell
        }
    
}
