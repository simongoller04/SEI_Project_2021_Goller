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
    
    var toolPicker: PKToolPicker!
    
    var drawing = PKDrawing()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        canvasView.delegate = self
        canvasView.drawing = drawing
        
        canvasView.alwaysBounceVertical = true
        canvasView.isDirectionalLockEnabled = true
        canvasView.drawingPolicy = .anyInput
        
        toolPicker = PKToolPicker()
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)

        toolPicker.addObserver(canvasView)
        toolPicker.addObserver(self)
        canvasView.becomeFirstResponder()
    }
    
    @IBAction func newImage(_ sender: Any) {
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        let VC = storyboard?.instantiateViewController(identifier: "randomImageVC")
        navigationController?.pushViewController(VC!, animated: true)
    }
    
    @IBAction func saveToCameraRoll(_ sender: Any) {
        
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)
        
        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil {
            PHPhotoLibrary.shared().performChanges({ PHAssetChangeRequest.creationRequestForAsset(from: image!)}, completionHandler: {success, error in
                    //
            })
    }
    //    func toolPickerFramesObscuredDidChange(_ toolPicker: PKToolPicker) {
//        updateLayout(for: toolPicker)
//    }
//
//    func toolPickerVisibilityDidChange(_ toolPicker: PKToolPicker) {
//        updateLayout(for: toolPicker)
//    }
//
//    func updateLayout(for toolPicker: PKToolPicker) {
//        let obscuredFrame = toolPicker.frameObscured(in: view)
//
//        // If the tool picker is floating over the canvas, it also contains
//        // undo and redo buttons.
//        if obscuredFrame.isNull {
//            canvasView.contentInset = .zero
//            navigationItem.leftBarButtonItems = []
//        }
//
//        else {
//            canvasView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.bounds.maxY - obscuredFrame.minY, right: 0)
////            navigationItem.leftBarButtonItems = [undoBarButtonitem, redoBarButtonItem]
//        }
//        canvasView.scrollIndicatorInsets = canvasView.contentInset
//    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return UIInterfaceOrientationMask.portrait
//    }
}
}

