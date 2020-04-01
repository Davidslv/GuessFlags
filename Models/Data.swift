//
//  Data.swift
//  GuessFlags
//
//  Created by David Silva on 01/04/2020.
//  Copyright © 2020 David Silva. All rights reserved.
//

import UIKit
import SwiftUI
import CoreLocation

let flagData: [Flag] = load("data.json")
let countries = flagData.map({ (flag) -> String in
    return flag.name
})

func findFlagByCountryName(name: String) -> String {
    let code = flagData.filter({ $0.name == name })[0].code.lowercased()
    print("name: \(name) for \(code)")
    
    return code
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


final class ImageStore {
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images: _ImageDictionary = [:]

    fileprivate static var scale = 2
    
    static var shared = ImageStore()
    
    func image(name: String) -> Image {
        let index = _guaranteeImage(name: name)
        
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(name))
    }

    static func loadImage(name: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "png"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image \(name).png from main bundle.")
        }
        return image
    }
    
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
}

struct Data_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text(flagData.filter({ $0.name == "Portugal" })[0].code.lowercased())
            Image(flagData.filter({ $0.name == "Portugal" })[0].code.lowercased())
            Image("gn")
            Image("pt")
            Image("gb-eng")
        }
    }
}
