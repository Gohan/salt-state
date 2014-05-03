include:
  - config.salt_minion
  - tools.python27
  
Install Mysql Depend Pkgs:
  pkg.installed:
    - pkgs:
      - "build-essential"
      - "python-dev"
      - "libmysqlclient-dev"

Install Mysql Server And Client:
  debconf.set:
    - name: mysql-server
    - data:
        'mysql-server/root_password' : {'type':'string', 'value':"{{ pillar['mysql']['root_password'] }}"}
        'mysql-server/root_password_again' : {'type':'string', 'value':"{{ pillar['mysql']['root_password'] }}"}
  pkg.installed:
    - pkgs:
      - mysql-server
      - mysql-client
    - require:
      - debconf: Install Mysql Server And Client

/etc/salt/minion.d/99.mysql_settings.conf:
  file.managed:
    - source: salt://config/salt_minion/99.mysql_settings.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        root_pass: {{ pillar["mysql"]["root_password"] }}
    - require:
      - pip: MySQL-python

MySQL-python:
  pip.installed:
    - require:
      - cmd: python-pip
      - pkg: Install Mysql Depend Pkgs
