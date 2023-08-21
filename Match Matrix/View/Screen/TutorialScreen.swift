import SwiftUI

struct TutorialView: View {
    @Binding var screen: Int
    let namespace: Namespace.ID
    @State private var position: CGFloat = 0
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Image("Background2")
                        .resizable()
                    VStack(spacing: geometry.size.height * 0.03) {
                        Text("TUTORIAL")
                            .fontWeight(.bold)
                            .font(.system(size: geometry.size.height * 0.04))
                        VStack(alignment: .leading, spacing: geometry.size.height * 0.03) {
                            Text("GOAL:")
                                .fontWeight(.bold)
                                .font(.system(size: geometry.size.height * 0.03))
                            Text("firstGoal")
                            Text("RULES:")
                                .fontWeight(.bold)
                                .font(.system(size: geometry.size.height * 0.03))
                            HStack(alignment: .top) {
                                Text("1.")
                                Text("firstRule")
                            }
                            HStack(alignment: .top) {
                                Text("2.")
                                Text("secondRule")
                            }
                            HStack(alignment: .top) {
                                Text("3.")
                                Text("thirdRule")
                            }
                        }
                        .font(.system(size: geometry.size.height * 0.025))
                    }
                    .padding(geometry.size.width * 0.06)
                    .frame(maxHeight: .infinity)
                    .foregroundColor(.white)
                    HStack {
                        Button {
                            withAnimation {
                                screen = 1
                            }
                        } label: {
                            Image("Close")
                                .resizable()
                                .frame(width: geometry.size.width * 0.1, height: geometry.size.width * 0.1)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(geometry.size.width * 0.03)
                }
                .padding()
                Button {
                    withAnimation {
                        screen = 4
                    }
                } label: {
                    ZStack {
                        Image("Table")
                            .resizable()
                            .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.1)
                        HStack {
                            Text("CONTINUE")
                            Image(systemName: "play.fill")
                        }
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: geometry.size.width * 0.06))
                    }
                }
                .matchedGeometryEffect(id: "image1", in: namespace)
            }
            .padding()
        }
    }
}
