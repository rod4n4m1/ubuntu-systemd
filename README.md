# SRE@Kyndryl

## SRE Public Tools - Ubuntu-systemd

* Version: `0.1.1`
* License: `MIT`
* Description: `Latest Ubuntu docker image with systemd enabled for using with ansible-molecule`
* Reference: [docker-ubuntu2004-ansible](https://github.com/geerlingguy/docker-ubuntu2004-ansible)

## Contents

* Folder: **main**

## Usage

* Add a target instance by adding this to `molecule.yml`

```yaml
  - name: ubuntu
    image: rod4n4m1/ubuntu-systemd:0.1.1
    tmpfs:
      - /run
      - /tmp
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:rw
    capabilities:
      - SYS_ADMIN
    command: "/lib/systemd/systemd"
    pre_build_image: true
```

* Create a scenario with this instance

`molecule create`

* Check if the instance has been created

`molecule list`

## End of Document
