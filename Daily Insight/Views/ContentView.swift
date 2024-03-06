//
//  ContentView.swift
//  Daily Insight
//
//  Created by Praval Gautam on 02/03/24.
//

import SwiftUI
import SplineRuntime
struct ContentView: View {
    var intro = "News informs, connecting individuals with global events. Covering politics, tech, culture, and sports, it fosters an informed citizenry. Trusted outlets deliver accurate, timely, unbiased reporting through print, broadcast, and digital platforms, offering a crucial tool for staying engaged in our ever-changing world."
    var body: some View {
        VStack{
          onboard3dview()
                .frame(height: 450)
                .ignoresSafeArea()
            VStack(spacing:10){
                VStack(alignment: .leading){
                    Text("Daily Insight")
                        .foregroundStyle(.red)
                        .font(.title).bold()
                    Text("A news App")
                        .foregroundStyle(.pink)
                        .font(.callout)
                }
                HStack{
                    Text(intro)
                        .multilineTextAlignment(.leading)
                        .lineLimit(7)
                        .font(.caption).bold()
                        .padding()
                }
                NavigationLink(destination: OnboardingScreen()) {
                    Text("Get Started")
                        .foregroundStyle(.white)
                        .frame(width: 200,height: 50)
                        .background(.red)
                        .cornerRadius(20)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}



struct onboard3dview: View {
    var body: some View {
        // fetching from cloud
        let url = URL(string: "https://build.spline.design/HItdZATQv7SpH-7LT8UC/scene.splineswift")!

        // // fetching from local
        // let url = Bundle.main.url(forResource: "scene", withExtension: "splineswift")!

        try? SplineView(sceneFileURL: url).ignoresSafeArea(.all)
    }
}
