import SwiftUI

@MainActor
public class RSVM: ObservableObject {
    
    public init(){}
    
    @Published public var playlist: Playlist = Playlist()
    
    public func createAndSaveList() {
        
        Task(priority: .medium) {
            
            let reqRes = RequestResponse()
            
            let baseURL = URL(string: "https://www.orourkeheavyindustries.com")
            
            let playlistUrlString = "/api/addplaylist"
            
            guard let playlistUrl = URL(string:playlistUrlString, relativeTo: baseURL) else { return }
            
            do {
                playlist = try await reqRes.postData(codable: Playlist.self, encode: playlist, url: playlistUrl)

            } catch {
                var debugDescription: String {
                    return "Error Desc: \(error)"
                }
                playlist.description = debugDescription
            } // end catch
            
        }
        
    }
    
}
