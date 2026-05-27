#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

source ./.venv/bin/activate

pip install -r requirements.txt

pyinstaller --onefile \
  --name sawectl \
  --add-data "dsl.schema.json:." \
  --add-data "module.schema.json:." \
  sawectl.py

rm ./binaries/linux/sawectl

mv ./dist/sawectl ./binaries/linux/sawectl

rm "./binaries/linux/correct file/sawectl"
cp ./binaries/linux/sawectl "./binaries/linux/correct file/sawectl"

chmod +x ./binaries/linux/sawectl

rm -r dist
rm -r build
rm  ./sawectl.spec

deactivate