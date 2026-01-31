FROM quay.io/wildfly/wildfly

# file author / maintainer
MAINTAINER "FirstName LastName" "emailaddress@gmail.com"
COPY saap.xml $JBOSS_HOME/standalone/configuration/

COPY postgresql-9.4-1206-jdbc41.jar $JBOSS_HOME/standalone/deployments/

#Copy war to deployments folder
COPY saap-ear.ear $JBOSS_HOME/standalone/deployments/

EXPOSE 8080
EXPOSE 9990
EXPOSE 8443

CMD echo $JBOSS_HOME
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0","-c","saap.xml"]

# User root to modify war owners
#USER root

# Modify owners war
#RUN chown jboss:jboss $JBOSS_HOME/standalone/deployments/saap-ear.ear

# Important, use jboss user to run image
#USER jboss
