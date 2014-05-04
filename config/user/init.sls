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
    - contents: |
        # ~/.profile: executed by the command interpreter for login shells.
        # This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
        # exists.
        # see /usr/share/doc/bash/examples/startup-files for examples.
        # the files are located in the bash-doc package.

        # the default umask is set in /etc/profile; for setting the umask
        # for ssh logins, install and configure the libpam-umask package.
        #umask 022

        # if running bash
        if [ -n "$BASH_VERSION" ]; then
            # include .bashrc if it exists
            if [ -f "$HOME/.bashrc" ]; then
                . "$HOME/.bashrc"
            fi
        fi

        # set PATH so it includes user's private bin if it exists
        if [ -d "$HOME/bin" ] ; then
            PATH="$HOME/bin:$PATH"
        fi

        TERM=xterm-256color
{% endfor %}

