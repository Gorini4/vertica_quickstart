FROM metabase/metabase:latest

RUN wget -O /plugins/vertica-jdbc-9.0.1-7.jar https://www.vertica.com/client_drivers/9.0.x/9.0.1-7/vertica-jdbc-9.0.1-7.jar