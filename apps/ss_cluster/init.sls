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
           [program:shadowsocks_{{loop.index}}]
           command=/usr/local/bin/ss-server -s 0.0.0.0 -p {{server['port']}} -k {{server['pass']}} -m {{server['encryption']}}
           stdout_logfile=/var/log/shadowsocks_{{loop.index}}.log
           autostart=true
           autorestart=true
           user=gohan
           group=gohan
       {% endfor %}
    - user: root
    - group: root
    - mode: 664
    - required:
      - file: /etc/supervisor.d

{% for server in pillar['shadowsocks']['server'] %}
shadowsocks_{{loop.index}}:
  supervisord:
    - running
    - required:
      - sls: tools.supervisor
    - watch:
      - file: /etc/supervisor.d/shadowsocks_server.ini
{% endfor %}