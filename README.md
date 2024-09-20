
# Hotel App

This Flutter-based Hotel Management App allows hotel staff and guests to manage room bookings, view available rooms, and handle check-in/check-out processes. The app provides a seamless user experience with a focus on clean code and best practices in Flutter development.

## Instruction For Login
**Guest**
   email: mustak@gmail.com
   password: test123

**Guest**
   email: staff1@gmail.com
   password: staff01

## Features

1. **Login/Sign-Up**: 
   - Basic authentication for hotel staff and guests.
   - Different views and functionalities based on user roles.

2. **Room Availability**:
   - Display available rooms with details such as type, price, amenities, and booking status.
   - Filter rooms by availability, price, or type.

3. **Room Booking**:
   - Book available rooms by selecting dates and providing guest information.
   - Booking confirmation after successful submission.

4. **Check-In/Check-Out**:
   - Guests can check in and out, and the room status will be updated accordingly.

5. **Booking History**:
   - View past and upcoming bookings with room details, stay dates, and payment status.

6. **Guest Management** (For Staff Only):
   - Manage guest details, current stay status, and payment status.
   - Check-in/check-out guests and update room statuses.

7. **Profile & Settings**:
   - Update profile information and switch between dark and light modes.

## Technical Requirements

- **Database**:
  - Use SQLite or Hive for local data storage.
  - Optionally, integrate Firebase for real-time data synchronization.

- **Validation**:
  - Ensure proper input validation for forms like booking, login, and check-in/out.

- **Responsive Design**:
  - Works well on both mobile phones and tablets with adaptive layouts.

- **User Roles**:
  - Two roles: Guest and Staff, with different levels of access.

- **Error Handling**:
  - Implement error handling for database queries, validation errors, and edge cases.

## Screens

1. **Login/Sign-Up Screen**:
   - Basic authentication with role-based views for Staff and Guests.

2. **Room List Screen**:
   - Display available rooms with sorting and filtering options.

3. **Room Booking Screen**:
   - Book rooms with guest details and date selection.

4. **Booking History Screen**:
   - View past and upcoming bookings.

5. **Guest Management Screen** (For Staff Only):
   - Manage guest information, check-in/check-out, and room statuses.

6. **Profile & Settings Screen**:
   - Update profile and switch between themes.

## Setup & Installation

1. **Clone the Repository**:
   ```bash
   git clone <repository-link>
   cd hotel_app
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the App**:
   - For Android:
     ```bash
     flutter run
     ```
   - For iOS:
     ```bash
     flutter run
     ```


## External Packages Used

- **firebase_auth**: For authentication.
- **getx** or **get**: For state management.
- **firestore**: For secure data storage.


