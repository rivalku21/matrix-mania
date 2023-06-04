//
//  PopUpView.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 13/04/23.
//

import SwiftUI

struct popUpPause: View {
    @Binding var alertPause: Bool
    @Binding var timerMode: TimerMode
    @State private var position: CGFloat = 0.001
    var body: some View{
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack{
                        ZStack {
                            HStack {
                                Button {
                                    alertPause = false
                                    start()
                                } label: {
                                    Image("Close")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.08, height: geometry.size.width * 0.08)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(geometry.size.width * 0.01)
                            
                            Text("Pause")
                                .foregroundColor(.white)
                                .font(.system(size: geometry.size.height * 0.07))
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5, alignment: .center)
                    .cornerRadius(20)
                    .background(
                        Image("Background2")
                            .resizable()
                    )
                    .onAppear{
                        position = 1
                        timerMode = .paused
                    }
                    .scaleEffect(position)
                    .animation(Animation.easeInOut(duration: 0.3), value: position)
                }
            }
        }
    }
    
    func start() {
        timerMode = .running
    }
}

struct popUpDone: View {
    
    @Binding var screen: Int
    @Binding var timeRemaining: Int
    @Binding var timerMode: TimerMode
    @Binding var timeElapsed: TimeInterval
    @Binding var matrix: [Int]
    @Binding var difficulty: Int
    
    @State var timerCount: Int = 0
    
    @State private var position: CGFloat = 0.001
    var body: some View{
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack{
                        Spacer()
                        Text("You Won!!")
                            .font(.system(size: geometry.size.height * 0.04))
                            .fontWeight(.bold)
                        Spacer()
                        
                        HStack {
                            Text("Duration :")
                            Text("\(timeElapsed.formattedMilliseconds())")
                        }
                        .font(.system(size: geometry.size.width * 0.04))
                        .foregroundColor(.black)
                        
                        if difficulty == 1 {
                            Text("You Get 1 Hint")
                                .font(.system(size: geometry.size.height * 0.02))
                        } else if difficulty == 2 {
                            Text("You Get 2 Hint")
                                .font(.system(size: geometry.size.height * 0.02))
                        } else if difficulty == 3 {
                            Text("You Get 3 Hint")
                                .font(.system(size: geometry.size.height * 0.02))
                        }
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                screen = 1
                            }
                        } label: {
                            ZStack {
                                Image("Table")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.05)
                                Text("Home")
                                    .font(.system(size: geometry.size.height * 0.025))
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5, alignment: .center)
                    .cornerRadius(20)
                    .background(
                        Image("Background2")
                            .resizable()
                    )
                    .scaleEffect(position)
                    .animation(Animation.easeInOut(duration: 0.3), value: position)
                    
                    HStack(alignment: .top) {
                        if (Double(timeRemaining) > (Double(timerCount) * 0.66)){
                            Image("Star1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.35)
                                .scaleEffect(position)
                                .animation(Animation.easeIn(duration: 0.4).delay(0.3), value: position)
                        } else if (Double(timeRemaining) > (Double(timerCount) * 0.33)) {
                            Image("Star2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.35)
                                .scaleEffect(position)
                                .animation(Animation.easeIn(duration: 0.4).delay(0.3), value: position)
                        } else {
                            Image("Star3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.35)
                                .scaleEffect(position)
                                .animation(Animation.easeIn(duration: 0.4).delay(0.3), value: position)
                        }
                    }
                    .offset(y: -(geometry.size.width * 0.25))
                }
                .onAppear{
                    position = 1
                    stop()
                    var star: Int
                    
                    if difficulty == 1 {
                        timerCount = 75
                        DataController().addHint(hintAdd: 1)
                    } else if difficulty == 2 {
                        timerCount = 350
                        DataController().addHint(hintAdd: 2)
                    } else if difficulty == 3 {
                        timerCount = 999
                        DataController().addHint(hintAdd: 3)
                    }
                    
                    if (Double(timeRemaining) > (Double(timerCount) * 0.66)) {
                        star = 3
                    } else if (Double(timeRemaining) > (Double(timerCount) * 0.33)) {
                        star = 2
                    } else {
                        star = 1
                    }
                    
                    DataController().addItem(difficulty: difficulty, timeElapsed: timeElapsed, matrix: matrix, star: star)
                }
            }
        }
    }
    
    func stop() {
        timerMode = .stopped
    }
}

struct popUpStart: View {
    @Binding var isOpen: Bool
    @Binding var timerMode: TimerMode
    @State private var position: CGFloat = 0.001
    @State private var timeToStart = 3
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View{
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    ZStack{
                        Circle()
                            .foregroundColor(.blue)
                            .frame(width: geometry.size.width * 0.5)
                        
                        Circle()
                            .stroke(
                                Color.white.opacity(0.8),
                                lineWidth: geometry.size.width * 0.05)
                            .frame(width: geometry.size.width * 0.5)
                        
                        Circle()
                            .trim(from: 0, to: degreeFunc())
                            .stroke(
                                .yellow, style: StrokeStyle(lineWidth: geometry.size.width * 0.05, lineCap: .round))
                            .rotationEffect(Angle(degrees: -90))
                            .frame(width: geometry.size.width * 0.5)
                            .rotationEffect(.degrees(degreeFunc()))
                            .animation(Animation.easeInOut(duration: 0.5), value: degreeFunc())
                        
                        Text("\(timeToStart)")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: geometry.size.height * 0.09))
                            .onReceive(timer) { _ in
                                if (self.timeToStart > 0) {
                                    self.timeToStart -= 1
                                } else {
                                    timer.upstream.connect().cancel()
                                    start()
                                    isOpen.toggle()
                                }
                            }
                    }
                    .onAppear{
                        position = 1
                        playSound(name: "countdown")
                    }
                    .scaleEffect(position)
                    .animation(Animation.easeInOut(duration: 0.5), value: position)
                }
            }
        }
    }
    
    func start() {
        timerMode = .running
    }
    
    private func degreeFunc() -> Double {
        let degree = Double(timeToStart)/3
        return degree
    }
}

struct leaderBoard: View {
    @Binding var isLeaderBoard: Bool
    @Binding var isDetail: Bool
    @Binding var objectIDString: String
    
    @State private var position: CGFloat = 0.001
    @State var alertReset: Bool = false
    
    @State var matrixData: [Matrix] = DataController().items
    
    var body: some View{
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack{
                        ZStack {
                            VStack {
                                ScrollView {
                                    VStack(spacing: geometry.size.height * 0.01){
                                        ForEach(matrixData, id: \.self) { data in
                                            Button(action: {
                                                isDetail.toggle()
                                                objectIDString = DataController().stringFromObjectID(data.objectID) ?? ""
                                            }, label: {
                                                ZStack {
                                                    Image("TableLong")
                                                        .resizable()
                                                        .scaledToFit()
                                                    
                                                    HStack{
                                                        if data.difficulty == 1 {
                                                            Text("Easy")
                                                        } else if data.difficulty == 2 {
                                                            Text("Hard")
                                                        } else if data.difficulty == 3 {
                                                            Text("Very Hard")
                                                        }
                                                        Spacer()
                                                        Text(data.duration ?? "")
                                                    }
                                                    .font(.system(size: geometry.size.width * 0.05))
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal)
                                                }
                                            })
                                        }
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding(geometry.size.width * 0.01)
                                }
                                .padding(.top, geometry.size.height * 0.08)
                                .padding(.bottom, geometry.size.height * 0.01)
                                .padding(.horizontal, geometry.size.width * 0.02)
                                
                                Button {
                                    DataController().deleteAllData()
                                    matrixData = DataController().items
                                } label: {
                                    ZStack {
                                        Image("Table")
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.05)
                                        Text("DELETE ALL")
                                            .font(.system(size: geometry.size.height * 0.025))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                }
                                
                            }
                            .padding(.bottom, geometry.size.height * 0.03)
                            
                            HStack {
                                Button {
                                    withAnimation{
                                        isLeaderBoard.toggle()
                                    }
                                } label: {
                                    Image("Close")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.08, height: geometry.size.width * 0.08)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(geometry.size.width * 0.01)
                        }
                    }
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.8, alignment: .center)
                    .background {
                        Image("Background2")
                            .resizable()
                    }
                    .cornerRadius(20)
                    .onAppear{
                        position = 1
                    }
                    .scaleEffect(position)
                    .animation(Animation.easeInOut(duration: 0.3), value: position)
                }
            }
        }
    }
}

struct popBack: View {
    @Binding var alertBack: Bool
    @Binding var timerMode: TimerMode
    @Binding var screen: Int
    @State private var position: CGFloat = 0.001
    var body: some View{
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack{
                        ZStack {
                            HStack {
                                Button {
                                    alertBack = false
                                    start()
                                } label: {
                                    Image("Close")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.08, height: geometry.size.width * 0.08)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(geometry.size.width * 0.01)
                            
                            VStack {
                                Spacer()
                                Text("If you go back you lose")
                                    .foregroundColor(.white)
                                    .font(.system(size: geometry.size.height * 0.02))
                                Spacer()
                                Button {
                                    withAnimation {
                                        screen = 1
                                    }
                                } label: {
                                    ZStack {
                                        Image("Table")
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.05)
                                        Text("Home")
                                            .font(.system(size: geometry.size.height * 0.025))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5, alignment: .center)
                    .cornerRadius(20)
                    .background(
                        Image("Background2")
                            .resizable()
                    )
                    .onAppear{
                        position = 1
                        timerMode = .paused
                    }
                    .scaleEffect(position)
                    .animation(Animation.easeInOut(duration: 0.3), value: position)
                }
            }
        }
    }
    
    func start() {
        timerMode = .running
    }
}

struct shopping: View {
    @Binding var isShop: Bool
    @State private var position: CGFloat = 0.001
    
    @State var hint: Int = DataController().profile[0].hint!.intValue
    
    var body: some View{
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack{
                        ZStack {
                            VStack{
                                ZStack {
                                    Image("Hint")
                                        .resizable()
                                        .frame(width: geometry.size.height * 0.08, height: geometry.size.height * 0.08)
                                    
                                    ZStack {
                                        Circle()
                                            .fill(Color.red)
                                            .frame(width: geometry.size.height * 0.03, height: geometry.size.height * 0.03)
                                        
                                        Circle()
                                            .stroke(lineWidth: 2.0)
                                            .fill(Color.white)
                                            .frame(width: geometry.size.height * 0.03, height: geometry.size.height * 0.03)
                                        
                                        Text("\(hint)")
                                            .font(.system(size: geometry.size.height * 0.02))
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: geometry.size.height * 0.08, maxHeight: geometry.size.height * 0.08, alignment: .bottomTrailing)
                                }
                                
                                Button {
                                    DataController().addHint(hintAdd: 3)
                                    hint = DataController().profile[0].hint!.intValue
                                } label: {
                                    ZStack {
                                        Image("TableLong")
                                            .resizable()
                                        HStack {
                                            Text("3 hint")
                                            Spacer()
                                            Text("0.99$")
                                        }
                                        .padding(.horizontal)
                                        .font(.system(size: geometry.size.height * 0.025))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    }
                                }
                                .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.05)
                                
                                Button {
                                    DataController().addHint(hintAdd: 20)
                                    hint = DataController().profile[0].hint!.intValue
                                } label: {
                                    ZStack {
                                        Image("TableLong")
                                            .resizable()
                                        HStack {
                                            Text("20 hint")
                                            Spacer()
                                            Text("4.99$")
                                        }
                                        .padding(.horizontal)
                                        .font(.system(size: geometry.size.height * 0.025))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    }
                                }
                                .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.05)
                                
                                Button {
                                    DataController().addHint(hintAdd: 50)
                                    hint = DataController().profile[0].hint!.intValue
                                } label: {
                                    ZStack {
                                        Image("TableLong")
                                            .resizable()
                                        HStack {
                                            Text("50 hint")
                                            Spacer()
                                            Text("9.99$")
                                        }
                                        .padding(.horizontal)
                                        .font(.system(size: geometry.size.height * 0.025))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    }
                                }
                                .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.05)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(geometry.size.width * 0.01)
                            
                            HStack {
                                Button {
                                    withAnimation{
                                        isShop.toggle()
                                    }
                                } label: {
                                    Image("Close")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.08, height: geometry.size.width * 0.08)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(geometry.size.width * 0.01)
                        }
                    }
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.8, alignment: .center)
                    .background {
                        Image("Background2")
                            .resizable()
                    }
                    .cornerRadius(20)
                    .onAppear{
                        position = 1
                    }
                    .scaleEffect(position)
                    .animation(Animation.easeInOut(duration: 0.3), value: position)
                }
            }
        }
    }
}

struct leaderBoardDetail: View {
    @Binding var isDetail: Bool
    @Binding var dataId: String
    @State private var position: CGFloat = 0.5
    
    @State var matrixData: Matrix? = nil
    @State var matrix: [Int] = [0,0,0,0,0,0,0,0,0]
    @State var difficulty: String = ""
    
    var body: some View{
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack{
                        ZStack {
                            VStack {
                                if (matrixData?.star == 3){
                                    Image("Star1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.35)
                                } else if (matrixData?.star == 2) {
                                    Image("Star2")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.35)
                                } else if (matrixData?.star == 1) {
                                    Image("Star3")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.35)
                                }
                                
                                Grid{
                                    GridRow{
                                        ForEach (0..<3){ index in
                                            RectangleView2{
                                                Text(String(matrix[index]))
                                            }
                                        }
                                    }
                                    GridRow{
                                        ForEach (3..<6){ index in
                                            RectangleView2{
                                                Text(String(matrix[index]))
                                            }
                                        }
                                    }
                                    GridRow{
                                        ForEach (6..<9){ index in
                                            RectangleView2{
                                                Text(String(matrix[index]))
                                            }
                                        }
                                    }
                                }
                                
                                Text("Difficulty: \(difficulty)")
                                Text("Duration: \(matrixData?.duration ?? "")")
                            }
                            .padding(.top, geometry.size.height * 0.04)
                            .padding(.bottom, geometry.size.height * 0.03)
                            .padding(.horizontal, geometry.size.width * 0.1)
                            .font(.system(size: geometry.size.height * 0.04))
                            .foregroundColor(.white)
                            
                            HStack {
                                Button {
                                    withAnimation{
                                        isDetail.toggle()
                                    }
                                } label: {
                                    Image("Close")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.08, height: geometry.size.width * 0.08)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(geometry.size.width * 0.01)
                        }
                    }
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.8, alignment: .center)
                    .background {
                        Image("Background2")
                            .resizable()
                    }
                    .cornerRadius(20)
                    .onAppear{
                        position = 1
                        matrixData = DataController().getObjectByID(stringId: dataId)
                        matrix = matrixData?.matrix as! [Int]
                        
                        if matrixData?.difficulty == 1 {
                            difficulty = "Easy"
                        } else if matrixData?.difficulty == 2 {
                            difficulty = "Hard"
                        } else if matrixData?.difficulty == 3 {
                            difficulty = "Very Hard"
                        }
                    }
                    .scaleEffect(position)
                    .animation(Animation.easeInOut(duration: 0.3), value: position)
                }
            }
        }
    }
}

struct RectangleView2<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            Image("Rectangle3")
                .resizable()
                .frame(width: geometry.size.height, height: geometry.size.height)
                .overlay {
                    self.content
                }
                .font(.system(size: geometry.size.height * 0.4))
        }
        .scaledToFit()
    }
}


//struct popUp_Previews: PreviewProvider {
//    static var previews: some View {
//        leaderBoard(isLeaderBoard: .constant(true))
//    }
//}

