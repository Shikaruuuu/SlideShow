//
//  GetPhotoData.swift
//  SlideShow
//
//  Created by 横森暉 on 2021/10/20.
//

import Foundation

let photos:[Photo] = getData()
let filename = "photos" // JSONファイル

func getData() -> [Photo] {
    guard let path = Bundle.main.path(forResource: filename, ofType: "json") else {
        fatalError("Couldn't find \(filename).json")
    }
    let url = URL(fileURLWithPath: path)
    // JSONデータを取得
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Couldn't parse \(url)")
    }
    //JSONデータをデコードする
    let decoder = JSONDecoder()
    let album: PhotoAlbum
    do {
        album = try decoder.decode(PhotoAlbum.self, from: data)
    }
    catch {
        fatalError("Couldn't find JSON data")
    }
    return album.photos
}

struct PhotoAlbum: Codable {
    var photos: [Photo]
}

struct Photo: Codable{
    var id: Int
    var title: String
    var image: String
    var date: String
    var place: String
    var star: Int
}


