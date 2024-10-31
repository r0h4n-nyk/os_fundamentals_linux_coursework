#!/bin/bash

# list function
list_files() {

    cur_dir=`pwd`
 
    echo -e "\n Listing files in $cur_dir\n"
    ls -a | sort

}

# copy func
copy_files() {
    echo "Enter the source directory:"
    read -r source_dir
    echo "Enter the destination directory:"
    read -r dest_dir

    # Check if source directory exists
    if [ ! -d "$source_dir" ]; then
        echo "Source directory does not exist."
        return
    fi

    # Create destination directory if it does not exist
    mkdir -p "$dest_dir"

    # Copy files and directories with progress message
    echo "Copying files from $source_dir to $dest_dir..."
    cp -r "$source_dir"/* "$dest_dir" 2>/dev/null
    echo "Copy completed."
}

# Function to move files from source to destination with overwrite confirmation
move_files() {
    echo "Enter the source directory:"
    read -r source_dir
    echo "Enter the destination directory:"
    read -r dest_dir

    # Check if source directory exists
    if [ ! -d "$source_dir" ]; then
        echo "Source directory does not exist."
        return
    fi

    # Create destination directory if it does not exist
    mkdir -p "$dest_dir"

    # Move files with overwrite confirmation
    for file in "$source_dir"/*; do
        if [ -e "$dest_dir/$(basename "$file")" ]; then
            echo "File $(basename "$file") already exists in the destination. Overwrite? (y/n):"
            read -r confirm
            if [ "$confirm" != "y" ]; then
                echo "Skipping $(basename "$file")"
                continue
            fi
        fi
        mv "$file" "$dest_dir"
        echo "Moved $(basename "$file")"
    done
    echo "Move completed."
}



# delete
delete_files() {
    echo "Enter the directory from which to delete files:"
    read -r target_dir

    # Check if directory exists
    if [ ! -d "$target_dir" ]; then
        echo "Directory does not exist."
        return
    fi

    # Delete files with confirmation
    for file in "$target_dir"/*; do
        if [[ -f "$file" && "$(basename "$file")" != .* ]]; then
            echo "Delete $(basename "$file")? (y/n):"
            read -r confirm
            if [ "$confirm" == "y" ]; then
                rm "$file"
                echo "Deleted $(basename "$file")"
            else
                echo "Skipping $(basename "$file")"
            fi
        fi
    done
    echo "Deleted"
}




# Main 

while true; do
    echo -e "\nFile Management Script"
    echo "1. List"
    echo "2. Copy"
    echo "3. Move"
    echo "4. Delete"
    echo "5. Exit"
    echo -n "Choose an option: "
    read -r choice

    case $choice in
        1) list_files ;;
        2) copy_files ;;
        3) move_files ;;
        4) delete_files ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done
