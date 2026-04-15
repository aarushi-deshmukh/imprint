import Foundation
import Supabase

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let client = SupabaseConfig.client
    
    private init() {}
    
    func signUp(email: String, password: String) async throws {
        try await client.auth.signUp(
            email: email,
            password: password
        )
    }
    
    func login(email: String, password: String) async throws {
        try await client.auth.signIn(
            email: email,
            password: password
        )
    }
    
    func logout() async throws {
        try await client.auth.signOut()
    }
    
    func createProfile(username: String, fullName: String, bio: String) async throws {
        guard let user = client.auth.currentUser else {
            throw NSError(domain: "NoUser", code: 401)
        }
        
        try await client
            .from("profiles")
            .insert([
                "id": user.id.uuidString,
                "username": username,
                "full_name": fullName,
                "bio": bio
            ])
            .execute()
    }
    
    func uploadAvatar(imageData: Data) async throws -> String {
        let fileName = "\(UUID().uuidString).jpg"
        
        try await client.storage
            .from("avatars")
            .upload(
                fileName,
                data: imageData,
                options: .init(contentType: "image/jpeg")
            )
        
        let publicURL = try client.storage
            .from("avatars")
            .getPublicURL(path: fileName)
        
        return publicURL.absoluteString
    }
    
    
}
