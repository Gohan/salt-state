Download The get-pip.py:
  file.managed:
    - name: "/tmp/get-pip.py"
    - source: "salt://tools/python27/get-pip.py"
    - user: root
    - group: root
    - mode: 775

python-pip:
  cmd.run:
    - name: python get-pip.py
    - cwd: /tmp
    - unless: which pip
    - require:
      - file: "Download The get-pip.py"
    - reload_modules: True
