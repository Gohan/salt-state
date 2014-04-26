include:
  - tools.supervisor
  - tools.shadowsocks

/etc/supervisor.d:
  file.directory:
    - user: root
    - group: root
    - mode: 775
    - makedirs: True

Update Shawdowsocks Server:
  file.managed:
    - name: /etc/supervisor.d/shadowsocks_server.ini
    - contents: |
       {% for server in pillar['shadowsocks']['server'] %}
         #{{loop.index}}
       {% endfor %}
    - user: root
    - group: root
    - mode: 664
    - required:
      - file: /etc/supervisor.d
