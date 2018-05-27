base:
  '*':
    - init.init-all

prod:
  'linux-node1.example.com':
    - shop-user.mysql-master
    - shop-user.web
    - lb-outside.haproxy-outside-keepalived
    - lb-outside.haproxy-outside


  'linux-node2.example.com':
    - shop-user.mysql-slave
    - shop-user.web
    - lb-outside.haproxy-outside-keepalived
    - lb-outside.haproxy-outside
