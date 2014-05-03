{% from "config/sudoers/package-map.jinja" import pkgs with context %}

sudo:
  pkg.installed:
    - name: {{ pkgs.sudo }}
#  service:
#    - running
#    - enable: True
#    - reload: True
#    - require:
#      - pkg: sudo
#    - watch:
#      - file: /etc/sudoers

/etc/sudoers:
  file.managed:
    - user: root
    - group: root
    - mode: 440
    - template: jinja
    - source: salt://config/sudoers/files/sudoers
    - context:
        included: False
    - require:
      - pkg: sudo


