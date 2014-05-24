{% for user in pillar['users'] %}
{{ user.username }}:
  user.present:
    - fullname: {{ user.fullname|default('') }}
    - shell: /bin/bash
    - home: /home/{{user.username}}
    - password: {{user.password}}
    - enforce_password: False
    - home: /home/{{user.username}}
    - groups:
{% for group in user.groups %}
      - {{group}}
{% endfor %}


/home/{{ user.username }}/.profile:
  file.managed:
    - user: {{ user.username }}
    - group: {{ user.username }}
    - source: salt://config/user/skel/profile

/home/{{ user.username }}/.bashrc:
  file.managed:
    - user: {{ user.username }}
    - group: {{ user.username }}
    - source: salt://config/user/skel/bashrc

{% endfor %}

