import SwiftUI

struct ContentView: View {

    @State var color: Color = .red
    
    var body: some View {
        ScrollViewReader(content: { proxy in
            ScrollView {
                LazyVStack(spacing: 24) {
                    Text("Hey, this is an example of what I'm talking about. Tap [here](data:scroll-to-bottom) to scroll to the bottom")
                        .id("top")
                        .font(.title3)
                        .padding()
                    
                    Text("Let's change the color to [green](data:green)")
                    Text("Let's change the color to [blue](data:blue)")
                    Text("Let's change the color to [red](data:red)")
                    
                    ForEach(0..<8) { num in
                        Rectangle()
                            .fill(color)
                            .frame(height: 400)
                            .cornerRadius(12)
                            .brightness(Double(num) * -0.1)
                            .shadow(radius: 2)
                    }
                    Text("Okay… take me back to the top… [here](data:scroll-to-top) to scroll to the bottom")
                    Spacer(minLength: 30)
                        .id("bottom")
                }
                .padding()
            }
            .environment(\.openURL, .init(handler: { url in
                switch url.absoluteString {
                case "data:green":
                    color = .green
                case "data:blue":
                    color = .blue
                case "data:red":
                    color = .red
                case "data:scroll-to-top":
                    withAnimation {
                        proxy.scrollTo("top", anchor: .top)
                    }
                case "data:scroll-to-bottom":
                    withAnimation {
                        proxy.scrollTo("bottom", anchor: .bottom)
                    }
                default:
                    return .discarded
                }
                return .handled
            }))
        })
        .multilineTextAlignment(.center)
        .animation(.linear, value: color)
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
