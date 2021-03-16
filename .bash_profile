#!/bin/bash

source ~/.commands

export KAFKA_TOOLS="/Users/simont/workspace/tools/confluent-5.1.0/bin"
export PYTHON_PATH="/usr/local/opt/python@3.9"

export PATH="${KAFKA_TOOLS}:$PATH"
export PATH="$PYTHON_PATH/bin:$PATH"
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
export PATH="/Users/simont/workspace/tools/docker-slim:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.7.0/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Powerline setup
export XDG_CONFIG_DIRS="$HOME/.config"
powerline-daemon -q
. /usr/local/lib/python3.9/site-packages/powerline/bindings/bash/powerline.sh

alias ll='ls -l'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export HISTCONTROL=ignoreboth:erasedups

# wget
function _wget() { curl "${1}" -o $(basename "${1}") ; };
alias wget='_wget'

export AWS_DEFAULT_REGION="eu-west-1"
export WORKSPACE_PATH=/Users/simont/workspace
export TERRAFORM_HOME=/usr/local/bin
export GOPATH=/Users/simont/workspace/go
export PATH=$PATH:$GOPATH/bin
export USERNAME=$USER   # generate windows version incase an app looks for it

# enable terraform plugin cache
mkdir -p $HOME/.terraform.d/plugin-cache
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Swagger ui preview
function swagger_yaml2json() {
  TMP_DIR="/tmp/vim-swagger-preview/"
  LOG=$TMP_DIR"validate.log"
  docker run  --rm -v $(pwd):/docs openapitools/openapi-generator-cli validate -i /docs/"$1" > $LOG 2>&1
  # ignore WARN
  sed -i '' '/ WARN /d' $LOG
  count=$(wc -l < $LOG)
  if [[ $count -gt 2 ]]; then
    # File exists and has a size greater than zero
    return 1
  else
    if grep -q "docker daemon running" $LOG; then
      return 2
    else
      # dump the stdout stderr to file otherwise the caller function complains
      docker run -v $(pwd):/docs -v $TMP_DIR:/out openapitools/openapi-generator-cli generate -i /docs/"$1" -g openapi -o /out > $LOG 2>&1
      # clear the log file
      cp /dev/null $LOG
      # https://github.com/swagger-api/swagger-codegen/issues/9140
     # docker run -v $(pwd):/docs -v $TMP_DIR:/out swaggerapi/swagger-codegen-cli-v3:3.0.9 generate -i /docs/"$1" -l openapi -o /out > /dev/null 2>&1
      return 0

    fi
  fi
}
function swagger_ui_start() {
    CONTAINER_NAME=${1:-swagger-ui-preview}
    TMP_DIR="/tmp/vim-swagger-preview/"
    # VOLUME=$(echo $(pwd) | tr "/" "_")
    if [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        if [ "$(docker ps -aq -f status=exited -f name=$CONTAINER_NAME)" ]; then
            echo $CONTAINER_NAME "exited, cleaning"
            # cleanup
            # echo removing:
            docker rm $CONTAINER_NAME
        fi
        # run the container
        docker run --name $CONTAINER_NAME -d -p 8017:8080 -e SWAGGER_JSON=/docs/openapi.json -v $TMP_DIR:/docs swaggerapi/swagger-ui
    elif [ "$(docker ps -aq -f status=running -f name=$CONTAINER_NAME)" ]; then
            echo $CONTAINER_NAME "is already running"
    fi
}
function swagger_preview() {
    TMP_DIR="/tmp/vim-swagger-preview/"
    LOG=$TMP_DIR"validate.log"
    SOURCE=${1:-swagger.yaml}
    $(swagger_yaml2json $SOURCE)
    YAML2JSON_RETURN_CODE=$?
    if [ "$YAML2JSON_RETURN_CODE" -eq "0" ]; then
      swagger_ui_start
    else
      cat $LOG
      echo "Converting to json failed! (return code: $YAML2JSON_RETURN_CODE)"
    fi
}
