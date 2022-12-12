##!/usr/bin/env bash
#
## 需要在本地liquibase的lib中添加mysql驱动  witch liquibase
#liquibase   \
#    --driver=com.mysql.cj.jdbc.Driver       \
#    --changeLogFile=driver.xml              \
#    --url=jdbc:mysql://192.168.95.142:3306/maycur-finance-operation-platform  \
#    --username=plat_app   \
#    --password=Maycur@2021 \
#    --log-level=DEBUG \
#   update


# zhangling 本地  witch liquibase
#liquibase \
#  --driver=com.mysql.cj.jdbc.Driver \
#  --changeLogFile=driver.xml \
#  --url=jdbc:mysql://121.37.185.192:3306/flowable \
#  --username=root \
#  --password=zhangling03 \
#  --log-level=DEBUG \
#  update
# zhangling 本地  witch liquibase

liquibase \
  --driver=com.mysql.cj.jdbc.Driver \
  --changeLogFile=driver.xml \
  --url=jdbc:mysql://127.0.0.1:3306/maycur-finance-operation-platform \
  --username=root \
  --password=zhangling03 \
  --log-level=DEBUG \
  update