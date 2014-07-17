include:
  - tools.supervisor

Install SoftEther Depend Pkgs:
  pkg.installed:
    - pkgs:
      - "build-essential"

Supervisor stop SoftEther VPN:
  supervisord:
    - name: softether_vpn
    - dead
    - required:
      - sls: tools.supervisor

SoftEther VPN Server Installed:
  cmd.run:
    - name: |
       rm -rf softether_vpn
       wget -O softether_vpn.tar.gz http://www.softether-download.com/files/softether/v4.10-9473-beta-2014.07.12-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.10-9473-beta-2014.07.12-linux-x64-64bit.tar.gz
       tar xzvf softether_vpn.tar.gz
       rm softether_vpn.tar.gz
       mv vpnserver softether_vpn
       cd softether_vpn
       make i_read_and_agree_the_license_agreement
    - cwd: /usr/share
    - user: root
    - group: root
    - required:
      - pkg: Install SoftEther Depend Pkgs
      - supervisord: Supervisor stop SoftEther VPN

SoftEther VPN Server Init Config:
  file.managed:
    - name: /usr/share/softether_vpn/vpn_server.config
    - source: salt://apps/softether_vpn/vpn_server.config
    - template: jinja
    - context:
        IPSec_Secret: {{pillar['apps']['softether_vpn']['IPSec_Secret']}}
    - user: root
    - group: root
    - mode: 644
    - required:
      - cmd: SoftEther VPN Server Installed

Setup Supervisor configure for SoftEther VPN Server:
  file.managed:
    - name: /etc/supervisor.d/softether_vpn.ini
    - contents: |
       [program:softether_vpn]
       command=bash -c "exec /usr/share/softether_vpn/vpnserver execsvc"
       stdout_logfile=/var/log/softether_vpn.log
       autostart=true
       autorestart=true
       stopasgroup=true
       killasgroup=true
       stopsignal=KILL
       user=root
       group=root
    - user: root
    - group: root
    - mode: 664
    - required:
      - cmd: SoftEther VPN Server Installed
      - file: SoftEther VPN Server Init Config


Supervisor running SoftEther VPN:
  supervisord:
    - name: softether_vpn
    - running
    - restart: True
    - update: True
    - required:
      - sls: tools.supervisor
    - watch:
      - file: /etc/supervisor.d/softether_vpn.ini
