//
//  LumaThresholdKernel.swift
//  ImageFilter
//
//  Created by Roman Borzdukha on 30.07.2023.
//

import CoreImage

class LumaThresholdFilter: CIFilter {
    
    struct Constants {
        static let maxOffset: CGFloat = 0.01
    }
    
    var intencity: CGFloat = 0.5 {
        didSet {
            offset = Constants.maxOffset * intencity
        }
    }
    
    private var offset: CGFloat = 0
    
    var inputImage: CIImage?
    
    static var kernel: CIKernel = { () -> CIKernel in
        guard let url = Bundle.main.url(
            forResource: "LumaThresholdKernel.ci",
            withExtension: "metallib"),
        let data = try? Data(contentsOf: url) else {
            fatalError("Unable to load metallib")
        }

        guard let kernel = try? CIKernel(
            functionName: "tiktokfy",
            fromMetalLibraryData: data) else {
            fatalError("Unable to create warp kernel")
        }

        return kernel
    }()

      override var outputImage: CIImage? {
          guard let inputImage = inputImage else { return .none }

          let arguments = [inputImage, offset] as [Any]
          
          return LumaThresholdFilter.kernel.apply(
                                          extent: inputImage.extent,
                                          roiCallback: { _, rect in
                                            return rect
                                          },
                                          arguments: arguments)
      }
    
}
