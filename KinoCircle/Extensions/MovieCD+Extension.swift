//
//  Movie+Extension.swift
//  KinoCircle
//
//  Created by Jan Madera on 04/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI
import CoreData

extension MovieCD: Identifiable {
    
    static func create(context: NSManagedObjectContext, movie: MovieViewModel){
        let newMovieCD = MovieCD(context: context)
        newMovieCD.imdbID = movie.imdbID
        newMovieCD.title = movie.title
        newMovieCD.type = movie.type
        newMovieCD.poster = movie.poster
        newMovieCD.year = movie.year
        do{
            try context.save()
        } catch {
            print(error)
        }
    }
}
