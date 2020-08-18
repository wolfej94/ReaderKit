//
//  ReaderKit.swift
//  ReaderKit
//
//  Created by Appoly on 29/03/2020.
//  Copyright © 2020 Appoly. All rights reserved.
//



import Foundation
import UIKit
import Vision
import ARKit



public protocol ReaderKitDelegate {
    
    func didFindText(text: String, frame: VNRectangleObservation)
    
}



public class ReaderKit: NSObject {
    
    // MARK: - Variables
    
    //User defined photo settings
    private var delegate: ReaderKitDelegate!
    
    //Capture session
    private var timer: Timer?
    private var containingView: ARSCNView!
    
    
    
    // MARK: - Actions
    
    /// Tries to take a photo using the capture session
    public func startReading() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(detectText), userInfo: nil, repeats: true)
    }
    
    
    public func stopReading() {
        containingView!.session.pause()
        timer?.invalidate()
    }
    
    
    
    // MARK: - Initializers
    
    public init?(view: ARSCNView, delegate: ReaderKitDelegate) throws {
        super.init()
        
        self.delegate = delegate
        self.containingView = view
        
        startPreview()
    }
    

    
    // MARK: - Controls
    
    private func startPreview() {
        let configuration = ARWorldTrackingConfiguration()
        containingView!.session.run(configuration)
    }
    
    
    @objc private func detectText() {
        guard let currentFrameBuffer = self.containingView.session.currentFrame?.capturedImage else { return }
            let image = CIImage(cvPixelBuffer: currentFrameBuffer)
            let detectTextRequest = VNRecognizeTextRequest { (request, error) in
                DispatchQueue.main.async {
                    if let results = request.results?.first as? VNRecognizedTextObservation {
                        guard let text = results.topCandidates(1).first else { return }
                        let range = text.string.startIndex ..< text.string.endIndex
                        guard let boundingBox = try? text.boundingBox(for: range) else { return }
                        
                        self.delegate.didFindText(text: text.string, frame: boundingBox)
                    }
                }
            }
         
            DispatchQueue.global().async {
                try? VNImageRequestHandler(ciImage: image).perform([detectTextRequest])
            }
    }

}
