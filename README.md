# Reference
Referred to the following article.
https://qiita.com/cappyzawa/items/70db3e292b96e9fcd096

# Requirements
    ```bash
    docker --version
    Docker version 20.10.23, build 7155243

    docker-compose --version
    docker-compose version 1.25.0, build unknown
    ```

# Usage
1. Launch concourse_ci

    ```bash
    cd concourse_ci
    docker-compose up -d
    Creating network "concourse_ci_default" with the default driver
    Creating concourse_ci_concourse-db_1 ... done
    Creating concourse_ci_concourse_1    ... done
    ```

2. Download CLI Tool

  - Access to http://127.0.0.1:8080/ and download fly CLI
    ```
    chmod +x ~/Downloads/fly
    mv ~/Downloads/fly /usr/local/bin
    fly -v
    7.9.1
    ```

3. Login via CLI

    ```bash
    fly -t main login -c http://127.0.0.1:8080 -n main -u test -p test
    logging in to team 'main'


    target saved
    ```

4. Set Sample Pipeline

    ```bash
    fly -t main set-pipeline -p booklit -c ./pipeline.yml
    resources:
      resource booklit has been added:
    + name: booklit
    + source:
    +   uri: https://github.com/vito/booklit
    + type: git

    jobs:
      job unit has been added:
    + name: unit
    + plan:
    + - get: booklit
    +   trigger: true
    + - file: booklit/ci/test.yml
    +   task: test

    pipeline name: booklit

    apply configuration? [yN]: y
    pipeline created!
    you can view your pipeline here: http://127.0.0.1:8080/teams/main/pipelines/booklit

    the pipeline is currently paused. to unpause, either:
      - run the unpause-pipeline command:
        fly -t main unpause-pipeline -p booklit
      - click play next to the pipeline in the web ui
    ```

5. Unpause Sample pipeline

    Pipeline is paused by default.
    It starts when unpaused.

    ```bash
    fly -t main unpause-pipeline -p booklit
    unpaused 'booklit'
    ```

6. Check in the browser

    Access to http://127.0.0.1:8080/teams/main/pipelines/booklit