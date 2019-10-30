#!/usr/bin/env ruby
# Module for Vagrant VirtualBox Guest Additions configuration settings.
# https://github.com/dotless-de/vagrant-vbguest
# The module servers only as a namespace for vagrant-vbguest plugin operations.

module VbGuest
    extend self

    @@config = nil

    def conf(config, host)
        set_config(config)
        if host.key?(:vbguest)
            additions(host[:vbguest])
        end
    end

    def set_config(value)
        @@config = value
    end

    def config
        @@config
    end

    private

        def additions(vbguest={})
            vbguest.each do |key, value|
                if key == :iso
                    config_iso(value)
                else
                    eval "config.vbguest.#{key} = vbguest[key]"
                end
            end
        end

        def config_iso(options={})
            options.each_key do |key|
                eval "config.vbguest.iso_#{key} = options[key]"
            end
        end
end
