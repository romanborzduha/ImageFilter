//
//  CIImage.swift
//  ImageFilter
//
//  Created by Roman Borzdukha on 31.07.2023.
//

import CoreImage
import UIKit

extension CIImage {
    func convertToUIImage() -> UIImage {
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(self, from: self.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
}
