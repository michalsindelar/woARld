//
//  ViewController.swift
//  WoARld
//
//  Created by Michal on 28/10/2017.
//  Copyright © 2017 Michal. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    let config = UserDefaults.standard

    @IBOutlet var sceneView: ARSCNView!
    var planes: [UUID : Plane] = [:]

    /**
    Creates simple object
    @return created SNNode
    */
    func createObjectNode() -> SCNNode {
        let objectGeo = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
        let objectNode = SCNNode(geometry: objectGeo)
        objectNode.position = SCNVector3(0, 0, -1) // camera in negative z-direction
        objectNode.castsShadow = config.bool(forKey: "castsShadow")
        objectNode.opacity = CGFloat(config.float(forKey: "objectsOpacity"))

        return objectNode
    }

    func setDefaultSettings() {
        config.set(true, forKey: "autoLighting")
        config.set(true, forKey: "castsShadow")
        config.set(true, forKey: "planeDetection")
        config.set(1, forKey: "objectsOpacity")

        // debug
        config.set(true, forKey: "debugShowsStatistics")
        config.set(true, forKey: "debugFeaturePoints")
    }

    func setDebugOptions() {
        if (config.bool(forKey: "debugFeaturePoints")) {
            self.sceneView.debugOptions = [
                ARSCNDebugOptions.showWorldOrigin,
                ARSCNDebugOptions.showFeaturePoints
            ]
        }
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self
        setDebugOptions()

        // Show statistics such as fps and timing information
        sceneView.showsStatistics = config.bool(forKey: "debugShowsStatistics")


        // Create a new scene
        let scene = SCNScene()
        // let scene = SCNScene(named: "art.scnassets/ship.scn")!

        scene.rootNode.addChildNode(createObjectNode())

        // TODO: Lightning
        // scene.lightingEnvironment = light cube


        // Set the scene to the view
        sceneView.scene = scene
    }

    override func viewWillAppear(_ animated: Bool) {
        setDefaultSettings()
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // TODO: Investigate difference
        configuration.isLightEstimationEnabled = config.bool(forKey: "autoLighting")

        if (config.bool(forKey: "planeDetection")) {
            configuration.planeDetection = .horizontal
        }


        // Run the view's session
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate


    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {

        if let anchor = anchor as? ARPlaneAnchor {
            let plane = Plane(anchor: anchor)
            node.addChildNode(plane)
            self.planes[anchor.identifier] = plane
        }
    }
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

        if let anchor = anchor as? ARPlaneAnchor, let plane = planes[anchor.identifier] {
            plane.update(with: anchor)
        }

    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user

    }

    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay

    }

    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required

    }
}
