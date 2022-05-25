# Install Rasa on Apple M1

Current Rasa version on this guide: **3.1.0**

This guide originates from this post on Rasa forum:

https://forum.rasa.com/t/an-unofficial-guide-to-installing-rasa-on-an-m1-macbook/51342

## Slow GPU performance

It seems that GPU performs slower than CPU on small data.
https://stackoverflow.com/questions/70653251/why-gpu-is-3-5-times-slower-than-the-cpu-on-apple-m1-mac

You may disable GPU either in code:

```python
tf.config.set_visible_devices([], 'GPU')
```

or by uninstalling the Metal plugin:

```shell
pip uninstall tensorflow-metal
```

## Installation

### Step 1

```shell
brew install libpq libxml2 libxmlsec1 pkg-config postgresql
```

### Step 2

```shell
cd ~/Downloads
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh
chmod +x Miniforge3-MacOSX-arm64.sh
sh Miniforge3-MacOSX-arm64.sh
#
# If you'd prefer that conda's base environment not be activated on startup, 
#   set the auto_activate_base parameter to false: 
#
# conda config --set auto_activate_base false
#
source ~/miniforge3/bin/activate
```

### Step: Clone Rasa locally (OPTIONAL)

If you are about to make tests on installation of tensforflow on M1 etc, I would recommend to locally clone [rasa](https://github.com/RasaHQ/rasa) and [rasa-sdk](https://github.com/RasaHQ/rasa-sdk) projects from github. The download time will be huge each time you try new settings.

### Step 3

```shell
wget https://github.com/gerasimos/doc-rasa-on-m1/blob/main/rasa-3-1-0.yml

conda env create --file=rasa-3-1-0.yml --name rasa-3-1-0
conda activate rasa-3-1-0

# If (you have locally cloned Rasa):
pip install git+file:///Users/gerasimos/3rd-repos/rasa@3.1.0 --no-deps
pip install git+file:///Users/gerasimos/3rd-repos/rasa-sdk@3.1.0 --no-deps
# else:
pip install git+https://github.com/RasaHQ/rasa-sdk@3.1.0 --no-deps
pip install git+https://github.com/RasaHQ/rasa.git@3.1.0 --no-deps
#

python -m rasa --version
python -m rasa init
python -m rasa train
```


## Notes

If you need to have libxml2 first in your PATH, run:
  echo 'export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"' >> ~/.zshrc

For compilers to find libxml2 you may need to set:
  export LDFLAGS="-L/opt/homebrew/opt/libxml2/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/libxml2/include"

For pkg-config to find libxml2 you may need to set:
  export PKG_CONFIG_PATH="/opt/homebrew/opt/libxml2/lib/pkgconfig"
