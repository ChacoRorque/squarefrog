import SwiftUI

public class RequestResponse {
    
    public enum APIRequestType {
        case appleMusicAPI
        case standardAPI
    }
    
    public func postData<T: Codable>(codable: T.Type, encode: T, url: URL) async throws -> T {
        
        var data: Data
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let (dataResponse, response) = try await session.upload(
            for: request,
            from: try JSONEncoder().encode(encode)
        )
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw RequestResponseError.invalidResponse
        }
        
        data = dataResponse
        
        
        
        var errDescription: String = ""
        
        do {
            
            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            errDescription = String(data: data, encoding: .utf8) ?? "Damn it"
            
            return try decoder.decode(T.self, from: data)
            
        } catch {
            throw error
        }
        
    }
    
    
    public enum RequestResponseError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
        case custom(String)
    }
    
}
