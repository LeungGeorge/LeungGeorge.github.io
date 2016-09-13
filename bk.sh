#!/bin/bash
cp _config.yml bk.sh ./LeungGeorge.github.io/
cp -r ./scaffolds ./source ./LeungGeorge.github.io/


location ~ ^/dashboard/tech-home/static {
	            root /home/work/orp/template;
	        }
	location = /{
	            if ( $http_host ~* "^(.*)msbutech\.baidu\.com$") {
	            rewrite ^(.*) http://msbutech.baidu.com/dashboard/tech break;
	            }
	        }