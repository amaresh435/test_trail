FROM tomcat 
WORKDIR webapps 
COPY target/Test_WebApp-v1.jar .
RUN rm -rf ROOT && mv WebApp.war ROOT.war
ENTRYPOINT ["sh", "/usr/local/tomcat/bin/startup.sh"]
