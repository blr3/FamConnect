//
//  TreeViewController.swift
//  FamConnects
//
//  Created by Brianna R on 8/5/20.
//  Copyright © 2020 Brianna Richard. All rights reserved.
//

import UIKit
import SwiftUI

class TreeViewController: UIViewController {
    
    @IBOutlet var rootView: UIView!
    var window_: UIWindow?
    
    @Published var mesh = Mesh()
    @Published var selection = SelectionHandler()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        Mesh.sampleMesh(mesh: mesh)
        let contentView = SurfaceView(mesh: mesh, selection: selection)
        //self.view.window?.rootViewController = UIHostingController(rootView: contentView)
        
        if let windowScene = self.view.window?.windowScene {
          let window = UIWindow(windowScene: windowScene)
          window.rootViewController = UIHostingController(rootView: contentView)
          self.window_ = window
          window.makeKeyAndVisible()
        }
    }
}
