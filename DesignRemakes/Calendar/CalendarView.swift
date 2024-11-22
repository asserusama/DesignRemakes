import SwiftUI

struct CalendarView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            topBar

            monthBar
                .padding(.horizontal)

            // Horizontal Scroll for Days
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(1...31, id: \.self) { day in
                        let isSelected = day == 12 // Replace with dynamic selection logic
                        DayBox(date: day, day: dayOfWeek(for: day), isSelected: isSelected)
                    }
                }
                .padding(.horizontal)
            }

            Text("Ongoing")
                .font(.title)
                .fontWeight(.bold)

            // Vertical Scroll for Times
            ScrollView(.vertical, showsIndicators: false) {
                HStack(alignment: .top) {
                    // Time labels
                    VStack(alignment: .trailing) {
                        ForEach(0..<25, id: \.self) { hour in
                            Text("\(hour % 12 == 0 ? 12 : hour % 12) \(hour < 12 ? "AM" : "PM")")
                                .frame(height: 64)
                        }
                    }
                    .foregroundColor(.secondary)

                    // Events
                    VStack(spacing: 16) {
                        ForEach(0..<5, id: \.self) { _ in
                            CalendarEvent()
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .background(Color.blue.opacity(0.05).ignoresSafeArea())
    }

    private var monthBar: some View {
        HStack {
            Button { } label: {
                HStack {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.gray)

                    Text("Sep")
                        .foregroundColor(.primary)
                }
            }

            Spacer()

            Text("October")
                .font(.title)
                .fontWeight(.semibold)

            Spacer()

            Button { } label: {
                HStack {
                    Text("Nov")
                        .foregroundColor(.primary)

                    Image(systemName: "arrow.right")
                        .foregroundColor(.gray)
                }
            }
        }
    }

    private var topBar: some View {
        HStack {
            Button { } label: {
                Image(systemName: "arrow.left")
                    .font(.body.bold())
                    .frame(width: 40, height: 40)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray)
                    }
                    .foregroundColor(.primary)
            }

            Spacer()

            Image(systemName: "person.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
    }

    private func dayOfWeek(for day: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: 2024, month: 10, day: day)
        let date = calendar.date(from: dateComponents) ?? Date()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}

struct CalendarEvent: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Mobile App Design")
                .font(.headline)

            Text("Mike and Anita")
                .font(.subheadline)

            Spacer()

            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.title)
                Image(systemName: "person.circle.fill")
                    .font(.title)
                    .offset(x: -16)

                Spacer()

                Text("9.00 AM - 10.00 AM")
                    .font(.caption)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 128)
        .background {
            RoundedRectangle(cornerRadius: 32)
                .fill(.blue)
        }
        .foregroundColor(.white)
        .padding(.leading)
    }
}

struct DayBox: View {
    let date: Int
    let day: String
    let isSelected: Bool

    var body: some View {
        VStack {
            Text("\(date)")
                .font(.title)
                .fontWeight(.semibold)

            Text(day)
                .fontWeight(.light)
        }
        .frame(width: 72, height: 100)
        .background {
            RoundedRectangle(cornerRadius: 32)
                .fill(isSelected ? Color.blue : Color.white)
        }
        .foregroundColor(isSelected ? Color.white : Color.blue)
        .clipped()
        .shadow(color: Color.blue.opacity(0.3), radius: isSelected ? 0 : 3)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
