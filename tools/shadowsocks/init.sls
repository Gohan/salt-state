Install Shadowsocks Depend Pkgs:
  pkg.installed:
    - pkgs:
      - "build-essential"
      - "autoconf"
      - "libtool"
      - "libssl-dev"
      - "git"

Revert All:
  cmd.run:
    - name: |
        cd shadowsocks
        git checkout .
    - cwd: /usr/share/
    - onlyif: ls /usr/share/shadowsocks

Update Shadowsocks Github:
  git.latest:
    - name: https://github.com/madeye/shadowsocks-libev.git
    - target: /usr/share/shadowsocks/
    - require:
      - pkg: Install Shadowsocks Depend Pkgs
      - cmd: Revert All

Build Shadowsocks Command:
  cmd.run:
    - name: |
        ./configure
        make
        make install
    - cwd: /usr/share/shadowsocks/
    - require:
      - git: Update Shadowsocks Github

#Build Shadowsocks Command:
  #cmd.run:
    #- name: echo help
    #- cwd: /
    #- stateful: True
    #- require:
      #- git: Clone Shadowsocks Github

