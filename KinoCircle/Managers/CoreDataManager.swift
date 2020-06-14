//
//  CoreDataManager.swift
//  KinoCircle
//
//  Created by Jan Madera on 05/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import Foundation
import CoreData


class CoreDataManager {
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func createMovie(imdbID: String, title: String, type: String, poster: String, year: String, actors: String, director: String, plot: String, genre: String) {
        let newMovieCD = MovieCD(context: self.moc)
        newMovieCD.imdbID = imdbID
        newMovieCD.title = title
        newMovieCD.type = type
        newMovieCD.poster = poster
        newMovieCD.year = year
        newMovieCD.actors = actors
        newMovieCD.director = director
        newMovieCD.plot = plot
        newMovieCD.genre = genre
        newMovieCD.review = ""
        do{
            try self.moc.save()
        } catch {
            print(error)
        }
    }
    
    func deleteMovie(movie: MovieCD){
        do{
            try self.moc.delete(movie)
        } catch {
            print(error)
        }
    }
    
    func updateMovie(id: String, text: String){
        let movie = self.getMovie(id: id)
        
        movie.review = text
        
        do{
            try self.moc.save()
        } catch {
            print(error)
        }
    }
    
    
    
    func getMovies(tag: String) -> [MovieCD] {
        
        var movies = [MovieCD]()
        
        let movieRequest: NSFetchRequest<MovieCD> = MovieCD.fetchRequest()
        movieRequest.predicate = NSPredicate(format: "type == '\(tag)'")
        
        do  {
            movies = try self.moc.fetch(movieRequest)
        } catch let error as NSError {
            print(error)
        }
        return movies
    }
    
    func getMovie(id: String) -> MovieCD {
        
        var movies = [MovieCD]()
        
        let movieRequest: NSFetchRequest<MovieCD> = MovieCD.fetchRequest()
        movieRequest.predicate = NSPredicate(format: "imdbID == '\(id)'")
        
        do  {
            movies = try self.moc.fetch(movieRequest)
        } catch let error as NSError {
            print(error)
        }
        return movies[0]
    }
    
    func isInCoreData(tag: String, id: String) -> Bool {
        return self.getMovies(tag: tag).contains(where: { $0.imdbID == id })
    }
}

