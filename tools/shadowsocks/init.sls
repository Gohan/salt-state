Install Shadowsocks Depend Pkgs:
  pkg.installed:
    - pkgs:
      - "build-essential"
      - "autoconf"
      - "libtool"
      - "libssl-dev"

Clone Shadowsocks Github:
  git.latest:
    - name: https://github.com/madeye/shadowsocks-libev.git
    - target: /usr/share/shadowsocks/
    - require:
      - pkg: Install Shadowsocks Depend Pkgs

Build Shadowsocks Command:
  cmd.run:
    - name: |
        ./configure
        make
        make install
    - cwd: /usr/share/shadowsocks/
    - require:
      - git: Clone Shadowsocks Github



#Build Shadowsocks Command:
  #cmd.run:
    #- name: echo help
    #- cwd: /
    #- stateful: True
    #- require:
      #- git: Clone Shadowsocks Github

