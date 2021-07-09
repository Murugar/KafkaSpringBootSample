#!/bin/sh
# https://github.com/confluentinc/schema-registry

schemaregister() {
  mvn io.confluent:kafka-schema-registry-maven-plugin:register
}

schemals() {
  echo "curl -X GET http://localhost:8081/subjects"
  curl -X GET http://localhost:8081/subjects
  echo ""
}

schemaget() {
  # MIN NUM OF ARG
  if [[ "$#" < "1" ]]; then
    echo "Usage : ${FUNCNAME[0]} SUBJECT" >&2
    return -1
  fi
  echo "curl -X GET http://localhost:8081/subjects/$1/versions/latest"
  curl -X GET http://localhost:8081/subjects/$1/versions/latest
  echo ""
}

schemaversion() {
  # MIN NUM OF ARG
  if [[ "$#" < "1" ]]; then
    echo "Usage : ${FUNCNAME[0]} SUBJECT" >&2
    return -1
  fi
  echo "curl -X GET http://localhost:8081/subjects/$1/versions"
  curl -X GET http://localhost:8081/subjects/$1/versions
  echo ""
}

schemaversionrm() {
  # MIN NUM OF ARG
  if [[ "$#" < "2" ]]; then
    echo "Usage : ${FUNCNAME[0]} SUBJECT VERSION" >&2
    return -1
  fi
  echo "curl -X DELETE http://localhost:8081/subjects/$1/versions/$2"
  curl -X DELETE http://localhost:8081/subjects/$1/versions/$2
  echo ""
}

schemaversionrmall() {
  # MIN NUM OF ARG
  if [[ "$#" < "1" ]]; then
    echo "Usage : ${FUNCNAME[0]} SUBJECT" >&2
    return -1
  fi
  echo "curl -X DELETE http://localhost:8081/subjects/$1"
  curl -X DELETE http://localhost:8081/subjects/$1
  echo ""
}
