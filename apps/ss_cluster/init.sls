include:
  - tools.supervisor
  - tools.shadowsocks

Update Shawdowsocks Server:
  file.managed:
    - name: /etc/supervisor.d/shadowsocks_server.ini
    - contents: |
       {% for server in pillar['shadowsocks']['server'] %}
           [program:shadowsocks_{{loop.index}}]
           command=/usr/local/bin/ss-server -s {{server['ip']|default('0.0.0.0')}} -p {{server['port']}} -k {{server['pass']}} -m {{server['encryption']}}
           stdout_logfile=/var/log/shadowsocks_{{loop.index}}.log
           autostart=true
           autorestart=true
           user=root
           group=root
       {% endfor %}
    - user: root
    - group: root
    - mode: 664

{% for server in pillar['shadowsocks']['server'] %}
shadowsocks_{{loop.index}}:
  supervisord:
    - running
    - restart: True
    - update: True
    - required:
      - sls: tools.supervisor
    - watch:
      - file: /etc/supervisor.d/shadowsocks_server.ini
{% endfor %}
