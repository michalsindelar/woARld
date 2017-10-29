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

    @IBOutlet var sceneView: ARSCNView!
    var planes: [UUID : Plane] = [:]

    /**
    Creates simple object
    @return created SNNode
    */
    func createObjectNode() -> SCNNode {
        let objectGeo = SCNSphere(radius: 0.3)


        let physicalMaterial = SCNMaterial()

        // TODO: Add to settings
        // materialSettings.lightingModel = SCNMaterial.LightingModel.lambert
        // physicalMaterial.lightingModel = SCNMaterial.LightingModel.phong

        physicalMaterial.lightingModel = SCNMaterial.LightingModel.physicallyBased
        physicalMaterial.diffuse.contents = UIImage(named: "earth.jpg")

        // physicalMaterial.blendMode = SCNBlendMode.alpha
        // SCNMaterialProperty(contents: UIImage())

        objectGeo.materials = [physicalMaterial]


        let objectNode = SCNNode(geometry: objectGeo)

        objectNode.position = SCNVector3(0, 0, -1) // camera in negative z-direction
        objectNode.castsShadow = Config.castsShadow


        objectNode.opacity = CGFloat(Config.objectsOpacity)

        return objectNode
    }

    func setDebugOptions() {
        if (Config.debugFeaturePoints) {
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
        sceneView.showsStatistics = Config.debugShowsStatistics


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
        super.viewWillAppear(animated)

        // Create a session Configuration
        let configuration = ARWorldTrackingConfiguration()

        // TODO: Investigate difference
        configuration.isLightEstimationEnabled = Config.lightEstimation

        if (Config.planeDetection) {
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

    func setupLights() {
        sceneView.automaticallyUpdatesLighting = false // we'll handle

    }

    // MARK: - ARSCNViewDelegate
    func syncWithGlobals() {
        setupLights()

        // Sync with global settings
        if (!Config.debugFeaturePoints) {
            self.sceneView.debugOptions = []
        }

        sceneView.session.configuration!.isLightEstimationEnabled = Config.lightEstimation
    }


    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        syncWithGlobals()

        if let anchor = anchor as? ARPlaneAnchor {
            let plane = Plane(anchor: anchor)
            node.addChildNode(plane)
            self.planes[anchor.identifier] = plane
        }
    }
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

        if let anchor = anchor as? ARPlaneAnchor, Config.planeDetection, let plane = planes[anchor.identifier] {
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
