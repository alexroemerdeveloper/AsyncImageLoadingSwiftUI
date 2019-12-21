//
//  NasaImageView.swift
//  AsyncImageLoadingSwiftUI
//
//  Created by Alexander Römer on 06.12.19.
//  Copyright © 2019 Alexander Römer. All rights reserved.
//

import SwiftUI

struct NasaImageView: View {
    @ObservedObject var apiImage = NasaApiImage()
    
    var body: some View {
        Group {
            if apiImage.dataHasLoaded {
                Image(uiImage: apiImage.image!).resizable().scaledToFit()
            } else {
                Text("Loading Data")
            }
        }
        .onAppear {
            self.apiImage.loadImageFromApi(urlString: "https://api.nasa.gov/planetary/apod?api_key=eaRYg7fgTemadUv1bQawGRqCWBgktMjolYwiRrHK")
        }
    }
}

struct ApiImageView_Previews: PreviewProvider {
    static var previews: some View {
        NasaImageView()
    }
}
