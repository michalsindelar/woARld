//
//  SettingsTableViewController.swift
//  WoARld
//
//  Created by Michal on 29/10/2017.
//  Copyright © 2017 Michal. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var debugFeaturePointsSwitch: UISwitch!
    @IBOutlet weak var planeDetectionSwitch: UISwitch!
    @IBOutlet weak var lightEstimationSwitch: UISwitch!
    @IBOutlet weak var castsShadowSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Dispatch to Global State

    @IBAction func switchPressed(_ sender: UISwitch, forEvent event: UIEvent) {

        Config.debugFeaturePoints = debugFeaturePointsSwitch.isOn
        Config.planeDetection = planeDetectionSwitch.isOn
        Config.lightEstimation = lightEstimationSwitch.isOn
        Config.castsShadow = castsShadowSwitch.isOn

    }

}
