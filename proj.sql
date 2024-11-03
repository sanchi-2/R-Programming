import tkinter as tk
from tkinter import messagebox

class SeatBookingApp:
    def _init_(self, root):
        self.root = root
        self.root.title("Movie Hall Seat Booking")
        self.root.geometry("800x400")

        # Create variables to store seat status and layout
        self.seats = [[None for _ in range(10)] for _ in range(6)]  # 6 rows, 10 columns

        # Section labels
        tk.Label(root, text="Front Section", font=("Arial", 14, "bold")).grid(row=0, columnspan=10, pady=10)
        tk.Label(root, text="Mid Section", font=("Arial", 14, "bold")).grid(row=3, columnspan=10, pady=10)
        tk.Label(root, text="Back Section", font=("Arial", 14, "bold")).grid(row=6, columnspan=10, pady=10)

        # Create a grid of buttons for seats in 3 sections (2 rows each section)
        for section in range(3):  # 3 sections
            for row in range(2):  # 2 rows per section
                for col in range(10):  # 10 seats per row
                    button = tk.Button(root, text="Available", width=8, height=2, bg="green",
                                       command=lambda s=section, r=row, c=col: self.toggle_seat_selection(s, r, c))
                    button.grid(row=section * 3 + row, column=col, padx=5, pady=5)
                    self.seats[section * 2 + row][col] = button  # Map to the correct seat in the array

        # Confirm Booking Button
        confirm_button = tk.Button(root, text="Confirm Booking", command=self.confirm_booking)
        confirm_button.grid(row=9, columnspan=5, pady=20)

        # Cancel Booking Button
        cancel_button = tk.Button(root, text="Cancel Selected", command=self.cancel_booking)
        cancel_button.grid(row=9, column=5, columnspan=5, pady=20)

        self.selected_seats = []
        self.selected_to_cancel = []

    def toggle_seat_selection(self, section, row, col):
        button = self.seats[section * 2 + row][col]
        if button["bg"] == "green":  # If the seat is available
            button.config(text="Selected", bg="yellow")
            self.selected_seats.append((section * 2 + row, col))
        elif button["bg"] == "yellow":  # If the seat is already selected
            button.config(text="Available", bg="green")
            self.selected_seats.remove((section * 2 + row, col))
        elif button["bg"] == "red":  # If the seat is booked, allow marking for cancellation
            if (section * 2 + row, col) not in self.selected_to_cancel:
                button.config(bg="orange", text="Cancel?")
                self.selected_to_cancel.append((section * 2 + row, col))
            else:
                button.config(bg="red", text="Booked")
                self.selected_to_cancel.remove((section * 2 + row, col))

    def confirm_booking(self):
        if not self.selected_seats:
            messagebox.showwarning("No Seats Selected", "Please select at least one seat to book.")
            return
        
        # Mark selected seats as booked
        for row, col in self.selected_seats:
            button = self.seats[row][col]
            button.config(text="Booked", bg="red")
        
        # Show a confirmation message
        messagebox.showinfo("Booking Confirmed", f"Seats {self.selected_seats} have been booked!")
        
        # Clear selected seats list
        self.selected_seats.clear()

    def cancel_booking(self):
        if not self.selected_to_cancel:
            messagebox.showwarning("No Seats Selected", "Please select at least one booked seat to cancel.")
            return
        
        # Cancel selected booked seats
        for row, col in self.selected_to_cancel:
            button = self.seats[row][col]
            button.config(text="Available", bg="green")
        
        # Show a confirmation message
        messagebox.showinfo("Cancellation Confirmed", f"Seats {self.selected_to_cancel} have been canceled!")
        
        # Clear the list of seats marked for cancellation
        self.selected_to_cancel.clear()

# Create the Tkinter application
root = tk.Tk()
app = SeatBookingApp(root)
root.mainloop()
