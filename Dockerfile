# FROM : It is for specifying the base image
FROM centos:6.8

#MAINTAINER : For specifying the author
MAINTAINER Shefali Gupta

#LABEL : For providing the information about the image
LABEL Description="This is the image of CentOS 6.8 with installed Java 1.7, Python 2.7 and Tomcat 7"

#WORKDIR : Specifies the working directory for the RUN, CMD, ENTRYPOINT, COPY and ADD.
WORKDIR /home
                   
#RUN : It will run the commands mentioned in the new layer and commit the changes
#Below RUN block is updating the packages and then install the java 1.7, wget and gcc packages.
RUN yum -y update &&  \
    yum -y install java-1.7.0-openjdk && \
    yum -y install wget && \
    yum -y install gcc 

#Below RUN block is first entering into the /usr/src folder using "cd" command then through "wget" command it is downloading the python 2.7 package tar from the mentioned URL. The "tar" command extracting the Python-2.7.13.tgz to folder Python-2.7.13 and finally configuring and intalling the python commands are mentioned.
RUN wget https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz && \
    tar xzf Python-2.7.13.tgz && \
    cd Python-2.7.13 && \
    ./configure && \
    make && make altinstall   
 
#Below RUN block is first entering into the /home folder using "cd" command then through "wget" command it is downloading the tomcat7 package , untar it using tar command and renaming the apache-tomcat-7.0.75 folder to tomcat7 in the path /usr/local/ using "mv" command.
RUN wget http://www.us.apache.org/dist/tomcat/tomcat-7/v7.0.75/bin/apache-tomcat-7.0.75.tar.gz && \
    tar xzf apache-tomcat-7.0.75.tar.gz && \
    mv apache-tomcat-7.0.75 tomcat7

#EXPOSE : It will inform Docker that the container listens on the mentioned port at runtime. 
EXPOSE 8080

#ENTRYPOINT : For specifying the default executable for the image.
ENTRYPOINT ["/home/tomcat7/bin/catalina.sh", "run"]

#####################################################################################################
#For running the image
#docker build -t shefali_image .
#For running the container from the build image run the below mentioned command:
#  docker run -itd -p 7080:8080 --name shefali_container shefali_image
######################################################################################################

