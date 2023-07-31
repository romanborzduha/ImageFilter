//
//  ImageProcessor.swift
//  ImageFilter
//
//  Created by Roman Borzdukha on 30.07.2023.
//

import Combine
import UIKit
import SwiftUI

class ImageProcessor: ObservableObject {
    
    struct Constants {
        static let debouncerTimeInterval = 0.25
    }
    
    @Published var intencity: CGFloat = 0 {
        didSet {
            Task {
                lumaThresholdFilter.intencity = intencity
                let proccesedImage = await applyLumaThresholdFilter(to: originalImage, with: intencity)
                await updateImage(with: proccesedImage)
            }
        }
    }
    
    @Published var image = Image("image")
    
    private var originalImage: UIImage = {
        guard let image = UIImage(named: "image") else {
            fatalError()
        }
        
        return image
    }()
    
    private let lumaThresholdFilter = LumaThresholdFilter()
    private let debouncer = Debouncer(withTimeInterval: Constants.debouncerTimeInterval)
    
    func applyLumaThresholdFilter(to image: UIImage, with intencity: CGFloat) async -> Image {
        
        // Using debouncer here, to reduce CPU load
        guard debouncer.isAllowed else { return self.image }
        
        debouncer.debounce()
        
        lumaThresholdFilter.inputImage = CIImage(image: image)
        
        guard let ciImage = lumaThresholdFilter.outputImage else {
            fatalError()
        }
        
        return Image(uiImage: ciImage.convertToUIImage())
    }
    
    @MainActor
    func updateImage(with image: Image) {
        self.image = image
    }
}
