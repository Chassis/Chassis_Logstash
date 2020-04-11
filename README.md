# Logstash
  A Chassis extension to install and configure [Logstash](https://www.elastic.co/logstash) on your Chassis server.

  ## Activation
  Ensure you have a Chassis instance set up locally already.

  ```
  # In your Chassis dir:
  git clone --recursive https://github.com/Chassis/chassis_logstash.git extensions/chassis_logstash
  ```

  Then you'll need to reprovision
  ```
  cd ..
  vagrant provision
  ```

  Alternatively you can add the extension to one of your yaml config files. e.g.
  ```
# Extensions
#
# Install a list of extensions automatically
extensions:
  - chassis/chassis_logstash
  ```

  Then you'll need to reprovision

  ```
  cd ..
  vagrant provision
  ```

  Logstash has now been installed inside your Chassis box.
