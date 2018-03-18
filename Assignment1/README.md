# Requirements
  1. Docker >= 17

# Contents
This directory is the build context for the docker image containing Python 2.7, MongoDB 3.4 and Apache Tomcat 7.
1. 'mongodb-org-3.4.repo' file is required for configuring the yum repository to download MongoDB 3.4
2. 'start.sh' scriptis required to ensure both MongoDB and Tomcat servers run simultaneouly
3. 'Dockerfile' to build docker image



# Instructions
After cloning the repo HDFC_Life_Assignments, execute the following commands -
  1. Change into HDFC_Life_Assignments/Assignment1 directory,
  
          cd HDFC_Life_Assignments/Assignment1
  
  2. To build the docker image,
        
          docker build -t madeshtomcat . 

  3. To run a docker container with the built docker image,
          
          docker run -p 7080:8080 -p 27017:27017 -d --name madeshtomcatcontainer madeshtomcat
  
  4. Optionally, you may attach/ connect to the docker instance using,
  
          docker exec -it madeshtomcatcontainer /bin/bash
          
Now Tomcat server and MongoDB server are accessible from the host on port '7080' and '27017' respectively.  


