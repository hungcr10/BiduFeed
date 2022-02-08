//
//  File.swift
//  BiduFeed
//
//  Created by CristianoDaoHung on 11/01/2022.
//
import Foundation
import UIKit
struct PostModel: Codable {
    let images: [String]
    
    enum CodingKeys: String, CodingKey {
        case images = "message"
    }
}
struct Info {
    let infoName: String
    let time: String
    let status: String
    let hangstag: String
    let avartar: String
    var imageConvert: UIImage! {
        return UIImage(named: avartar)
    }
}
struct Infomation {
    static let infomation = [
    Info(infoName: "Hồ Phương Anh", time: "12 phút trước", status: """
      Trước đây mỗi buổi sáng mở mắt dậy việc đầu
      tiên phải suy nghĩ "Mang gì đi làm"...Xem Thêm
      """, hangstag: "#Đi làm \t#Dạo phố \t\t#Phong Cách \t#Quần Tây", avartar: "avartar"),
    Info(infoName: "Hồ Phương Anh", time: "12 phút trước", status: """
        Trước đây mỗi buổi sáng mở mắt dậy việc đầu
        tiên phải suy nghĩ "Mang gì đi làm"...Xem Thêm
        """, hangstag: "#Đi làm\t#Dạo phố\t\t#Phong Cách\t#Quần Tây", avartar: "avartar"),
    Info(infoName: "Hồ Phương Anh", time: "12 phút trước", status: """
      Trước đây mỗi buổi sáng mở mắt dậy việc đầu
      tiên phải suy nghĩ "Mang gì đi làm"...Xem Thêm
      """, hangstag: "#Đi làm\t#Dạo phố\t\t#Phong Cách\t#Quần Tây", avartar: "avartar"),
    Info(infoName: "Hồ Phương Anh", time: "12 phút trước", status: """
      Trước đây mỗi buổi sáng mở mắt dậy việc đầu
      tiên phải suy nghĩ "Mang gì đi làm"...Xem Thêm
      """, hangstag: "#Đi làm\t#Dạo phố\t\t#Phong Cách\t#Quần Tây", avartar: "avartar"),
    Info(infoName: "Hồ Phương Anh", time: "12 phút trước", status: """
      Trước đây mỗi buổi sáng mở mắt dậy việc đầu
      tiên phải suy nghĩ "Mang gì đi làm"...Xem Thêm
      """, hangstag: "#Đi làm\t#Dạo phố\t\t#Phong Cách\t#Quần Tây", avartar: "avartar")]
}
