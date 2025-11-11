#!/usr/bin/env bash
export deptrackapiKey=odt_BRpq4el8T0XqdeunYMnefniaS0n8Yxd8
export deptrackprojectName=olproperties
export deptrackprojectVersion=1.1
export sbom=olproperties.sbom.json
if
  curl -X POST "https://deptracka-dev.allarddcs.nl/api/v1/bom" \
       -H 'Content-Type: multipart/form-data; boundary=__X_BOM__' \
       -H "X-API-Key: $deptrackapiKey" \
       -F "autoCreate=true" \
       -F "projectName=$deptrackprojectName" \
       -F "projectVersion=$deptrackprojectVersion" \
       -F "bom=@olproperties.sbom.json" \
       | grep "token"
then
  echo "sbom uploaded succesfully"
else
  echo $deptrackapiKey
  echo $deptrackprojectName
  echo $deptrackprojectVersion
  echo $sbom
  echo "upload sbom failed"
  exit -1
fi
