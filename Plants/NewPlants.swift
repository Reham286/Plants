import SwiftUI

struct NewPlants: View {
    @Binding var showingSheet: Bool
    @Binding var plants: [Plant]
    
    @State private var plantName: String = ""
    @State private var room: String = "Bedroom"
    @State private var lightCondition: String = "Full Sun"
    @State private var wateringFrequency: String = "Every Day"
    @State private var waterAmount: String = "20-50 ml"

    let roomOptions = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let wateringOptions = ["Every Day", "Every 2 Days", "Every 3 Days", "Once a Week", "Every 10 Days", "Every 2 Weeks"]
    let waterOptions = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    let lightOptions = ["Full Sun", "Partial Sun", "Low Light"]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    headerButtons
                    
                    plantNameField
                    
                    VStack(spacing: 10) {
                        settingPicker(title: "Room", icon: "house.fill", selection: $room, options: roomOptions)
                        settingPicker(title: "Light Condition", icon: "sun.max", selection: $lightCondition, options: lightOptions)
                        settingPicker(title: "Watering Frequency", icon: "drop", selection: $wateringFrequency, options: wateringOptions)
                        settingPicker(title: "Water Amount", icon: "drop", selection: $waterAmount, options: waterOptions)
                    }

                    Spacer()
                }
                .padding()
            }
        }
    }

    private var headerButtons: some View {
        HStack {
            Button("Cancel") {
                showingSheet = false
            }
            .foregroundColor(.red)
            .font(.headline)

            Spacer()

            Text("Set Reminder")
                .font(.headline)
                .foregroundColor(.white)

            Spacer()

            Button("Save") {
                savePlantData()
            }
            .foregroundColor(.green)
            .font(.headline)
        }
        .padding()
    }

    private var plantNameField: some View {
        HStack {
            Text("Plant Name")
                .foregroundColor(.white)
            Spacer()
            TextField("Enter plant name", text: $plantName)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
        }
        .padding(.horizontal)
        .frame(width: 350)
        .padding(.bottom, 20)
    }

    private func settingPicker(title: String, icon: String, selection: Binding<String>, options: [String]) -> some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(Color.gray.opacity(0.5))
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                Spacer()
                Picker("", selection: selection) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                            .foregroundColor(.green)
                            .font(.system(size: 18))
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 130)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
        }
    }

    private func savePlantData() {
        guard !plantName.isEmpty else { return } // تأكد من وجود اسم النبات
        let newPlant = Plant(name: plantName, sunText: lightCondition, waterText: waterAmount, room: room)
        plants.append(newPlant)
        showingSheet = false
    }
}

// نموذج Plant
struct Plant: Identifiable {
    let id = UUID()
    let name: String
    let sunText: String
    let waterText: String
    let room: String
}

// إضافة Color Extension
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
