#!/bin/zsh

RASA_VERSION=3.3.0a1
RASA_SDK_VERSION=3.3.0
CONDA_ENV_SUFFIX=3-3-0

. /Users/gerasimos/miniforge3/etc/profile.d/conda.sh

# Clean previously installations
conda deactivate && 
  conda env remove --name rasa-$CONDA_ENV_SUFFIX && 
  conda env create --file=rasa-3-3-0.yml --name rasa-$CONDA_ENV_SUFFIX &&
  conda activate rasa-$CONDA_ENV_SUFFIX

pip install git+file:///Users/gerasimos/3rd-repos/RasaHQ/rasa@$RASA_VERSION --no-deps
pip install git+file:///Users/gerasimos/3rd-repos/RasaHQ/rasa-sdk@$RASA_SDK_VERSION --no-deps

rm -rf rasa 2>& /dev/null
mkdir rasa
cd rasa
python -m rasa init