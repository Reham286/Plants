import SwiftUI

struct TodayReminder: View {
    @Binding var plants: [Plant] // تعديل لقبول النباتات
    @State private var showingNewPlantSheet = false
    @State private var checkedPlants: [UUID: Bool] = [:]
    @State private var allRemindersCompleted = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 5) {
                headerSection
                Text("Today")
                    .font(.system(size: 28)).fontWeight(.bold).foregroundColor(.white)
                    .padding(.horizontal, 20).padding(.bottom, 10)
                plantList
                newPlantButton
            }
        }
        .sheet(isPresented: $showingNewPlantSheet) {
            NewPlants(showingSheet: $showingNewPlantSheet, plants: $plants) // تمرير النباتات إلى الشيت
        }
        .fullScreenCover(isPresented: $allRemindersCompleted) {
            AllRemindersCompleted(plants: $plants) // تمرير النباتات
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading) {
            Text("My Plants 🌱")
                .font(.largeTitle).fontWeight(.bold).foregroundColor(.white)
                .padding(.top, 20)
            Divider().overlay(.gray)
        }
        .padding(.horizontal, 10)
    }
    
    private var plantList: some View {
        List {
            ForEach(plants) { plant in
                HStack {
                    checkButton(for: plant)
                    VStack(alignment: .leading) {
                        plantNameRow(for: plant)
                        plantInfoRow(for: plant)
                    }
                }
                .listRowBackground(Color.black)
                .onAppear {
                    checkedPlants[plant.id] = false
                }
                .swipeActions(edge: .trailing) {
                    deleteButton(for: plant)
                    editButton(for: plant)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.black)
        .listStyle(PlainListStyle())
    }

    private func checkButton(for plant: Plant) -> some View {
        Button(action: { markCompleted(at: plant) }) {
            ZStack {
                Circle()
                    .fill(checkedPlants[plant.id] == true ? Color(hex: "28E0A8") : Color.clear)
                    .overlay(Circle().stroke(lineWidth: 1.5).foregroundColor(checkedPlants[plant.id] == true ? Color(hex: "28E0A8") : .gray))
                    .frame(width: 20, height: 20)
                if checkedPlants[plant.id] == true {
                    Image(systemName: "checkmark").foregroundColor(.black).font(.system(size: 10))
                }
            }
        }
    }

    private func markCompleted(at plant: Plant) {
        checkedPlants[plant.id]?.toggle()
        
        if checkedPlants.values.allSatisfy({ $0 == true }) {
            allRemindersCompleted = true // فتح صفحة التذكيرات المكتملة
        }
    }

    private func plantNameRow(for plant: Plant) -> some View {
        HStack {
            Text(plant.name)
                .foregroundColor(.white)
                .font(.headline)
        }
    }

    private func plantInfoRow(for plant: Plant) -> some View {
        HStack {
            infoView(icon: "sun.max", text: plant.sunText, color: Color(hex: "CCC785"))
            infoView(icon: "drop", text: plant.waterText, color: Color(hex: "CAF3FB"))
        }
        .padding(.leading, 25)
    }

    private func infoView(icon: String, text: String, color: Color) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 13))
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(color)
        }
        .padding(5).background(Color.gray.opacity(0.3)).cornerRadius(9)
    }

    private func deleteButton(for plant: Plant) -> some View {
        Button(role: .destructive) {
            if let index = plants.firstIndex(where: { $0.id == plant.id }) {
                plants.remove(at: index)
            }
        } label: {
            Label("Delete", systemImage: "trash")
        }
        .tint(.red)
    }

    private func editButton(for plant: Plant) -> some View {
        Button(action: {
            // يمكنك هنا إضافة منطق لتعديل النبات
        }) {
            Label("Edit", systemImage: "pencil")
        }
        .tint(Color.gray.opacity(0.5))
    }

    private var newPlantButton: some View {
        HStack {
            Button(action: { showingNewPlantSheet.toggle() }) {
                ZStack {
                    Circle().fill(Color(hex: "28E0A8")).frame(width: 23, height: 23)
                    Text("+").fontWeight(.bold).font(.system(size: 23)).foregroundColor(.black)
                }
            }
            Text("New Plant").font(.system(size: 20)).foregroundColor(Color(hex: "28E0A8"))
            Spacer()
        }
        .padding(.horizontal, 20).padding(.bottom, 20)
    }
}

// عرض معاينة
struct TodayReminder_Previews: PreviewProvider {
    static var previews: some View {
        let testPlants = [
            Plant(name: "Pothos", sunText: "Full Sun", waterText: "20-50 ml", room: "Bedroom"),
            Plant(name: "Monstera", sunText: "Partial Sun", waterText: "50-100 ml", room: "Kitchen")
        ]
        
        TodayReminder(plants: .constant(testPlants))
    }
}
