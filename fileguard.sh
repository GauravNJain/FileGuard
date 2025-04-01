#!/bin/bash

clear
# Print FileGuard ASCII
cat ./utils/ASCII.txt

# Function to generate file hash
generate_hash() {
    echo -e "\nSelect hash algorithm:"
    echo "1) MD5"
    echo "2) SHA1"
    echo "3) SHA256"
    read -p "Enter choice: " algo
    read -p "Enter file path: " file
    
    if [ ! -f "$file" ]; then
        echo "File not found!"
        return
    fi

    case $algo in
	    1) md5sum "$file" | echo -e "\nHash value of $file:  $(awk '{print $1}')" ;;
	    2) sha1sum "$file" | echo -e"\n Hash value of $file: $(awk '{print $1}')" ;;
	    3) sha256sum "$file" | echo -e "\nHash value of $file: $(awk '{print $1}')" ;;
	    *) echo "Invalid choice" ;;
    esac
}

# Function to check file integrity
check_integrity() {
    echo -e "\nSelect hash algorithm for integrity check:"
    echo "1) MD5"
    echo "2) SHA1"
    echo "3) SHA256"
    read -p "Enter choice: " algo
    read -p "Enter original file path: " file1
    read -p "Enter copied file path: " file2
    
    if [ ! -f "$file1" ] || [ ! -f "$file2" ]; then
        echo -e "\nOne or both files not found!"
        return
    fi

    case $algo in
        1) hash1=$(md5sum "$file1" | awk '{print $1}')
           hash2=$(md5sum "$file2" | awk '{print $1}') ;;
        2) hash1=$(sha1sum "$file1" | awk '{print $1}')
           hash2=$(sha1sum "$file2" | awk '{print $1}') ;;
        3) hash1=$(sha256sum "$file1" | awk '{print $1}')
           hash2=$(sha256sum "$file2" | awk '{print $1}') ;;
        *) echo "Invalid choice" ; return ;;
    esac
    
    if [ "$hash1" == "$hash2" ]; then
        echo -e "\nIntegrity valid: Files are identical."
    else
        echo -e "\nIntegrity not valid: Files differ."
    fi
}

while true; do
    echo "Select an option:"
    echo "1) Generate file hash"
    echo "2) Check file integrity"
    echo "3) Exit"
    read -p "Enter choice: " choice
    
    case $choice in
        1) generate_hash ;;
        2) check_integrity ;;
	3) echo -e "\nSee you soon. Thank youu :)"; exit 0 ;;
        *) echo "Invalid choice, try again." ;;
    esac
    echo ""
done

