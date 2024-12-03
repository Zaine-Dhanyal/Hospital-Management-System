#!/bin/bash

# Hospital Management System

# File paths
PATIENTS_FILE="patients.txt"
DOCTORS_FILE="doctors.txt"
APPOINTMENTS_FILE="appointments.txt"
BILLS_FILE="bills.txt"

# Function to display a decorative header
header() {
    echo "=============================================="
    echo "        Hospital Management System"
    echo "=============================================="
}

# Main menu function
main_menu() {
    while true; do
        clear
        header
        echo "1. Manage Patients"
        echo "2. Manage Doctors"
        echo "3. Manage Appointments"
        echo "4. Billing and Payment"
        echo "5. Exit"
        echo "----------------------------------------------"
        read -p "Select an option (1-5): " choice
        case $choice in
            1) manage_patients ;;
            2) manage_doctors ;;
            3) manage_appointments ;;
            4) billing_and_payment ;;
            5) exit_program ;;
            *) echo "Invalid choice! Please try again." ;;
        esac
    done
}

# Manage Patients
manage_patients() {
    while true; do
        clear
        header
        echo "1. Add New Patient"
        echo "2. View Patient Details"
        echo "3. Search Patient by ID"
        echo "4. Update Patient Information"
        echo "5. Delete Patient Record"
        echo "6. Back to Main Menu"
        echo "----------------------------------------------"
        read -p "Select an option (1-6): " choice
        case $choice in
            1) add_patient ;;
            2) view_records "$PATIENTS_FILE" "Patient" ;;
            3) search_record "$PATIENTS_FILE" "Patient" ;;
            4) update_record "$PATIENTS_FILE" "Patient" ;;
            5) delete_record "$PATIENTS_FILE" "Patient" ;;
            6) break ;;
            *) echo "Invalid choice! Please try again." ;;
        esac
    done
}

add_patient() {
    clear
    header
    read -p "Enter Patient ID: " id
    if grep -q "^$id," "$PATIENTS_FILE"; then
        echo "Patient ID already exists! Please choose another ID."
    else
        read -p "Enter Name: " name
        read -p "Enter Age: " age
        read -p "Enter Gender: " gender
        read -p "Enter Address: " address
        read -p "Enter Disease: " disease
        read -p "Enter Contact Number: " contact
        echo "$id,$name,$age,$gender,$address,$disease,$contact" >>"$PATIENTS_FILE"
        echo "Patient added successfully!"
    fi
    read -p "Press Enter to return to the menu..."
}

# Manage Doctors
manage_doctors() {
    while true; do
        clear
        header
        echo "1. Add New Doctor"
        echo "2. View Doctor Details"
        echo "3. Search Doctor by ID"
        echo "4. Update Doctor Information"
        echo "5. Delete Doctor Record"
        echo "6. Back to Main Menu"
        echo "----------------------------------------------"
        read -p "Select an option (1-6): " choice
        case $choice in
            1) add_doctor ;;
            2) view_records "$DOCTORS_FILE" "Doctor" ;;
            3) search_record "$DOCTORS_FILE" "Doctor" ;;
            4) update_record "$DOCTORS_FILE" "Doctor" ;;
            5) delete_record "$DOCTORS_FILE" "Doctor" ;;
            6) break ;;
            *) echo "Invalid choice! Please try again." ;;
        esac
    done
}

add_doctor() {
    clear
    header
    read -p "Enter Doctor ID: " id
    if grep -q "^$id," "$DOCTORS_FILE"; then
        echo "Doctor ID already exists! Please choose another ID."
    else
        read -p "Enter Name: " name
        read -p "Enter Specialty: " specialty
        read -p "Enter Experience (years): " experience
        read -p "Enter Qualification: " qualification
        read -p "Enter Contact Number: " contact
        echo "$id,$name,$specialty,$experience,$qualification,$contact" >>"$DOCTORS_FILE"
        echo "Doctor added successfully!"
    fi
    read -p "Press Enter to return to the menu..."
}

# Manage Appointments
manage_appointments() {
    while true; do
        clear
        header
        echo "1. Schedule New Appointment"
        echo "2. View Appointments"
        echo "3. Search Appointment by ID"
        echo "4. Update Appointment"
        echo "5. Cancel Appointment"
        echo "6. Back to Main Menu"
        echo "----------------------------------------------"
        read -p "Select an option (1-6): " choice
        case $choice in
            1) schedule_appointment ;;
            2) view_records "$APPOINTMENTS_FILE" "Appointment" ;;
            3) search_record "$APPOINTMENTS_FILE" "Appointment" ;;
            4) update_record "$APPOINTMENTS_FILE" "Appointment" ;;
            5) delete_record "$APPOINTMENTS_FILE" "Appointment" ;;
            6) break ;;
            *) echo "Invalid choice! Please try again." ;;
        esac
    done
}

schedule_appointment() {
    clear
    header
    read -p "Enter Appointment ID: " id
    if grep -q "^$id," "$APPOINTMENTS_FILE"; then
        echo "Appointment ID already exists! Please choose another ID."
    else
        read -p "Enter Patient ID: " patient_id
        read -p "Enter Doctor ID: " doctor_id
        read -p "Enter Appointment Date (YYYY-MM-DD): " date
        echo "$id,$patient_id,$doctor_id,$date" >>"$APPOINTMENTS_FILE"
        echo "Appointment scheduled successfully!"
    fi
    read -p "Press Enter to return to the menu..."
}

# Billing and Payment
billing_and_payment() {
    while true; do
        clear
        header
        echo "1. Generate Bill"
        echo "2. View Bills"
        echo "3. Search Bill by ID"
        echo "4. Update Bill"
        echo "5. Delete Bill"
        echo "6. Back to Main Menu"
        echo "----------------------------------------------"
        read -p "Select an option (1-6): " choice
        case $choice in
            1) generate_bill ;;
            2) view_records "$BILLS_FILE" "Bill" ;;
            3) search_record "$BILLS_FILE" "Bill" ;;
            4) update_record "$BILLS_FILE" "Bill" ;;
            5) delete_record "$BILLS_FILE" "Bill" ;;
            6) break ;;
            *) echo "Invalid choice! Please try again." ;;
        esac
    done
}

generate_bill() {
    clear
    header
    read -p "Enter Bill ID: " id
    if grep -q "^$id," "$BILLS_FILE"; then
        echo "Bill ID already exists! Please choose another ID."
    else
        read -p "Enter Patient ID: " patient_id
        read -p "Enter Total Amount: " amount
        echo "$id,$patient_id,$amount" >>"$BILLS_FILE"
        echo "Bill generated successfully!"
    fi
    read -p "Press Enter to return to the menu..."
}

# Record Management Functions
view_records() {
    clear
    header
    file=$1
    record_type=$2
    if [[ -s $file ]]; then
        echo "$record_type Records:"
        while IFS=, read -r id name attr3 attr4 attr5 attr6 attr7; do
            echo "----------------------------------------------"
            case $record_type in
                "Patient")
                    echo "Patient ID: $id"
                    echo "Name: $name"
                    echo "Age: $attr3"
                    echo "Gender: $attr4"
                    echo "Address: $attr5"
                    echo "Disease: $attr6"
                    echo "Contact: $attr7"
                    ;;
                "Doctor")
                    echo "Doctor ID: $id"
                    echo "Name: $name"
                    echo "Specialty: $attr3"
                    echo "Experience: $attr4 years"
                    echo "Qualification: $attr5"
                    echo "Contact: $attr6"
                    ;;
                "Appointment")
                    echo "Appointment ID: $id"
                    echo "Patient ID: $name"
                    echo "Doctor ID: $attr3"
                    echo "Date: $attr4"
                    ;;
                "Bill")
                    echo "Bill ID: $id"
                    echo "Patient ID: $name"
                    echo "Amount: $attr3"
                    ;;
            esac
        done <"$file"
    else
        echo "No $record_type records found."
    fi
    read -p "Press Enter to return to the menu..."
}

search_record() {
    local file=$1
    local record_type=$2
    clear
    header
    read -p "Enter $record_type ID to search: " id
    if grep -q "^$id," "$file"; then
        grep "^$id," "$file" | while IFS=, read -r id name attr3 attr4 attr5 attr6 attr7; do
            echo "----------------------------------------------"
            case $record_type in
                "Patient")
                    echo "Patient ID: $id"
                    echo "Name: $name"
                    echo "Age: $attr3"
                    echo "Gender: $attr4"
                    echo "Address: $attr5"
                    echo "Disease: $attr6"
                    echo "Contact: $attr7"
                    ;;
                "Doctor")
                    echo "Doctor ID: $id"
                    echo "Name: $name"
                    echo "Specialty: $attr3"
                    echo "Experience: $attr4 years"
                    echo "Qualification: $attr5"
                    echo "Contact: $attr6"
                    ;;
                "Appointment")
                    echo "Appointment ID: $id"
                    echo "Patient ID: $name"
                    echo "Doctor ID: $attr3"
                    echo "Date: $attr4"
                    ;;
                "Bill")
                    echo "Bill ID: $id"
                    echo "Patient ID: $name"
                    echo "Amount: $attr3"
                    ;;
            esac
        done
    else
        echo "$record_type ID not found."
    fi
    read -p "Press Enter to return to the menu..."
}

update_record() {
    local file=$1
    local record_type=$2
    clear
    header
    read -p "Enter $record_type ID to update: " id
    if grep -q "^$id," "$file"; then
        grep -v "^$id," "$file" > temp && mv temp "$file"
        case $record_type in
            "Patient") add_patient ;;
            "Doctor") add_doctor ;;
            "Appointment") schedule_appointment ;;
            "Bill") generate_bill ;;
        esac
    else
        echo "$record_type ID not found."
        read -p "Press Enter to return to the menu..."
    fi
}

delete_record() {
    local file=$1
    local record_type=$2
    clear
    header
    read -p "Enter $record_type ID to delete: " id
    if grep -q "^$id," "$file"; then
        grep -v "^$id," "$file" > temp && mv temp "$file"
        echo "$record_type record deleted successfully!"
    else
        echo "$record_type ID not found."
    fi
    read -p "Press Enter to return to the menu..."
}

exit_program() {
    echo "Exiting... Thank you!"
    exit 0
}

# Ensure required files exist
touch "$PATIENTS_FILE" "$DOCTORS_FILE" "$APPOINTMENTS_FILE" "$BILLS_FILE"

# Run the main menu
main_menu

