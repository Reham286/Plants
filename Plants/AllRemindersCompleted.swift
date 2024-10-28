import SwiftUI

struct AllRemindersCompleted: View {
    @Binding var plants: [Plant] // إضافة Binding لمصفوفة النباتات
    @Environment(\.presentationMode) var presentationMode // للتعامل مع إغلاق الصفحة
    @State private var showingNewPlantSheet = false // حالة لعرض الشيت

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("My Plants 🌱")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)

                Divider().overlay(.gray)
        
                Spacer()
                
                Image("Group")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                
                Text("All Done! 🎉")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .foregroundColor(Color(hex: "EAEAD7"))
                    .padding(.top, 10)
                
                Text("All Reminders Completed")
                    .font(.system(size: 16))
                    .foregroundColor(Color(hex: "9F9F91"))
                    .padding(.top, 5)
                Spacer()

                HStack {
                    Button(action: {
                        showingNewPlantSheet.toggle() // فتح الشيت
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color(hex: "28E0A8"))
                                .frame(width: 23, height: 23)
                            
                            Text("+")
                                .fontWeight(.bold)
                                .font(.system(size: 23))
                                .foregroundColor(.black)
                        }
                    }
                    
                    Text("New Reminder")
                        .font(.system(size: 20))
                        .foregroundColor(Color(hex: "28E0A8"))
                    
                    Spacer()
                }
                .padding(.bottom, 20)
                .padding(.leading, 20)
            }
            .padding(.horizontal, 10)
        }
        .sheet(isPresented: $showingNewPlantSheet) { // عرض الشيت عند تغيير الحالة
            NewPlants(showingSheet: $showingNewPlantSheet, plants: $plants) // تمرير النباتات إلى الشيت
        }
    }
}

struct AllRemindersCompleted_Previews: PreviewProvider {
    static var previews: some View {
        AllRemindersCompleted(plants: .constant([])) // تمرير مصفوفة فارغة
    }
}
