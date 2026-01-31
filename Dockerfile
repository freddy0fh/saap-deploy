FROM quay.io/wildfly/wildfly:26.1.2.Final
# file author / maintainer
MAINTAINER "Freddy Castillo" "freddy.geovanni@gmail.com"
#COPY saap.xml $JBOSS_HOME/standalone/configuration/


COPY postgresql-9.4-1206-jdbc41.jar $JBOSS_HOME/standalone/deployments/

CMD mkdir -p $JBOSS_HOME/modules/system/layers/base/org/postgresql/main
COPY postgresql-9.4-1206-jdbc41.jar $JBOSS_HOME/modules/system/layers/base/org/postgresql/main/
CMD echo "<?xml version='1.0'?><module xmlns='urn:jboss:module:1.5' name='org.postgresql'><resources><resource-root path='postgresql.jar'/></resources><dependencies><module name='javax.api'/><module name='javax.transaction.api'/></dependencies></module>" > $JBOSS_HOME/modules/system/layers/base/org/postgresql/main/module.xml

#Copy war to deployments folder
COPY saap-ear.ear $JBOSS_HOME/standalone/deployments/

EXPOSE 8080
EXPOSE 9990
EXPOSE 8443

CMD echo $JBOSS_HOME
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0","-c","standalone.xml"]

# User root to modify war owners
#USER root

# Modify owners war
#RUN chown jboss:jboss $JBOSS_HOME/standalone/deployments/saap-ear.ear

# Important, use jboss user to run image
#USER jboss
