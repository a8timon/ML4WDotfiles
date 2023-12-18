#!/bin/bash
_getHeader "$name" "$author"

echo "Define the label of the Apps Starter"

# Define File
targetFile="$HOME/dotfiles/waybar/modules.json"

# Define Markers
startMarker="\/\/ START APPS LABEL"
endMarker="\/\/ END APPS LABEL"

# Define Replacement Template
customtemplate="\"format\": \"VALUE\","

# Select Value
customvalue=$(gum input --placeholder="Define the Apps label")

if [ ! -z $customvalue ]; then
    # Replace in Template
    customtext="${customtemplate/VALUE/"$customvalue"}" 

    # Ensure that markers are in target file
    if grep -s "$startMarker" $targetFile && grep -s "$endMarker" $targetFile; then 

        # Write into File
        sed -i '/'"$startMarker"'/,/'"$endMarker"'/ {
        //!d
        /'"$startMarker"'/a\
        '"$customtext"'
        }' $targetFile

        # Reload Waybar
        exec $HOME/dotfiles/waybar/launch.sh 1>/dev/null 2>&1 &
        _goBack

    else 
        echo "ERROR: Marker not found."
        sleep 2
        _goBack
    fi
else 
    echo "ERROR: Define a value."
    sleep 2
    _goBack    
fi