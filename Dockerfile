# Use the Ubuntu 22.04 base image
FROM ubuntu:22.04

# Add Python 3.8 to the image
FROM python:3.8

# Set an environment variable to allow user input for image name
ENV USER_INPUT image_name

# Set another environment variable for the total number of images
ENV TOTAL_IMAGES num_of_image

# Update package lists for the Ubuntu system
RUN apt-get update

# Install the 'unzip' package
RUN apt install unzip

# Copy the Chrome Debian package to the image
COPY chrome_114_amd64.deb ./

# Install the Chrome Debian package
RUN apt install ./chrome_114_amd64.deb -y

# Download ChromeDriver binary version 114.0.5735.90 for Linux
RUN wget https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip

# Unzip the downloaded ChromeDriver binary
RUN unzip chromedriver_linux64.zip

# Move the ChromeDriver binary to /usr/bin
RUN mv chromedriver /usr/bin/chromedriver

# Print the version of Google Chrome installed
RUN google-chrome --version

# Set the working directory inside the image to /app
WORKDIR /app

# Install Selenium version 4.0.0 using pip
RUN pip install selenium==4.0.0

# Copy the requirements.txt file to /app
COPY requirements.txt /app/requirements.txt

# Install Python dependencies listed in requirements.txt
RUN pip install -r /app/requirements.txt

# Copy the Python script 'app.py' to /app
COPY app.py /app/

# Declare a volume at the specified path for persistent data storage
VOLUME <Your working directory path>
# (eg:-VOLUME /media/projects/Test)

# Specify the default command to execute when the container starts
ENTRYPOINT [ "python", "app.py"]