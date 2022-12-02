//
//  Course.swift
//  Alamofire
//
//  Created by Vasyl Larin on 29.11.2022.
//

import Foundation

struct Course: Codable {
    let name: String
    let imageUrl: String
    let numberOfLessons: Int
    let numberOfTests: Int
    
    init(name: String, imageUrl: String, numberOfLessons: Int, numberOfTests: Int) {
        self.name = name
        self.imageUrl = imageUrl
        self.numberOfLessons = numberOfLessons
        self.numberOfTests = numberOfTests
    }
    
    init(courseData: [String: Any]) {
        name = courseData["name"] as? String ?? ""
        imageUrl = courseData["imageUrl"] as? String ?? ""
        numberOfLessons = courseData["number_of_lessons"] as? Int ?? 0
        numberOfTests = courseData["number_of_tests"] as? Int ?? 0
    }
    
    init(courseJP: CourseJP) {
        name = courseJP.name
        imageUrl = courseJP.imageUrl
        numberOfLessons = Int(courseJP.numberOfLessons) ?? 0 
        numberOfTests = Int(courseJP.numberOfTests) ?? 0
    }
    
    static func getCourses(from value: Any) -> [Course] {
        guard let coursesData = value as? [[String: Any]] else { return  [] }
        return coursesData.map { Course(courseData: $0)}
    }
}

struct CourseJP: Codable {
    let name: String
    let imageUrl: String
    let numberOfLessons: String
    let numberOfTests: String
}
