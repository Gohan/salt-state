base:
  "*":
    - tools.supervisor
    - tools.screen
    - config.sshd_config
    - config.timezone
    - config.sudoers
  "vultr.01.*":
    - tools.mysql
    - tools.nginx

