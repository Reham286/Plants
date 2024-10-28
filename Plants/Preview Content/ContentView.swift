import SwiftUI

struct ContentView: View {
    @State private var showingNewPlantSheet = false // حالة لتتبع عرض الشيت
    @State private var plants: [Plant] = [] // مصفوفة لتخزين النباتات

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                VStack {
                    VStack {
                        Text("My Plants 🌱")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 20)

                        Divider().overlay(.gray)
                    }

                    Spacer()

                    Image("Plants") // تأكد من وجود صورة باسم "Plants"

                    Text("Start your plant journey!")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 234/255, green: 234/255, blue: 215/255))
                        .padding(.top, 20)

                    Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 159/255, green: 159/255, blue: 145/255))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)

                    // زر لفتح الشيت أو الذهاب إلى صفحة TodayReminder
                    NavigationLink(destination: TodayReminder(plants: $plants)) {
                        Text("Set a plant Reminder")
                            .frame(width: 280, height: 40)
                            .background(Color(red: 40/255, green: 224/255, blue: 168/255))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.headline)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 60)
                    .simultaneousGesture(TapGesture().onEnded {
                        showingNewPlantSheet = true
                    })
                    .sheet(isPresented: $showingNewPlantSheet) { // عرض الشيت عند الضغط
                        NewPlants(showingSheet: $showingNewPlantSheet, plants: $plants) // تمرير مصفوفة النباتات
                    }

                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ContentView()
}
