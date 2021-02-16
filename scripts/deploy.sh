#!/bin/bash -xe

run() {
    docker run -v "$(pwd):/transfer" -it gcr.io/${PROJECT_ID}/serverless-superset bash -c "cp /var/lib/superset/superset.tar.gz /transfer"
    tar -zxf *.tar.gz
    cd dist
    tar -zxvf apache*.tar.gz
    cd apache-superset-1.0.0
    ls -al ../../
    cat ../../requirements.txt
    #mv ../../requirements/docker.txt ../../requirements/requirements.txt
    cp ../../requirements.txt .
    cp ../../base.txt .
    cat requirements.txt
    cat ../../requirements-db.txt
    sed -i -e '$apillow==8.1.0' ../../requirements-db.txt
    cat ../../requirements-db.txt >> requirements.txt
    cat requirements.txt
    cp ../../../config/app.yaml .
    cp ../../../config/superset_config.py .
    gcloud app deploy -q
}

rm -rf .staging && mkdir .staging
sudo chmod 0777 -R .
(cd .staging && run)

