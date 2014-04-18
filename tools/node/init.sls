Add Node Repo:
  pkgrepo.managed:
    - ppa: chris-lea/node.js
  
Make Sure Package Is Latest:
  pkg.latest:
    - name: nodejs
    - refresh: True
    - require:
      - pkgrepo: Add Node Repo

