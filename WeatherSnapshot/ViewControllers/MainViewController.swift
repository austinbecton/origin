//
//  ViewController.swift
//  WeatherSnapshot
//
//  Created by Austin Becton on 8/9/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var WeatherSnapshotViewContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        WeatherSnapshotViewContainer.layer.cornerRadius = 25
        
    }


}

