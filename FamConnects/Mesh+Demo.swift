/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import CoreGraphics
import SwiftUI

extension Mesh {
    
    static func sampleMesh(mesh: Mesh) {
//    let mesh = Mesh()
    // Maually creating tree
        var i = 50
        mesh.updateNodeText(mesh.rootNode(), string: "Me")
        // add children
        mesh.treeData[0].fullName.forEach { (id) in
          let point = mesh.pointWithCenter(center: .zero, radius: 200, angle: (i).radians)
            i = i + 100
          let node = mesh.addChild(mesh.rootNode(), at: point)
            mesh.color = Color(.green)
          mesh.updateNodeText(node, string: String(id))
          //mesh.addChildrenRecursive(to: node, distance: 200, generation: 1)
        }
        
//        // add siblings
//        mesh.treeData[0].siblings.forEach { (id) in
//            let node = mesh.addSibling(mesh.rootNode())
//            mesh.color = Color(.yellow)
//            mesh.updateNodeText(node!, string: String(id))
//        }
//
  }
    
//        static func sampleMesh(mesh: Mesh) -> Mesh {
//    //    let mesh = Mesh()
//        // Maually creating tree
//
//            mesh.updateNodeText(mesh.rootNode(), string: "every human has a right to")
//            mesh.treeData[0].children.forEach { (id) in
//              let point = mesh.pointWithCenter(center: .zero, radius: 200, angle: (id+100).radians)
//              let node = mesh.addChild(mesh.rootNode(), at: point)
//                mesh.color = Color(.green)
//              mesh.updateNodeText(node, string: String(id))
//            }
//
//            return mesh
//
//      }

//  static func sampleProceduralMesh() -> Mesh {
//    let mesh = Mesh()
//    //seed root node with 3 children
//    [0, 1, 2, 3].forEach { index in
//      let point = mesh.pointWithCenter(center: .zero, radius: 400, angle: (index * 90 + 30).radians)
//      let node = mesh.addChild(mesh.rootNode(), at: point)
//      mesh.updateNodeText(node, string: "A\(index + 1)")
//      mesh.addChildrenRecursive(to: node, distance: 200, generation: 1)
//    }
//    return mesh
//  }

  func addChildrenRecursive(to node: Node, distance: CGFloat, generation: Int) {
    let labels = ["A", "B", "C", "D", "E", "F"]
    guard generation < labels.count else {
      return
    }

    let childCount = Int.random(in: 1..<4)
    var count = 0
    while count < childCount {
      count += 1
      let position = positionForNewChild(node, length: distance)
      let child = addChild(node, at: position)
      updateNodeText(child, string: "\(labels[generation])\(count + 1)")
      addChildrenRecursive(to: child, distance: distance + 200.0, generation: generation + 1)
    }
  }
}

extension Int {
  var radians: CGFloat {
    CGFloat(self) * CGFloat.pi/180.0
  }
}


