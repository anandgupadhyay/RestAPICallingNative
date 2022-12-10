//
//  Person.swift
//  DBTest
//
//  Created by Anand on 9/12/22
//

import Foundation
import UIKit

extension String {

  func convertToDate() -> String {
   
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
      if let dt = dateFormatter.date(from: self) {
          dateFormatter.dateFormat = "MM-dd-yy"
          let formatedStringDate = dateFormatter.string(from: dt)
              return formatedStringDate
      }
    
   
      return "01-01-70"
  }
}

class Person
{
    
    var name: String = ""
    var surname: String = ""
    var dob: String = ""
    var photo: String = ""
    var id: Int = 0
    
    init(id:Int, name:String, surname:String, dateOfBrith:String, photo:String)
    {
        self.id = id
        self.name = name
        self.surname = surname
        self.dob = dateOfBrith
        self.photo = photo
    }
    
    //        let dateFormatter = ISO8601DateFormatter()
    //    self.dob = dateFormatter.date(from:isoDate)!

}
