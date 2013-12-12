#!/bin/bash
# Put this script in the example/exampledocs directory of solr
# and make it executeable. This will quickly reset the data in your 
# collection to the 32 sample docs. 

wget "http://localhost:8983/solr/update?stream.body=<delete><query>*:*</query></delete>" -O /dev/null
wget "http://localhost:8983/solr/update?stream.body=<commit/>" -O /dev/null
./post.sh *.xml
