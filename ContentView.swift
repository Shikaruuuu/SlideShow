//
//  ContentView.swift
//  SlideShow
//
//  Created by 横森暉 on 2021/10/20.
//

import SwiftUI

struct ContentView: View {
    //表示するイメージ
    @State private var img = photos[0].image
    //イメージ番号
    @State private var imgNum = 0
    //スライドショーを自動で行うかどうか
    @State private var isAuto = false
    //角度
    @State private var angle = 0.0
    //タイマー
    @State private var timer:Timer?
    
    var body: some View {
        return VStack{
            HStack{
                //前へボタン
                Button(action: {
                    if self.imgNum == 0 {
                        self.imgNum = photos.count - 1
                    } else {
                        self.imgNum -= 1
                    }
                    self.angle -= 360
                })
                {
                    Image(systemName: "arrowtriangle.left.circle")
                }

                //次へボタン
                Button(action: {
                    if self.imgNum + 1 >= photos.count {
                        self.imgNum = 0
                    } else {
                        self.imgNum += 1
                    }
                    self.angle += 360
                })
                {
                    Image(systemName: "arrowtriangle.right.circle")
                }
                Spacer()
                
                //自動ボタン
                Button(action: {
                    self.isAuto.toggle()
                    if self.isAuto {
                        self.timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) {
                            _ in self.angle += 360
                            if self.imgNum + 1 >= photos.count {
                                self.imgNum = 0
                            } else {
                                self.imgNum += 1
                            }
                        }
                    } else {
                        self.timer?.invalidate()
                    }
                }) {
                    HStack{
                        Image(systemName: isAuto ? "checkmark.square" : "square")
                        Text("自動")
                    }
                }
            }.padding()
            Spacer()
            
            Text(photos[self.imgNum].title)
                .font(.title)
            Image(photos[self.imgNum].image)
                .scaledToFit()
                .frame(width: 350, height: 300)
                .cornerRadius(12.0)
                .rotationEffect(.degrees(angle))
                .animation(.easeIn(duration: 1))
            
            Text("撮影日: \(photos[self.imgNum].date)")
            Text("撮影地: \(photos[self.imgNum].place)")
                .padding()
            HStack {
                ForEach(1...photos[self.imgNum].star, id: \.self){
                     _ in Image(systemName: "star.fill")
                }
                ForEach(photos[self.imgNum].star..<5, id: \.self){ _ in Image(systemName: "star")
                }
            }
            .foregroundColor(Color.orange)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
