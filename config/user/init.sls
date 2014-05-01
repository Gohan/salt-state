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
{% endfor %}
