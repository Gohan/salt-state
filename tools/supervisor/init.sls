include:
  - tools.python27

supervisor:
  pip.installed:
    - require:
      - cmd: python-pip
  file.managed:
    - name: /etc/supervisord.conf
    - source: salt://tools/supervisor/supervisord.conf
    - user: root
    - group: root
    - mode: 664

Install Supervisor Initscript:
  file.managed:
    - name: /etc/init.d/supervisord
    - source: salt://tools/supervisor/supervisord.init.conf
    - user: root
    - group: root
    - mode: 775
  cmd.run:
    - name: update-rc.d supervisord defaults
    - user: root
    - group: root
    - cwd: /
    - watch:
      - file: Install Supervisor Initscript
  service:
    - running
    - name: supervisord
    - enable: True
    - require:
      - cmd: Install Supervisor Initscript

/etc/supervisor.d:
  file.directory:
    - user: root
    - group: root
    - mode: 775
    - makedirs: True
