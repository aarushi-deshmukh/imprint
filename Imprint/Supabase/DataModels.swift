import Foundation

struct ProfileDB: Codable {
    let id: UUID
    let username: String?
    let fullName: String?
    let avatarURL: String?
    let bio: String?
    let createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case fullName = "full_name"
        case avatarURL = "avatar_url"
        case bio
        case createdAt = "created_at"
    }
}
