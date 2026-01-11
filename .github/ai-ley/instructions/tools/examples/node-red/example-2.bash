# Pull official Docker image
docker pull nodered/node-red:latest

# Run Node-RED container
docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered nodered/node-red

# Run with local directory mount
docker run -it -p 1880:1880 -v ~/.node-red:/data --name mynodered nodered/node-red