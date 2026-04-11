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
}
