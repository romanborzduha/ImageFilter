//
//  ContentView.swift
//  ImageFilter
//
//  Created by Roman Borzdukha on 30.07.2023.
//

import SwiftUI
import Metal

struct ImageFilterView: View {
    
    @StateObject var imageProcessor = ImageProcessor()
    
    var body: some View {
        VStack {
            imageProcessor.image
                .padding()
            
            HStack {
                Text("Intencity: \((imageProcessor.intencity * 100).toString(withDecimals: 2))%")
                Spacer()
            }
            
            Slider(value: $imageProcessor.intencity)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFilterView()
    }
}
