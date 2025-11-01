import SwiftUI
import AVKit

struct LessonView: View {
    var lesson: Lesson
    
    var body: some View {
        VStack {
            // Video Player
            if let videoURL = Bundle.main.url(forResource: "VIDEO_FRUTAS", withExtension: "mov") {
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .frame(height: 300)
                    .padding()
            } else if let videoAsset = NSDataAsset(name: lesson.videoName) {
                if let tempURL = writeDataToTemporaryFile(data: videoAsset.data, fileName: "\(lesson.videoName).mp4") {
                    let playerItem = AVPlayerItem(url: tempURL)
                    VideoPlayer(player: AVPlayer(playerItem: playerItem))
                        .frame(height: 300)
                        .padding()
                } else {
                    Text("Video no disponible.")
                        .foregroundColor(.red)
                        .padding()
                }
            } else {
                Text("Video no disponible.")
                    .foregroundColor(.red)
                    .padding()
            }
            
            // Transcription Box
            ScrollView {
                Text(lesson.transcription)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(15)
            .padding()

            Spacer()
        }
        .navigationTitle(lesson.title)
        .background(Color(red: 173/255, green: 216/255, blue: 230/255))
        .ignoresSafeArea()
        .onAppear {
            // Call the function to print all files in the bundle
            printAllBundleFiles()
        }
    }
    
    // Helper function to write NSDataAsset to a temporary file
    func writeDataToTemporaryFile(data: Data, fileName: String) -> URL? {
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let fileURL = temporaryDirectory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Error writing video data to temporary file: \(error)")
            return nil
        }
    }

    // Function to list all files in the bundle and print their names and extensions
    func printAllBundleFiles() {
        if let resourcePath = Bundle.main.resourcePath {
            let fileManager = FileManager.default
            do {
                let items = try fileManager.contentsOfDirectory(atPath: resourcePath)
                for item in items {
                    print("Found file: \(item)")
                }
            } catch {
                print("Error listing files in bundle: \(error.localizedDescription)")
            }
        }
    }
}

struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a sample "Lesson" object for the preview
        LessonView(lesson: Lesson(title: "Sample Title", videoName: "VIDEO_FRUTAS", transcription: "This is a transcription prev."))
    }
}
