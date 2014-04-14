include:
  - tools.python27

supervisor:
  pip.installed:
    - require:
      - cmd: python-pip
