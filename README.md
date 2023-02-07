# BP-VERSION-UPGRADE-STEP

This step will help to upgrade the buildpiper version.

## Setup
* Clone the code available at [BP-VERSION-UPGRADE-STEP](https://github.com/OT-BUILDPIPER-MARKETPLACE/BP-VERSION-UPGRADE-STEP.git)
* Build the docker image
```
git submodule init
git submodule update
docker build -t ot/bp-version-upgrade:0.1 .