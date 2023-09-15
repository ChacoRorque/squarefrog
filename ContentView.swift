import SwiftUI

struct ContentView: View {
    
    @StateObject var rsvm = RSVM()
    
    var body: some View {
        VStack(alignment: .center){
            TextField("Playlist ID:", value: $rsvm.playlist.id, formatter: NumberFormatter())
            TextField("Playlist name:", text: $rsvm.playlist.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Playlist Description:", text: $rsvm.playlist.description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        VStack(alignment: .center){
            Spacer()
            Toggle("Public:", isOn: $rsvm.playlist.ispublic)
            Spacer()
            Button("Cancel", action: {
                
            })
            .padding()
            Spacer()
            Button("Save", action: {
                rsvm.createAndSaveList() 
                
            })
            .padding()
        }
        .frame(width: 500, height: 250)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
