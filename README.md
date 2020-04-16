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
  
## Configuration

Chassis Logstash provides some default options you can override from your
config file(s).

```yaml
logstash:
  repo_version: '5.x'
  version: '5.5.3'
  # You may want to increase the memory limit here if you are indexing images & files.
  # Note you may also need to increase the memory limits for the VM and PHP also.
  # Value is in Megabytes.
  memory: 256
  # You can override the default JVM options here as an array. For more information
  # see the docs at https://www.elastic.co/guide/en/elasticsearch/reference/master/jvm-options.html
  jvm_options:
    # Alternative way to configure the memory heap size settings at a more granular level.
    - '-Xms256m'
    - '-Xmx256m'
```

### A note on memory usage

If you do increase the memory available to Elasticsearch you should generally ensure the VM itself has double that amount of memory to ensure all extensions and services run smoothly.

The below example gives Elasticsearch 1Gig of memory and increases the VM memory to 2Gig.

```yaml
logstash:
  memory: 1024

virtualbox:
  memory: 2048
```
