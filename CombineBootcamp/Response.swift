//
//  Response.swift
//  CombineBootcamp
//
//  Created by Shraddha Sutar on 04/01/24.
//

import Foundation

struct ResponseData: Codable {
    let success: Bool
    let totalPhotos: Int
    let message: String
    let offset, limit: Int
    let photos: [Photo]

    enum CodingKeys: String, CodingKey {
        case success
        case totalPhotos = "total_photos"
        case message, offset, limit, photos
    }
}

// MARK: - Photo
struct Photo: Codable, Identifiable {
    let url: String
    let title: String
    let user: Int
    let description: String
    let id: Int
}
