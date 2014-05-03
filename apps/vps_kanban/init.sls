include:
  #- tools.node
  - tools.mysql

{% set config=pillar.get('apps', {}).get('vps_kanban', {}) %}
{% set user_name=config.get('database_user', {}).get('name') %}
{% set user_pass=config.get('database_user', {}).get('pass') %}
{% set present_dbs=config.get('databases',[]) %}
{% set absent_dbs=config.get('absent_databases',[]) %}

# 根据配表来新建数据库
{% for dbname in absent_dbs %}
{% set state_id="Absent Database %s"|format(dbname) %}
{{state_id}}:
  mysql_database.absent:
    - name: {{dbname}}
{% endfor %}

# 根据配表来新建数据库
{% for dbname in present_dbs %}
{% set state_id="Init Database %s"|format(dbname) %}
{{state_id}}:
  mysql_database.present:
    - name: {{dbname}}
{% if user_name is not none %}
  mysql_user.present:
    - name: {{user_name}}
    {% if user_pass is not none %}
    - password: {{user_pass}}
    {% else %}
    - allow_passwordless: True
    {% endif %}
    - host: localhost
  mysql_grants.present:
    - grant: all privileges
    - database: {{dbname}}.*
    - user: {{user_name}}
    - host: localhost
    - require:
      - mysql_database: {{state_id}}
      - mysql_user: {{state_id}}
{% endif %}
{% endfor %}

