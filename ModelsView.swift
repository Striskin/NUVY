//
//  Models.view.swift
//  Bluet3
//
//  Created by Alumno on 23/10/24.
//

import SwiftUI

struct Category: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var imageName: String?
    let systemImageName: String?
    var lessons: [Lesson]
}

struct Lesson: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var videoName: String
    var transcription: String
}

let categories = [
    Category(
        name: "Comida",
//        imageName: "Comida",
        imageName: nil,

        systemImageName: "fork.knife",
//        systemImageName: nil,

        lessons: [
            Lesson(title: "Lección 1: Frutas", videoName: "frutas_video", transcription: "Transcripción de las frutas"),
            Lesson(title: "Lección 2: Verduras", videoName: "verduras_video", transcription: "Transcripción de las verduras"),
            Lesson(title: "Lección 3: Bebidas", videoName: "bebidas_video", transcription: "Transcripción de las bebidas")
        ]
    ),
    Category(
        name: "Animales",
//        imageName: "Animales",
        imageName: nil,

        systemImageName: "pawprint",
        lessons: [
            Lesson(title: "Lección 1: Mamíferos", videoName: "mamiferos_video", transcription: "Transcripción de mamíferos"),
            Lesson(title: "Lección 2: Aves", videoName: "aves_video", transcription: "Transcripción de aves")
        ]
    ),
    Category(
        name: "Colores",
//        imageName: "Colores",
        imageName: nil,

        systemImageName: "paintpalette",
        lessons: [
            Lesson(title: "Lección 1: primarios", videoName: "primarios", transcription: "Transcripción de primarios"),
            Lesson(title: "Lección 2: secundarios", videoName: "secundarios", transcription: "Transcripción de secundarios")
        ]
    ),
    Category(
        name: "Trabajos",
//        imageName: "Trabajos",
        imageName: nil,

        systemImageName: "briefcase",
        lessons: [
            Lesson(title: "Lección 1: Seguridad", videoName: "mano", transcription: "Transcripción de mano"),
            Lesson(title: "Lección 2: Salud", videoName: "comunes", transcription: "Transcripción de comunes")
        ]
    ),
]
