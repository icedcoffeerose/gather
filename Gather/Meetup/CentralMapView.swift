//
//  GatherMapView.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import SwiftUI
import MapKit

struct CentralMapView: View {
    @StateObject private var viewModel = CentralMapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: Array(viewModel.locations), annotationContent: {
            location in MapAnnotation(coordinate: location.coordinates) {
                location.image
                    .frame(width: 30, height: 30)
                    .scaledToFit()
                    .clipShape(Circle())
                
            }
        })
            .cornerRadius(15.0)
            .padding()
            .onAppear(perform: viewModel.checkLocationAuthorization)
    }
}

struct GatherMapView_Previews: PreviewProvider {
    static var previews: some View {
        CentralMapView()
    }
}
