include:
  - tools.openssh_server

ssh:
  service:
    - running
    - enable: True
    - reload: True
    - watch:
      - file: /etc/ssh/sshd_config

/etc/ssh/sshd_config:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://config/sshd_config/sshd_config.conf
    - template: jinja
    - context: {
        port: {{ pillar['sshd_config']['ssh_server_port'] }},
    }
    - require:
      - sls: tools.openssh_server
