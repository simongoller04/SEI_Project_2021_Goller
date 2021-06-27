//
//  ViewController.swift
//  Goller_Project
//
//  Created by Simon Goller on 26.06.21.
//

import UIKit
import PencilKit
import PhotosUI

class ViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {
    
    @IBOutlet weak var save: UIBarButtonItem!
    @IBOutlet weak var canvasView: PKCanvasView!
    @IBOutlet weak var Label: UILabel!
    
    var toolPicker: PKToolPicker!
    
    var drawing = PKDrawing()
    
    override func viewWillAppear(_ animated: Bool) {
        toolPicker = PKToolPicker()
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)

        toolPicker.addObserver(canvasView)
        toolPicker.addObserver(self)
        
        canvasView.alwaysBounceVertical = true
        canvasView.isDirectionalLockEnabled = true
        canvasView.drawingPolicy = .anyInput
        
        canvasView.becomeFirstResponder()
        canvasView.reloadInputViews()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvasView.delegate = self
        canvasView.drawing = drawing
    
    }
    
    @IBAction func clearCanvas(_ sender: Any) {
        canvasView.drawing = PKDrawing()
    }
    
    @IBAction func newImage(_ sender: Any) {
        let VC = storyboard?.instantiateViewController(identifier: "randomImageVC")
        navigationController?.pushViewController(VC!, animated: true)
    }
    
    @IBAction func saveToCameraRoll(_ sender: Any) {
        
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)
        
        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil {
            Label.text = "Image Saved!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.Label.text = ""
            }
            PHPhotoLibrary.shared().performChanges({ PHAssetChangeRequest.creationRequestForAsset(from: image!)}, completionHandler: {success, error in
            })
        }
    }
}

