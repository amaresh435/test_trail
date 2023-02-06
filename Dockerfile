FROM tomcat 
WORKDIR webapps 
COPY target/Test-WebApp-v2.jar .
RUN rm -rf ROOT && mv Test_WebApp-v1.jar ROOT.jar
ENTRYPOINT ["sh", "/usr/local/tomcat/bin/startup.sh"]
