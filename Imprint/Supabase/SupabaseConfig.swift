import Foundation
import Supabase

enum SupabaseConfig {
    
    static let url: URL = {
        guard let url = URL(string: "https://gtiakjvwodyszdwbjlsx.supabase.co") else {
            fatalError("Invalid Supabase URL")
        }
        return url
    }()
    
    static let anonKey: String = {
        return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd0aWFranZ3b2R5c3pkd2JqbHN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzU5MzI0MjksImV4cCI6MjA5MTUwODQyOX0.-JsVEbBow0ikvy5AEgC2AM6WDzkBJg71b4NvE1fEXkY"
    }()
    
    static let client: SupabaseClient = {
        SupabaseClient(
            supabaseURL: url,
            supabaseKey: anonKey
        )
    }()
}
