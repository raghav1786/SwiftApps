//
//  ViewController.swift
//  myRoboDemo
//
//  Created by RAGHAV SHARMA on 04/07/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    var anchorRobot: MyRobot.MyRobotScene!
    override func viewDidLoad() {
        super.viewDidLoad()
        anchorRobot = try! MyRobot.loadMyRobotScene()
        anchorRobot.generateCollisionShapes(recursive: true)
        arView.scene.anchors.append(anchorRobot)
    }
    @IBAction func startClicked(_ sender: Any) {
        anchorRobot.notifications.roboNotification.post()
    }
}
