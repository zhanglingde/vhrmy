##!/usr/bin/env bash
#
## 需要在本地liquibase的lib中添加mysql驱动  witch liquibase

# zhangling 本地  witch liquibase
liquibase \
#  --driver=com.mysql.cj.jdbc.Driver \
  "--driver=com.mysql.jdbc.Driver" \
  "--changeLogFile=driver.xml" \
  --url=jdbc:mysql://127.0.0.1:3306/vhr \
  --username=root \
  --password=root \
  --log-level=DEBUG \
  update