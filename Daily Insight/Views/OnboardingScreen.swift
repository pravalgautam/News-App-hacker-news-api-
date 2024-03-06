//
//  OnboardingScreen.swift
//  Daily Insight
//
//  Created by Praval Gautam on 02/03/24.
//

import SwiftUI
import SafariServices

struct OnboardingScreen: View {
    @StateObject var newsManager = NewsManager()

    var body: some View {

            ZStack {
                if let topStories = newsManager.topStories {
                    List(topStories) { story in
                        NavigationLink(destination: BrowserView(url: story.url)) {
                            Text(story.title)
                        }
                    }
                } else {
                    Text("Loading...")
                        .onAppear {
                            Task {
                                do {
                                    try await newsManager.fetchApi()
                                    try await newsManager.fetchDetailsForTopStories()
                                } catch {
                                    print("Error fetching API: \(error)")
                                }
                            }
                        }
                }
            }
            .navigationTitle("Top Stories")
            .navigationBarTitleDisplayMode(.inline)
        }
    func openlink(link: String){
        
    }
    
}

struct BrowserView: UIViewControllerRepresentable {
    let url: String

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariViewController = SFSafariViewController(url: URL(string: url)!)
        return safariViewController
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}




