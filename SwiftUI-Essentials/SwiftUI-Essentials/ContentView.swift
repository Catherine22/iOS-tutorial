//
//  ContentView.swift
//  SwiftUI-Essentials
//
//  Created by Catherine on 2019/12/3.
//  Copyright © 2019 CBB. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottom) {
                MapView()
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 300)
                    .padding(.bottom, 40)
                
                Image("turtlerock")
                .resizable()
                .frame(width: 80, height: 80, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
            }
            
            Text("Turtle Rock")
                .font(.title)
                .foregroundColor(.blue)
            
            HStack {
                Text("Joshua Tree National Park")
                    .font(.subheadline)
                Spacer()
                Text("California")
                    .font(.subheadline)
            }
        }
        .padding()
    }
}


struct MapView: UIViewRepresentable {
    
    
    typealias UIViewType = MKMapView
    
    
    func makeUIView(context: Context) -> MapView.UIViewType {
        print("makeUIView")
        return MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("updateUIView")
        let coordinate = CLLocationCoordinate2D(latitude: 34.011286, longitude: -116.166868)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
