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
        
    static func create(context: NSManagedObjectContext, movie: Movie){
        let newMovieCD = MovieCD(context: context)
        newMovieCD.imdbID = movie.imdbID
        newMovieCD.title = movie.Title
        newMovieCD.type = movie.Type
        newMovieCD.poster = movie.Poster
        newMovieCD.year = movie.Year
        do{
            try context.save()
        } catch {
            print(error)
        }
    }
}
