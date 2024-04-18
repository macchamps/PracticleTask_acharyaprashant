//
//  GridModel.swift
//  AssignmentAcharyaprashant
//
//  Created by Monang Champaneri on 18/04/24.
//

import Foundation

// MARK: - GridModel
struct GridModel: Codable {
    let id, title: String
    let language: Language
    let thumbnail: Thumbnail
    let mediaType: Int
    let coverageURL: String
    let publishedAt, publishedBy: String
    let backupDetails: BackupDetails?
}

// MARK: GridModel convenience initializers and mutators

extension GridModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GridModel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String? = nil,
        title: String? = nil,
        language: Language? = nil,
        thumbnail: Thumbnail? = nil,
        mediaType: Int? = nil,
        coverageURL: String? = nil,
        publishedAt: String? = nil,
        publishedBy: String? = nil,
        backupDetails: BackupDetails?? = nil
    ) -> GridModel {
        return GridModel(
            id: id ?? self.id,
            title: title ?? self.title,
            language: language ?? self.language,
            thumbnail: thumbnail ?? self.thumbnail,
            mediaType: mediaType ?? self.mediaType,
            coverageURL: coverageURL ?? self.coverageURL,
            publishedAt: publishedAt ?? self.publishedAt,
            publishedBy: publishedBy ?? self.publishedBy,
            backupDetails: backupDetails ?? self.backupDetails
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - BackupDetails
struct BackupDetails: Codable {
    let pdfLink: String
    let screenshotURL: String
}

// MARK: BackupDetails convenience initializers and mutators

extension BackupDetails {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BackupDetails.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        pdfLink: String? = nil,
        screenshotURL: String? = nil
    ) -> BackupDetails {
        return BackupDetails(
            pdfLink: pdfLink ?? self.pdfLink,
            screenshotURL: screenshotURL ?? self.screenshotURL
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Language: String, Codable {
    case english = "english"
    case hindi = "hindi"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let id: String
    let version: Int
    let domain: String
    let basePath: String
    let key: Key
    let qualities: [Int]
    let aspectRatio: Int
}

// MARK: Thumbnail convenience initializers and mutators

extension Thumbnail {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Thumbnail.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String? = nil,
        version: Int? = nil,
        domain: String? = nil,
        basePath: String? = nil,
        key: Key? = nil,
        qualities: [Int]? = nil,
        aspectRatio: Int? = nil
    ) -> Thumbnail {
        return Thumbnail(
            id: id ?? self.id,
            version: version ?? self.version,
            domain: domain ?? self.domain,
            basePath: basePath ?? self.basePath,
            key: key ?? self.key,
            qualities: qualities ?? self.qualities,
            aspectRatio: aspectRatio ?? self.aspectRatio
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Key: String, Codable {
    case imageJpg = "image.jpg"
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
