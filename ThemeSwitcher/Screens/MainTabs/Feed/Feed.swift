//
//  Feed.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 07.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

struct Feed {
    let image: UIImage.AppImage
    let name: String
    let date: String
    let text: String
}


extension Feed {
    
    static let data = [
        Feed(image: .avatar0, name: "cdybell7", date: "3:08 AM", text: "Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti."),

        Feed(image: .avatar1, name: "mvasishchev1", date: "1:34 AM", text: "Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros."),
        
        Feed(image: .avatar2, name: "abazek0", date: "10:30 AM", text: "Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus."),
        
        Feed(image: .avatar3, name: "bnorman4", date: "7:17 PM", text: "Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio."),
        
        Feed(image: .avatar4, name: "barnaldi5", date: "10:33 PM", text: "Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede."),
        
        Feed(image: .avatar5, name: "fcrufts6", date: "5:46 PM", text: "Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque."),

        Feed(image: .avatar6, name: "mberrygun8", date: "7:54 AM", text: "Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit."),
        
    ]
    
}
