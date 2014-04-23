/etc/salt/minion.d/100.master_settings.conf:
  file.managed:
    - source: salt://config/salt_minion/100.master_settings.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
      salt_master: {{ pillar["salt_minion"]["salt_master"] }}

/etc/salt/minion:
  file.managed:
    - source: salt://config/salt_minion/minion.conf
    - user: root
    - group: root
    - mode: 644
