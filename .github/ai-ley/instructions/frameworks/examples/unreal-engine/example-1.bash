# Download Epic Games Launcher from official website
# https://www.unrealengine.com/download

# For Linux (via Lutris or Native):
sudo apt update
sudo apt install build-essential
git clone https://github.com/EpicGames/UnrealEngine.git --depth=1

# Generate project files (Linux)
./Setup.sh
./GenerateProjectFiles.sh
make