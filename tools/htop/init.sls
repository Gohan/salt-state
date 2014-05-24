htop:
  pkg.latest


{% for user in pillar['users'] %}
{% set filename="/home/%s/.config/htop/htoprc"|format(user.username) %}
{{filename}}:
  file.managed:
    - contents: |
        # Beware! This file is rewritten by htop when settings are changed in the interface.
        # The parser is also very primitive, and not human-friendly.
        fields=0 48 17 18 38 39 40 2 46 47 49 1
        sort_key=46
        sort_direction=1
        hide_threads=0
        hide_kernel_threads=0
        hide_userland_threads=0
        shadow_other_users=0
        show_thread_names=1
        highlight_base_name=0
        highlight_megabytes=1
        highlight_threads=1
        tree_view=1
        header_margin=1
        detailed_cpu_time=0
        cpu_count_from_zero=0
        color_scheme=5
        delay=15
        left_meters=AllCPUs Memory Swap
        left_meter_modes=2 2 2
        right_meters=Tasks LoadAverage Uptime
        right_meter_modes=2 2 2
    - user: {{ user.username }}
    - group: {{ user.username }}
    - mode: 664
{% endfor %}