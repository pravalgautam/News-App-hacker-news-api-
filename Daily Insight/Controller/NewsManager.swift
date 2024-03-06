//
//  NewsManager.swift
//  Daily Insight
//
//  Created by Praval Gautam on 02/03/24.
//
import Foundation

class NewsManager: ObservableObject {
    @Published var topStories: [ResponseBody]?

    func fetchApi() async throws {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("No response") }

        let topStoryIDs = try JSONDecoder().decode([Int].self, from: data)
        self.topStories = topStoryIDs.map { ResponseBody(id: $0, title: "", url: "") } // Initialize with dummy values
    }

    func fetchDetailsForTopStories() async throws {
        guard let topStories = self.topStories else { return }

        for index in topStories.indices {
            let id = topStories[index].id
            do {
                try await fetchStoryDetails(id: id)
            } catch {
                print("Error fetching details for story with ID \(id): \(error)")
            }
        }
    }

    func fetchStoryDetails(id: Int) async throws {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("No response") }

        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        if let index = self.topStories?.firstIndex(where: { $0.id == id }) {
            self.topStories?[index] = decodedData
        }
    }
}

struct ResponseBody: Decodable, Identifiable {
    let id: Int
    let title: String
    let url: String
}
