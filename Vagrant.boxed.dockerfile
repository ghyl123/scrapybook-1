Vagrant.configure("2") do |config|
        config.vm.define "docker-provider"
        config.vm.box = "scrapybook"

        # Setting up ports
        (
                [9200] +                      # ES
                [6379] +                      # Redis
                [3306] +                      # MySQL
                [9312] +                      # Web
                (6800..6803).to_a +           # Scrapyd
                [21] + (30000..30009).to_a  + # Spark
                [22]                          # ssh
        []).each do |port|
                config.vm.network "forwarded_port", guest: port, host: port
        end

        # Set the mem/cpu requirements
        config.vm.provider :virtualbox do |vb|
                vb.memory = 2048
                vb.cpus = 4
                vb.name = "docker-provider"
                vb.check_guest_additions = false
        end
end
